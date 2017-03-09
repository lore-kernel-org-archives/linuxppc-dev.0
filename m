Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vf6fh6nw9zDqZ8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 21:52:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: sachinp@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: Re: [FIX PATCH v1] powerpc/pseries: Fix reference count leak during
 CPU unplug
In-Reply-To: <1489034268-24888-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1489034268-24888-1-git-send-email-bharata@linux.vnet.ibm.com>
Date: Thu, 09 Mar 2017 21:52:27 +1100
Message-ID: <87wpbyk9hw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bharata B Rao <bharata@linux.vnet.ibm.com> writes:

> The following warning is seen when a CPU is hot unplugged on a PowerKVM
> guest:
>
> refcount_t: underflow; use-after-free.
...
>
> Fix this by ensuring that of_node_put() is called only from the
> error path in dlpar_cpu_remove_by_index(). In the normal path,
> of_node_put() happens as part of dlpar_detach_node().

Don't we have the same bug in mobility.c ?

static int delete_dt_node(__be32 phandle)
{
	struct device_node *dn;

	dn = of_find_node_by_phandle(be32_to_cpu(phandle));
	if (!dn)
		return -ENOENT;

	dlpar_detach_node(dn);
	of_node_put(dn);
	return 0;
}

> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 7bc0e91..c5ed510 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -619,7 +619,8 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
>  	}
>  
>  	rc = dlpar_cpu_remove(dn, drc_index);
> -	of_node_put(dn);
> +	if (rc)
> +		of_node_put(dn);
>  	return rc;
>  }
>  
> @@ -856,9 +857,12 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>  	}
>  
>  	rc = dlpar_cpu_remove(dn, drc_index);
> -	of_node_put(dn);
> -
> -	return rc ? rc : count;
> +	if (rc) {
> +		of_node_put(dn);
> +		return rc;
> +	} else {
> +		return count;
> +	}
>  }


Which makes me think that the bug is actually that dlpar_detach_node()
should not be dropping the last reference on behalf of its caller. It
means that the caller has a pointer to a freed dn, which is wrong.

eg. A caller could do:

  dlpar_detach_node(dn);
  printk("detached %s\n", dn->name);

But dn will have been freed by the time the printk happens.


The problem is we call dlpar_detach_node() recursively, and for the
child nodes it *does* need to drop the last reference, because that's
the whole point. So it needs some refactoring.

I also notice there's no error checking on the removal of the child
nodes, which is pretty dubious:

	child = of_get_next_child(dn, NULL);
	while (child) {
		dlpar_detach_node(child);
		child = of_get_next_child(dn, child);
	}


cheers
