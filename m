Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com (charlotte.tuxdriver.com [70.61.120.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E803B70AB
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 01:26:55 +1000 (EST)
Date: Mon, 26 Jul 2010 11:23:15 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	vgoyal@redhat.com, hbabu@us.ibm.com, benh@kernel.crashing.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Add vmcoreinfo symbols to allow makdumpfile to
	filter core files properly
Message-ID: <20100726152315.GA18789@hmsreliant.think-freely.org>
References: <20100713134609.GA14514@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100713134609.GA14514@hmsreliant.think-freely.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 13, 2010 at 09:46:09AM -0400, Neil Horman wrote:
> Hey all-
> 	About 2 years ago now, I sent this patch upstream to allow makedumpfile
> to properly filter cores on ppc64:
> http://www.mail-archive.com/kexec@lists.infradead.org/msg02426.html
> It got acks from the kexec folks so I pulled it into RHEL, but I never checked
> back here to make sure it ever made it in, which apparently it didn't.  It still
> needs to be included, so I'm reposting it here, making sure to copy all the ppc
> folks this time.  I've retested it on the latest linus kernel and it works fine,
> allowing makedumpfile to find all the symbols it needs to properly strip a
> vmcore on ppc64.
> 
> Neil
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
Ping, anyone want to chime in on this, its needed for dump filtering to work
properly on ppc64
Neil

> 
>  machine_kexec.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> 
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index bb3d893..0df7031 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -45,6 +45,18 @@ void machine_kexec_cleanup(struct kimage *image)
>  		ppc_md.machine_kexec_cleanup(image);
>  }
>  
> +void arch_crash_save_vmcoreinfo(void)
> +{
> +
> +#ifdef CONFIG_NEED_MULTIPLE_NODES
> +	VMCOREINFO_SYMBOL(node_data);
> +	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
> +#endif
> +#ifndef CONFIG_NEED_MULTIPLE_NODES
> +	VMCOREINFO_SYMBOL(contig_page_data);
> +#endif
> +}
> +
>  /*
>   * Do not allocate memory (or fail in any way) in machine_kexec().
>   * We are past the point of no return, committed to rebooting now.
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
