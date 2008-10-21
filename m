Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18685.27030.529655.761257@cargo.ozlabs.ibm.com>
Date: Tue, 21 Oct 2008 16:33:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: build failure on powerpc with current -git
In-Reply-To: <48F8E86B.702@nortel.com>
References: <48F8E86B.702@nortel.com>
Cc: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen writes:

> The current -git fails to build on 64-bit powerpc (failure log below) . 
>   Initially I tried using my older toolchain, when I first saw the 
> problem I built a new toolchain with crosstool (gcc 4.1.2 and binutils 
> 2.16.1) and tried again but got the same problem.

It's a bug in older versions of ld (including 2.16.1) that's fixed in
the current version (2.18).  However, this patch appears to work
around the problem - at least, it let me build a 32-bit kernel with a
cross-toolchain including a 2.16.1 ld.  Let me know if this gets it
working for you.

Paul.

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 25fe9d6..e8acee2 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -284,6 +284,8 @@ if [ -n "$dtb" ]; then
     if [ -n "$dts" ]; then
 	rm $dtb
     fi
+else
+    addsec $tmp /dev/null .kernel:dtb
 fi
 
 if [ "$platform" != "miboot" ]; then
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
