To: Arturo Nunez <artnpp@cs.ucf.edu>
Cc: linuxppc-embedded@lists.linuxppc.org (ppc)
Subject: Re: Error Compiling Embedded 860 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 12 Mar 2001 20:06:40 EST."
             <200103130106.UAA18070@iris.cs.ucf.edu>
Date: Tue, 13 Mar 2001 09:09:48 +0100
Message-Id: <20010313080953.4CFAD281DB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200103130106.UAA18070@iris.cs.ucf.edu> you wrote:
>
> 	But when I try to compile the Kernel for a
> 	- 8xx Processor Type ( I have a 860)
> 	Doesnt compile ..
> 	The error I may see is:
> 	-realpath(../8xx_io) failed, No such file or directory
> 	Ok Seems to be that doesnt fin the File... But I already have..
> 	Any Idea about the Problem ??

You can fix that easily:

--- linux-2.4.3-pre3-2001-03-11/arch/ppc/Makefile.ORIG	Sun Mar 11 21:10:01 2001
+++ linux-2.4.3-pre3-2001-03-11/arch/ppc/Makefile	Mon Mar 12 14:30:25 2001
@@ -31,7 +31,7 @@
 endif

 ifdef CONFIG_8xx
-CFLAGS := $(CFLAGS) -mcpu=860 -I../8xx_io
+CFLAGS := $(CFLAGS) -mcpu=860 -I$(TOPDIR)/arch/ppc/8xx_io
 endif

 ifdef CONFIG_PPC64BRIDGE

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Calm down, it's *__only* ones and zeroes.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
