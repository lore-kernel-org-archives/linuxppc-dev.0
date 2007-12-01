Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6008DDDDFF
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 16:11:26 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] Add machine initcall macros
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20071201002437.22923.31304.stgit@trillian.secretlab.ca>
References: <20071201002437.22923.31304.stgit@trillian.secretlab.ca>
Content-Type: text/plain
Date: Sat, 01 Dec 2007 16:10:58 +1100
Message-Id: <1196485858.13230.123.camel@pasglop>
Mime-Version: 1.0
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-30 at 17:24 -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> The machine initcall macros allow initcalls to be registered which
> test machine_is() before executing the initcall.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Ben, is this the sort of thing you're considering?

Exactly. You can add core and postcore while at it, I had use for them
in the past :-)

I'll look into turning that into magic ELF sections later, but in the
meantime, that gives us a nice solid API for use by BSPs.

Thanks !

Ben.

> g.
> 
>  include/asm-powerpc/machdep.h |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
> index 6968f43..f24af06 100644
> --- a/include/asm-powerpc/machdep.h
> +++ b/include/asm-powerpc/machdep.h
> @@ -326,5 +326,24 @@ static inline void log_error(char *buf, unsigned int err_type, int fatal)
>  		ppc_md.log_error(buf, err_type, fatal);
>  }
>  
> +#define __define_machine_initcall(mach,level,fn,id) \
> +	static int __init __machine_initcall_##mach##_##fn(void) { \
> +		if (machine_is(mach)) return fn(); \
> +		return 0; \
> +	} \
> +	__define_initcall(level,__machine_initcall_##mach##_##fn,id);
> +
> +#define machine_arch_initcall(mach,fn)		__define_machine_initcall(mach,"3",fn,3)
> +#define machine_arch_initcall_sync(mach,fn)	__define_machine_initcall(mach,"3s",fn,3s)
> +#define machine_subsys_initcall(mach,fn)	__define_machine_initcall(mach,"4",fn,4)
> +#define machine_subsys_initcall_sync(mach,fn)	__define_machine_initcall(mach,"4s",fn,4s)
> +#define machine_fs_initcall(mach,fn)		__define_machine_initcall(mach,"5",fn,5)
> +#define machine_fs_initcall_sync(mach,fn)	__define_machine_initcall(mach,"5s",fn,5s)
> +#define machine_rootfs_initcall(mach,fn)	__define_machine_initcall(mach,"rootfs",fn,rootfs)
> +#define machine_device_initcall(mach,fn)	__define_machine_initcall(mach,"6",fn,6)
> +#define machine_device_initcall_sync(mach,fn)	__define_machine_initcall(mach,"6s",fn,6s)
> +#define machine_late_initcall(mach,fn)		__define_machine_initcall(mach,"7",fn,7)
> +#define machine_late_initcall_sync(mach,fn)	__define_machine_initcall(mach,"7s",fn,7s)
> +
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_MACHDEP_H */
