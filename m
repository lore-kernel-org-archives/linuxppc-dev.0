To: "El Topo" <ElTopo@myrealbox.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc linux kernel 2.4.4 for ppc440/EBony using ELDK 2.0.2? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 03 Apr 2003 16:45:12 -0800."
             <005301c2fa43$73a1c690$1464a8c0@sjeng3>
Date: Fri, 04 Apr 2003 09:00:40 +0200
Message-Id: <20030404070045.E6AF0C587C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <005301c2fa43$73a1c690$1464a8c0@sjeng3> you wrote:
>
> I've got the linuxppc_2_4_devel tree, made config for 440/Ebony,
> then when I compiled the kernel, I got this problem:
...
> /home/lxl/linuxppc_2_4_devel/include/linux/kernel.h:10: stdarg.h: No such
> file or directory
...
> This is indeed weird, how could ppc_4xx-gcc not find "stdarg.h"? the same
> version
> still works for the stable linuxppc-2.4.4, and I saw
> /home/lxl/linuxppc_2_4_devel/include/linux/kernel.h
> also has #include <stdarg.h> but ppc_4xx-gcc has no problem finding
> stdarg.h.
> I doubt checked and made sure I have stdarg.h at
> $(eldk_root)/ppc_4xx/usr/lib/gcc-lib/ppc-linux/2.95.4/include/stdarg.h
>
> Anybody has this problem? or has any idea how I can make it work?

This is a known problem. We use the following modification to the top
level makefile  in  our  version  of  the  source  tree  (see  module
linuxppc_2_4_devel on our CVS server):

Index: Makefile
===================================================================
RCS file: /cvsroot/linuxppc_2_4_devel/Makefile,v
retrieving revision 1.6
retrieving revision 1.7
diff -u -r1.6 -r1.7
--- Makefile	1 Dec 2002 22:42:52 -0000	1.6
+++ Makefile	1 Dec 2002 23:36:15 -0000	1.7
...
@@ -261,7 +263,8 @@
 # 'kbuild_2_4_nostdinc :=' or -I/usr/include for kernel code and you are not UML
 # then your code is broken!  KAO.

-kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
+kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | \
+				sed -ne 's/install: \(.*\)/-I \1include/gp')
 export kbuild_2_4_nostdinc

 export	CPPFLAGS CFLAGS CFLAGS_KERNEL AFLAGS AFLAGS_KERNEL
...


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Intel told us the Pentium would have "RISK" features...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
