Date: Mon, 9 Jul 2001 20:48:08 +0200
From: Olaf Hering <olh@suse.de>
To: Jeff Rugen <jprugen@earthlink.net>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: RTC and SCSI for PowerStack/2.4.6 Kernel
Message-ID: <20010709204808.A12487@suse.de>
References: <20010709075703.G825@opus.bloom.county> <Pine.LNX.4.21.0107090842230.1593-100000@raptor.earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
In-Reply-To: <Pine.LNX.4.21.0107090842230.1593-100000@raptor.earthlink.net>; from jprugen@earthlink.net on Mon, Jul 09, 2001 at 09:20:21AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, Jeff Rugen wrote:

> I did have VGA console be the default, and installed clgenfb as a module.

Is there a way to rmmod the module later?
The colors are wrong in X whit >8bit and the console is slow with fbcon :)

> On a related note, the endianness issue with gpm seems to also show up
> when running the VGA console -- any text that is written to a non-visible
> virtual terminal is not byte-swapped, so it appears to be garbage when you
> switch back to that virtual terminal.  This isn't a problem when running
> clgenfb as the terminal though (I don't know how gpm worked in either
> mode).

The attached patch fix that, but it seems to be wrong.
Geert said the shadow buffer is stored in native endian. The VGA text
console itself is the "shadow buffer" for the foreground console and
little endian.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="y_ppc_2.4.5_vga_console.diff"

--- linux-2.4.5/include/asm-ppc/vga.h	Tue May 22 00:02:06 2001
+++ linux-2.4.5.vgafix/include/asm-ppc/vga.h	Mon May 28 11:50:48 2001
@@ -15,11 +15,11 @@

 #include <linux/config.h>

-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
+#if defined(CONFIG_VGA_CONSOLE)

 #define VT_BUF_HAVE_RW
 /*
- *  These are only needed for supporting VGA or MDA text mode, which use little
+ *  These are only needed for supporting VGA text mode, which use little
  *  endian byte ordering.
  *  In other cases, we can optimize by using native byte ordering and
  *  <linux/vt_buffer.h> has already done the right job for us.
@@ -38,7 +38,11 @@
 #define VT_BUF_HAVE_MEMCPYW
 #define scr_memcpyw	memcpy

-#endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */
+#define VT_BUF_HAVE_MEMCPYF
+#define scr_memcpyw_from memcpy
+#define scr_memcpyw_to memcpy
+
+#endif /* CONFIG_VGA_CONSOLE */

 extern unsigned long vgacon_remap_base;
 #define VGA_MAP_MEM(x) (x + vgacon_remap_base)

--VS++wcV0S1rZb1Fb--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
