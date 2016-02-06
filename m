Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CEAFB1A0193
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 12:10:00 +1100 (AEDT)
Date: Fri, 5 Feb 2016 17:09:58 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Phil Turmel <philip@turmel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Bisected Regression 4.3.5 => 4.4.1 booting HP ZBook in EFI mode
Message-ID: <20160206010958.GA2205@kroah.com>
References: <56B518C4.8030007@turmel.org> <20160205222936.GA7139@kroah.com>
 <56B53344.3090300@turmel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B53344.3090300@turmel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 05, 2016 at 06:41:56PM -0500, Phil Turmel wrote:
> On 02/05/2016 05:29 PM, Greg Kroah-Hartman wrote:
> > On Fri, Feb 05, 2016 at 04:48:52PM -0500, Phil Turmel wrote:
> 
> >> I'm stumped as to how that powerpc patch can affect my x86 laptop, an
> >> HP ZBook 17 w/ i7 processor & nouveau graphics, but it certainly
> >> does.  The bisect was stable and I confirmed by reverting it on
> >> top of the intended v4.4.1.
> > 
> > That's crazy, nothing should even be rebuilt if you revert that patch,
> > so I don't see how that could affect things here.
> 
> I thought so too, but ...
> 
> > Can you verify that nothing does get rebuilt when you do this?
> 
> # git checkout v4.4.1
> 
> # make -j15
> ////// lots of output ///////
> 
> # make
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CHK     include/generated/bounds.h
>   CHK     include/generated/timeconst.h
>   CHK     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CHK     kernel/config_data.h
> Kernel: arch/x86/boot/bzImage is ready  (#133)
>   Building modules, stage 2.
>   MODPOST 1166 modules
> 
> # git revert badc688
> ////// trimmed commit log ///////
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> # make
>   CHK     include/config/kernel.release
>   UPD     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   UPD     include/generated/utsrelease.h
>   CHK     include/generated/bounds.h
>   CHK     include/generated/timeconst.h
>   CHK     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   CC      kernel/sys.o
>   CC      kernel/trace/trace.o
>   LD      kernel/trace/built-in.o
>   CC      kernel/module.o
>   CHK     kernel/config_data.h
>   LD      kernel/built-in.o
>   CC      drivers/base/firmware_class.o
>   LD      drivers/base/built-in.o
>   CC      drivers/gpu/drm/i915/i915_gpu_error.o
>   LD      drivers/gpu/drm/i915/i915.o
>   LD      drivers/gpu/drm/i915/built-in.o
>   LD      drivers/gpu/drm/built-in.o
>   LD      drivers/gpu/built-in.o
>   CC      drivers/target/target_core_configfs.o
>   LD      drivers/target/target_core_mod.o
>   LD      drivers/target/built-in.o
>   CC [M]  drivers/vhost/scsi.o
>   LD [M]  drivers/vhost/vhost_scsi.o
>   LD      drivers/built-in.o
>   LINK    vmlinux
>   LD      vmlinux.o
>   MODPOST vmlinux.o
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   KSYM    .tmp_kallsyms1.o
>   KSYM    .tmp_kallsyms2.o
>   LD      vmlinux
>   SORTEX  vmlinux
>   SYSMAP  System.map
>   VOFFSET arch/x86/boot/voffset.h
>   OBJCOPY arch/x86/boot/compressed/vmlinux.bin
>   LZMA    arch/x86/boot/compressed/vmlinux.bin.lzma
>   MKPIGGY arch/x86/boot/compressed/piggy.S
>   AS      arch/x86/boot/compressed/piggy.o
>   LD      arch/x86/boot/compressed/vmlinux
>   ZOFFSET arch/x86/boot/zoffset.h
>   AS      arch/x86/boot/header.o
>   CC      arch/x86/boot/version.o
>   LD      arch/x86/boot/setup.elf
>   OBJCOPY arch/x86/boot/setup.bin
>   OBJCOPY arch/x86/boot/vmlinux.bin
>   BUILD   arch/x86/boot/bzImage
> Setup is 15564 bytes (padded to 15872 bytes).
> System is 26558 kB
> CRC 29b78b83
> Kernel: arch/x86/boot/bzImage is ready  (#134)
>   Building modules, stage 2.
>   MODPOST 1166 modules
> 
> //////
> So, a handful of items in the main kernel get
> rebuilt, including i915 stuff.  This laptop does
> have the intel graphics base with nvidia layered
> on top.
> 
> The build proceeded to redo all my modules, shown below.

Ah, you have versioned modules / builds enabled, that's what caused the
rebuild, if you disable CONFIG_MODVERSIONS and
CONFIG_MODULE_SRCVERSION_ALL you shouldn't rebuild everything.

If those options are disabled, then something really odd is going on
here...

thanks,

greg k-h
