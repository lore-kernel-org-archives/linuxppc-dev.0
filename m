Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17733.31929.136137.129244@cargo.ozlabs.ibm.com>
Date: Mon, 30 Oct 2006 15:16:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [RFC] bootwrapper: prevent fdt from being overwritten by kernel
In-Reply-To: <20061026225045.GA19839@mag.az.mvista.com>
References: <20061026225045.GA19839@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> If the fdt that's wrapped in a zImage isn't edited, it will still be
> sitting in the zImage when the kernel boots
> (i.e., at 0x400000 + <some offset into the zImage>).
> 
> That's okay until you get a large enough kernel (e.g., initramfs)
> which will overwrite the fdt when the kernel is relocated to 0.

Oops :)

> To handle that, I changed the sandpoint.c:platform_init() to base the
> simple_alloc heap at the greater of either the end of the zImage or the end
> of the kernel once its decompressed & relocated to 0.  It then copies
> the dtb to an area allocated by simple_alloc so I know its safe from
> being overwritten.

That sounds reasonable.

> In addition, I moved the vmlinux elf header decompress code from
> prep_kernel() to its own routine and called it before platform_init.
> I then pass the elf header ptr into platform_init.  That way,
> platform_init can figure out where the end of the kernel will
> be and put the dtb beyond it.  The OF code can now change
> claim_base in platform_init instead of needing the platform_ops.image_hdr
> hook.

Hmmm.  What if platform_init needs to e.g. turn on caches or do other
things that need to be done before decompressing?  I think it's
important to provide some way for the platform code to do things
really early on.

Paul.
