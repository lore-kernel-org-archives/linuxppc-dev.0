To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux STREAMS (LiS) available on Embedded PowerPC
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Mon, 12 Mar 2001 23:16:09 +0100
Message-Id: <20010312221609.108D5281DC@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everybody,

FYI: we have ported the Linux STREAMS package "LiS" to  MPC8xx  based
Embedded PowerPC systems.

Dave Grothe <dave@gcom.com>, the maintainer of LiS, has promised that
the PPC port will be included in the next release, LiS-2.12.

Until then you can find the stuff here:

* ftp://ftp.gcom.com/pub/linux/src/LiS/LiS-2.11.tgz

	The original tarball which we used as base for our port.

* ftp://ftp.denx.de/pub/LinuxPPC/usr/src/LiS/LiS-2.11-patch.gz

        This file includes unified context diffs against the original
        sources files from LiS-2.11.tgz

* ftp://ftp.denx.de/pub/LinuxPPC/usr/src/LiS/MAKELOG.gz

        This file is a typescript which  includes  all  commands  and
        resulting  output  for  configuring  and  building LiS for my
        target system. The file included below is for running LiS  in
        user space, without debugging.

        Also tested (and working) is: dynamically  loading  into  the
        Linux kernel as modules; dynamic linking; all with debugging,
        too.

        So far not tested is linking of LiS with  the  Linux  kernel,
        but I don't think that there should be problems.

* ftp://ftp.denx.de/pub/LinuxPPC/usr/src/LiS/STRTST.LOG.gz

        Console output of the target system used for the  tests.  The
        system  is  based on a Motorola MPC860T CPU with 16 MB of RAM
        and 2 MB of Flash memory. For the tests Linux kernel  version
        2.2.14  was  used  (based  on  the  MontaVista  HardHat Linux
        version 1.2). In the test configuration,  the  target  mounts
        the root filesystem over NFS.

I used our own set of cross development tools here,  but  all  that's
necessary  to  switch  to  any other set of CDK tools is changing the
definition of "CROSS_COMPILE" in the file "config.mk"; for  instance,
to  build  LiS  using the MontaVista HardHat version 1.2 cross tools,
you have to change this line like that:

	CROSS_COMPILE := ppc_8xx-

Ummm - and yes, for native build make that an empty definition:

	CROSS_COMPILE :=


Hope this helps.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
For every complex problem, there is a solution that is simple,  neat,
and wrong.                                           -- H. L. Mencken

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
