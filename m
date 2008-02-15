Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 1D449DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 12:07:51 +1100 (EST)
Date: Fri, 15 Feb 2008 12:05:28 +1100
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 3/8] pseries: phyp dump: use sysfs to release reserved mem
Message-ID: <20080215010528.GI6887@bakeyournoodle.com>
References: <47B13D2E.1070001@austin.ibm.com> <47B146BE.5010807@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <47B146BE.5010807@austin.ibm.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2008 at 01:11:58AM -0600, Manish Ahuja wrote:

<snip>

> +static ssize_t
> +show_release_region(struct kset * kset, char *buf)
> +{
> +	return sprintf(buf, "ola\n");
> +}
> +
> +static struct subsys_attribute rr = __ATTR(release_region, 0600,
> +					 show_release_region,
> +					 store_release_region);

Any reason this sysfs attribute can't be write only? The show method
doesn't seem needed.

> +static int __init phyp_dump_setup(void)
> +{

<snip>

> +	/* Is there dump data waiting for us? */
> +	rtas = of_find_node_by_path("/rtas");
> +	dump_header = of_get_property(rtas, "ibm,kernel-dump", &header_len);

Hmm this isn't good.  You need to check rtas != NULL.

> +	if (dump_header == NULL) {
> +		release_all();
> +		return 0;
> +	}
> +
> +	/* Should we create a dump_subsys, analogous to s390/ipl.c ? */
> +	rc = subsys_create_file(&kernel_subsys, &rr);
> +	if (rc) {
> +		printk (KERN_ERR "phyp-dump: unable to create sysfs file (%d)\n", rc);
> +		release_all();
> +		return 0;
> +	}
>  
>  	return 0;
>  }
> -
>  subsys_initcall(phyp_dump_setup);

Hmm I think this really should be a:
	machine_subsys_initcall(pseries, phyp_dump_setup)

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
