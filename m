Return-Path: <pmladek@suse.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 065EB1A045E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 02:49:27 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7855E14130E
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 02:49:25 +1100 (AEDT)
Date: Thu, 3 Mar 2016 16:49:21 +0100
From: Petr Mladek <pmladek@suse.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz,
 Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH][v3] Enable livepatching on powerpc
Message-ID: <20160303154921.GF22171@pathway.suse.cz>
References: <1457010715-21092-1-git-send-email-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457010715-21092-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 2016-03-04 00:11:55, Balbir Singh wrote:
> 
> Changelog v3:
> 	1. Moved -ENOSYS to -EINVAL in klp_write_module_reloc
> 	2. Moved klp_matchaddr to use ftrace_location_range

Ah, I have been working on it in parallel. It took me longer
because I was busy with some other stuff previous days.

I am going to send slightly updated version in a bit. I will
address there some comments, see below.

> diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
> new file mode 100644
> index 0000000..9ecd879
> --- /dev/null
> +++ b/arch/powerpc/include/asm/livepatch.h
> @@ -0,0 +1,41 @@
> +
> +extern int klp_write_module_reloc(struct module *mod, unsigned long type,
> +				   unsigned long loc, unsigned long value);

Nit, we do not use "extern" in the livepatch-related headers.

> +
> +static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
> +{
> +	regs->nip = ip;
> +}
> +
> +#endif /* CONFIG_LIVEPATCH */

As Mirek already pointed out. We would like to have here:

#else  /* CONFIG_LIVEPATCH */
#error Include linux/livepatch.h, not asm/livepatch.h
#endif  /* CONFIG_LIVEPATCH */

> +#endif /* _ASM_POWERPC64_LIVEPATCH_H */


> diff --git a/arch/powerpc/kernel/livepatch.c b/arch/powerpc/kernel/livepatch.c
> new file mode 100644
> index 0000000..8c99e2d
> --- /dev/null
> +++ b/arch/powerpc/kernel/livepatch.c
> @@ -0,0 +1,54 @@
> +/**
> + * klp_write_module_reloc() - write a relocation in a module
> + * @mod:       module in which the section to be modified is found
> + * @type:      ELF relocation type (see asm/elf.h)
> + * @loc:       address that the relocation should be written to
> + * @value:     relocation value (sym address + addend)
> + *
> + * This function writes a relocation to the specified location for
> + * a particular module.
> + */
> +int klp_write_module_reloc(struct module *mod, unsigned long type,
> +			    unsigned long loc, unsigned long value)
> +{
> +	/* This requires infrastructure changes; we need the loadinfos. */
> +	pr_err("klp_write_module_reloc not yet supported\n");
> +	return -EINVAL;

I agree that -ENOSYS is a bit misleading. But -EINVAL is not ideal
either. Anyway, we should stay compatible with the other architectures
in this patch.

> +}
> +
> +int klp_matchaddr(struct ftrace_ops *ops, unsigned long ip,
> +				int remove, int reset)
> +{
> +	int ret = 1;
> +	unsigned long correct_ip;
> +
> +	correct_ip = ftrace_location_range(ip, ip + 16);

I really like that it is so easy in the end.

> +	if (!correct_ip)
> +		goto done;
> +
> +	ret = ftrace_set_filter_ip(ops, correct_ip, remove, reset);

I do not like that we hide this important operation under a function
called klp_matchaddr(). I am going to rename this function to
klp_get_ftrace_location() and just return the address found
by ftrace_location_range(). Another advantage is that it will
make one-liner from this arch-specific function.

> +done:
> +	return ret;
> +}
> +

Thanks a lot for pushing this forward,
Petr
