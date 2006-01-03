Return-Path: <wd@denx.de>
To: =?ISO-8859-1?Q?No=E9_SERRES?= <noe.serres@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Jan 2006 15:06:40 +0100."
	<f8bc181b0601030606x3b29ee28q@mail.gmail.com>
Date: Tue, 03 Jan 2006 15:17:24 +0100
Sender: wd@denx.de
Message-Id: <20060103141725.08E8D3540BC@atlas.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: "argument list too long" 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <f8bc181b0601030606x3b29ee28q@mail.gmail.com> you wrote:
>
> After a few minutes of dependency creation, I get the following error
> "argument list too long":
> 
> scripts/mkdep -- `find
> /usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm
> /usr/src/linuxppc_2_4
> _devel-2005-10-25-1440/include/linux
> /usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/scsi /usr/s
> rc/linuxppc_2_4_devel-2005-10-25-1440/include/net
> /usr/src/linuxppc_2_4_devel-2005-10-25-1440/includ
> e/math-emu \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h !
> -name modversions.h -print`
>  > .hdepend
> scripts/mkdep: argument list too long
> make: *** [dep-files] Error 2
> 
> Can someone help me understand where that comes from?

The error comes from the fact that the  find  command  (the  part  in
`...`  above)  generates a long list of file names which exceeds some
buffer in your shell.

> Does it have something to do with the fact that I work under WinXP + Cygwin?

Yes.

> No need to say that I am a newbie to the Linux world... help me, Wolfgang
> :-)

I try. Find the statement in the Makefile and use xargs  to  avoid  a
long argument list. Something like this might help:

--- Makefile.ORIG	2006-01-03 15:15:48.000000000 +0100
+++ Makefile	2006-01-03 15:16:55.000000000 +0100
@@ -503,7 +503,7 @@
 ifdef CONFIG_MODVERSIONS
 	$(MAKE) update-modverfile
 endif
-	scripts/mkdep -- `find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
+	find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print | xargs scripts/mkdep -- > .hdepend
 	scripts/mkdep -- init/*.c > .depend
 
 ifdef CONFIG_MODVERSIONS



Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The optimum committee has no members.
                                                   - Norman Augustine
