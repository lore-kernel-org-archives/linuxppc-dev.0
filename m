Date: Tue, 29 Jan 2002 16:08:43 +0000 (GMT)
From: Leigh Brown <leigh@solinno.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>, <hollis@austin.ibm.com>,
	Sven Dickert <Sven.Dickert@planb.de>
Subject: Re: /proc/residual (CONFIG_PREP_PROCRESIDUAL)
In-Reply-To: <20020128160822.GH19960@opus.bloom.county>
Message-ID: <Pine.LNX.4.33.0201291556160.3031-100000@fridge.solinno.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom,

On Mon, 28 Jan 2002, Tom Rini wrote:

> Hey all.  Here's a version of the /proc/residual patch (originally by
> David Monro, updated for 2.4 by Sven Dickert) vs current 2_4_devel.
> This is slightly different than the previous versions that've been
> floating around:
> 1) It can't be a module now.  After talking to Al Viro, doing /proc
> stuff in a module correctly is a giant PITA (it wasn't working in the
> previous versions I don't think...)
> 2) Use __initcall() instead of editing fs/proc/root.c.  This should make
> it easier to run past Marcelo/Linus, since it only touches PPC-specific
> things (and the help file).
> 3) I cleaned up the DPRINTK() macros slightly in a few places.
>
> In some quick testing on my machine, I always got the same image file
> (md5'ed).  Can a few more people try this and make sure it still works
> for them?  Thanks.

[...]

It works for me.  The comment needs to be changed to say it can't be a
module.  I've attached the version I came up with, mainly because I went
to some trouble to do it.  Differences:

1. Stuck on the end of residual.c 'coz it's hardly worth it's own file
2. Remove #ifdef __KERNEL__ from header file for use space utility
3. Use create_proc_read_entry 'coz it's simpler (which is best, I dunno?)
4. Only create entry if residual size > 0 'coz what you can't see won't
   hurt you + eliminate chance of people wondering why they are getting an
   error trying to read it.
5. Fix a couple of typos

Cheers,

Leigh.



diff -uNr -X /home/leigh/.diffex MASTER/linuxppc_2_4_devel/Documentation/Configure.help linuxppc_2_4_devel-140/Documentation/Configure.help
--- MASTER/linuxppc_2_4_devel/Documentation/Configure.help	Mon Jan 28 20:27:49 2002
+++ linuxppc_2_4_devel-140/Documentation/Configure.help	Tue Jan 29 12:54:59 2002
@@ -14410,8 +14410,15 @@
   other useful pieces of information.  Sometimes this information is
   not present or incorrect.

-  Unless you expect to boot on a PReP system, there is not need to
+  Unless you expect to boot on a PReP system, there is no need to
   select Y.
+
+PReP residual data available in /proc/residual
+CONFIG_PROC_PREPRESIDUAL
+  Enabling this option will create a /proc/residual file which allows
+  you to get at the residual data on PReP systems.  You will need a tool
+  (lsresidual) to parse it.  If you aren't on a PReP system, you don't
+  want this.

 /dev file system support
 CONFIG_DEVFS_FS
diff -uNr -X /home/leigh/.diffex MASTER/linuxppc_2_4_devel/arch/ppc/config.in linuxppc_2_4_devel-140/arch/ppc/config.in
--- MASTER/linuxppc_2_4_devel/arch/ppc/config.in	Mon Jan 28 20:24:43 2002
+++ linuxppc_2_4_devel-140/arch/ppc/config.in	Tue Jan 29 12:53:56 2002
@@ -393,6 +393,7 @@
   bool 'Support for Open Firmware device tree in /proc' CONFIG_PROC_DEVICETREE
   bool 'Support for RTAS (RunTime Abstraction Services) in /proc' CONFIG_PPC_RTAS
   bool 'Support for PReP Residual Data' CONFIG_PREP_RESIDUAL
+  dep_bool '  Support for reading of PReP Residual Data in /proc' CONFIG_PROC_PREPRESIDUAL $CONFIG_PREP_RESIDUAL
 fi

 bool 'Default bootloader kernel arguments' CONFIG_CMDLINE_BOOL
diff -uNr -X /home/leigh/.diffex MASTER/linuxppc_2_4_devel/arch/ppc/platforms/residual.c linuxppc_2_4_devel-140/arch/ppc/platforms/residual.c
--- MASTER/linuxppc_2_4_devel/arch/ppc/platforms/residual.c	Mon Jan 28 20:26:53 2002
+++ linuxppc_2_4_devel-140/arch/ppc/platforms/residual.c	Tue Jan 29 12:45:32 2002
@@ -876,3 +876,38 @@
 	};
 	return 0; /* not found */
 }
+
+#ifdef CONFIG_PROC_PREPRESIDUAL
+static int proc_prep_residual_read(char * buf, char ** start, off_t off,
+		int count, int *eof, void *data)
+{
+	int n;
+
+	n = res->ResidualLength - off;
+	if (n < 0) {
+		*eof = 1;
+		n = 0;
+	}
+	else {
+		if (n > count)
+			n = count;
+		else
+			*eof = 1;
+
+		memcpy(buf, (char *)res + off, n);
+		*start = buf;
+	}
+
+	return n;
+}
+
+void __init
+proc_prep_residual_init(void)
+{
+	if (res->ResidualLength)
+		create_proc_read_entry("residual", S_IRUGO, NULL,
+					proc_prep_residual_read, NULL);
+}
+
+__initcall(proc_prep_residual_init);
+#endif
diff -uNr -X /home/leigh/.diffex MASTER/linuxppc_2_4_devel/include/asm-ppc/residual.h linuxppc_2_4_devel-140/include/asm-ppc/residual.h
--- MASTER/linuxppc_2_4_devel/include/asm-ppc/residual.h	Mon Jan 28 20:27:37 2002
+++ linuxppc_2_4_devel-140/include/asm-ppc/residual.h	Tue Jan 29 12:47:50 2002
@@ -13,7 +13,6 @@
 /*             i.e. only one bit is on for each enum                          */
 /* Reserved fields must be filled with zeros.                                */

-#ifdef __KERNEL__
 #ifndef _RESIDUAL_
 #define _RESIDUAL_

@@ -334,4 +333,3 @@
 #endif /* __ASSEMBLY__ */
 #endif  /* ndef _RESIDUAL_ */

-#endif /* __KERNEL__ */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
