Date: Wed, 30 Jan 2002 20:47:46 +0000 (GMT)
From: Leigh Brown <leigh@solinno.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: <hollis@austin.ibm.com>, <linuxppc-dev@lists.linuxppc.org>,
	Sven Dickert <Sven.Dickert@planb.de>
Subject: Re: /proc/residual (CONFIG_PREP_PROCRESIDUAL)
In-Reply-To: <20020129220337.GG25973@opus.bloom.county>
Message-ID: <Pine.LNX.4.33.0201302035520.7307-100000@fridge.solinno.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom,

On Tue, 29 Jan 2002, Tom Rini wrote:

> On Tue, Jan 29, 2002 at 09:47:02PM +0000, Leigh Brown wrote:
>
> > On Tue, 29 Jan 2002 hollis@austin.ibm.com wrote:
> >
> > > On Tue, Jan 29, 2002 at 04:08:43PM +0000, Leigh Brown wrote:
[...]
> > > > 2. Remove #ifdef __KERNEL__ from header file for use space utility
> > >
> > > This encourages user applications to include kernel header files, which has
> > > been deemed ungood. I believe there should be many lengthy threads on the
> > > subject in the lkml archives, but more practically speaking Paul has said he'd
> > > be perfectly happy if all kernel headers were completely protected from user
> > > space.
> >
> > Surely that can't be true.  What about asm/errno.h?  I thought you just
> > put #ifdef __KERNEL__ around stuff you don't want to export to user space.
> > In the case of asm/residual.h it all needs to be exported to user space.
> > The alternative is to simply clone the file, which seems a bit silly.
>
> There's a few legacy files which unfortunatly can't be clamped down on.
> In general you are supposed to copy the file and be done with it.  In
> fact, if I ever wanted to read the residual image from my PReP box
> (usually off) on my x86 (which I'm typing on right now), I'd need to do
> this anyways since x86 won't have '<asm/residual.h>'.

That's a fairly contrived example but I'm not going to argue.  I'm
amending lsresidual to use a local copy of any kernel headers it needs
(plus making it endian safe so that you really can see your residual data
on your x86 box :-)

> > > > 4. Only create entry if residual size > 0 'coz what you can't see won't
> > > >    hurt you + eliminate chance of people wondering why they are getting an
> > > >    error trying to read it.
> > >
> > > I don't like that, because it leaves you wondering if you compiled in residual
> > > support at all... I'd much rather have it be 0 length.
> >
> > Okay.  I think the best behaviour is to simply return 0 bytes if there
> > is no residual data and let lsresidual interpret that as being no
> > residual data.
>
> If we don't have any residual data, shouldn't we be returning a 0 byte
> file anyhow?  I didn't explicitly test this, but in the original version
> I got from Sven/Hollis, no residual data gave me an empty
> /proc/residual.

The original may have, but the one you posted doesn't:

+static int prep_residual_open(struct inode * inode, struct file * file)
+{
+	if (res->ResidualLength == 0) {
+		return -ENOENT;
+	}
+	DPRINTK("/proc/residual opened\n");
+	MOD_INC_USE_COUNT;
+	return 0;
+}

The above will cause the open to fail if no residual data is present.
I've attached an updated version of my patch that has the required
behaviour (based on what you and Hollis have said).

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
+++ linuxppc_2_4_devel-140/arch/ppc/platforms/residual.c	Tue Jan 29 20:22:32 2002
@@ -876,3 +876,37 @@
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
+	create_proc_read_entry("residual", S_IRUGO, NULL,
+				proc_prep_residual_read, NULL);
+}
+
+__initcall(proc_prep_residual_init);
+#endif


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
