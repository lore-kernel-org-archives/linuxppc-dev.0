Return-Path: <mgreer@mvista.com>
Date: Thu, 15 Mar 2007 15:35:29 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
Message-ID: <20070315223529.GA1314@mag.az.mvista.com>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.810C1DDF1B@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070305032452.810C1DDF1B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 05, 2007 at 02:24:52PM +1100, David Gibson wrote:

Hi David,

<snip>

> Index: working-2.6/arch/powerpc/boot/ops.h
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/ops.h	2007-02-19 14:01:38.000000000 +1100
> +++ working-2.6/arch/powerpc/boot/ops.h	2007-02-19 14:01:43.000000000 +1100

<snip>

> @@ -100,4 +106,8 @@ static inline void exit(void)
>  	for(;;);
>  }
>  
> +#define BSS_STACK(size) \
> +	static char _bss_stack[size]; \
> +	void *_platform_stack_top = _bss_stack + sizeof(_bss_stack);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
>  #endif /* _PPC_BOOT_OPS_H_ */

Statically initializing _platform_stack_top (or any variable) won't
work when you download/run the zImage at a location different than
where its linked at.  Yes, I know the image is "relocatable" but that
doesn't work for addresses put into variables/structs at link time
like this one.  That type of assignment has to be done at runtime.

What happens is the linker puts 0x0040_1234, say, into
_platform_stack_top but when you download the image to 0x0080_0000
it still has a value of 0x0040_1234 even though its running at
0x00800_0000+.

I think there's at least one more biting me in either yours
or Scott's patches that I'm looking for now.

Mark
