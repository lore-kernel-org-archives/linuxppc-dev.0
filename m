Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18686.42209.47915.184451@cargo.ozlabs.ibm.com>
Date: Wed, 22 Oct 2008 14:58:25 +1100
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: build failure on powerpc with current -git
In-Reply-To: <20081021191324.d4810d40.sfr@canb.auug.org.au>
References: <48F8E86B.702@nortel.com>
	<18685.27030.529655.761257@cargo.ozlabs.ibm.com>
	<20081021191324.d4810d40.sfr@canb.auug.org.au>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell writes:

> On Tue, 21 Oct 2008 16:33:10 +1100 Paul Mackerras <paulus@samba.org> wrote:
> >
> > It's a bug in older versions of ld (including 2.16.1) that's fixed in
> > the current version (2.18).  However, this patch appears to work
> > around the problem - at least, it let me build a 32-bit kernel with a
> > cross-toolchain including a 2.16.1 ld.  Let me know if this gets it
> > working for you.
> 
> With that patch applied I got these errors for a powerpc ppc64_defconfig
> build (linux-next).
> 
> /usr/bin/objcopy: Warning: '/dev/null' is not an ordinary file

Hmmm, so do I, and in fact the arch/powerpc/boot/wrapper change now
seems to be unnecessary with my cross-compile setup (which has ld
2.16.1), whereas yesterday I'm sure it got errors.  Weird.

Chris, could you try just the following change (my previous patch
without the arch/powerpc/boot/wrapper change) and let me know if it
fixes things with the ld you use?

Paul.
---
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index b39c27e..384dca5 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -187,6 +187,7 @@ SECTIONS
 		*(.machine.desc)
 		__machine_desc_end = . ;
 	}
+#ifdef CONFIG_RELOCATABLE
 	. = ALIGN(8);
 	.dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET) { *(.dynsym) }
 	.dynstr : AT(ADDR(.dynstr) - LOAD_OFFSET) { *(.dynstr) }
@@ -202,6 +203,7 @@ SECTIONS
 		__rela_dyn_start = .;
 		*(.rela*)
 	}
+#endif
 
 	/* Fake ELF header containing RPA note; for addnote */
 	.fakeelf : AT(ADDR(.fakeelf) - LOAD_OFFSET) { *(.fakeelf) }
