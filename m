To: Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Prob to compile Kernel on mpc860. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 30 Oct 2003 16:57:36 +0100."
             <66CE949D18BCB249ABE8D9AF48C4F1CE777849@helios.clb.tcfr.thales>
Date: Thu, 30 Oct 2003 17:16:29 +0100
Message-Id: <20031030161634.B01C7C59E4@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Christophe,

in message <66CE949D18BCB249ABE8D9AF48C4F1CE777849@helios.clb.tcfr.thales> you wrote:
>
> prob 1 :
> I am trying to compile the linuxppc_2_4_devel_2.4_20-2002_12_04 from Denx.
> As I need debug, I replace -O2 by -g in the Makefile.
> The kernel doesn't link anymore :[

You cannot compile the Linux kernel without optimization, as then  no
inlining of functions will be done. Use "-Os -g".

> prob 2 :
> Using linux2.4.22 from kernel.org.
> I apply the patch for powerpc
> the kernel doesn't compile.
> Prob with stdarg.h that doesn't exist ( in sched.c )

Try this patch:

===================================================================
RCS file: /cvsroot/linuxppc_2_4_devel/Makefile,v
retrieving revision 1.7
retrieving revision 1.6
diff -u -r1.7 -r1.6
--- Makefile	1 Dec 2002 23:36:15 -0000	1.7
+++ Makefile	1 Dec 2002 22:42:52 -0000	1.6
@@ -263,8 +261,7 @@
 # 'kbuild_2_4_nostdinc :=' or -I/usr/include for kernel code and you are not UML
 # then your code is broken!  KAO.

-kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | \
-				sed -ne 's/install: \(.*\)/-I \1include/gp')
+kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
 export kbuild_2_4_nostdinc

 export	CPPFLAGS CFLAGS CFLAGS_KERNEL AFLAGS AFLAGS_KERNEL


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Documentation is the castor oil of programming.
Managers know it must be good because the programmers hate it so much.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
