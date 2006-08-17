Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 154DF67B77
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 19:48:16 +1000 (EST)
To: "Keith Redfern" <keith.redfern@uk.flextronics.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problems dynamically linking busybox with ppc libs. 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 16 Aug 2006 10:53:04 +0200."
	<367F3B3911959C4DA9991C00166F620C1DE208@EUDUCEX2.europe.ad.flextronics.com>
Date: Thu, 17 Aug 2006 11:48:12 +0200
Sender: wd@denx.de
Message-Id: <20060817094812.EAC42353A31@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <367F3B3911959C4DA9991C00166F620C1DE208@EUDUCEX2.europe.ad.flextronics.com> you wrote:
> 
> I am trying to dynamically link busybox with the correct libraries but> 
> run into problems with directory paths and CC/LD flags.

Maybe you do too much?

> I am using the toolchain supplied with ELDK and my target board is
> ppc_8xx based. The busybox version that I am using is 1.1.3.

> I see the following in Rules.mak and have been trying different variable> 
> options but with no success.

You are not supposed to meddle with Rules.mk. Also, this is not
necessary at all.

> Is this the correct place to make modifications?

No. No modifications are necessary.

Just run a standard configuration  and  make  sure  to  select  cross
compilation with "ppc_8xx-" as Cross Compiler prefix, i. e.:

-> cd /tmp
-> wget http://busybox.net/downloads/busybox-1.1.3.tar.bz2
-> tar jxf busybox-1.1.3.tar.bz2
-> cd busybox-1.1.3
-> export CROSS_COMPILE=ppc_8xx-
-> make config
...
*
* Build Options
*
...
Do you want to build BusyBox with a Cross Compiler?
(USING_CROSS_COMPILER) [N/y/?] (NEW) y
  Cross Compiler prefix (CROSS_COMPILER_PREFIX) [/usr/i386-linux-uclibc/bin/i386-uclibc-] (NEW) ppc_8xx-
Any extra CFLAGS options for the compiler? (EXTRA_CFLAGS_OPTIONS) [] (NEW)
...
-> make
...
  LINK busybox_unstripped
  STRIP busybox
...

This is so straightforward that I wonder what you moight have done to
run into problems...


> Has anyone already figured the changes required to get this to work with
> ELDK toolchain?

Yes. And if had bothered to check how the busybox RPM was build which
comes included with the ELDK (for example by  looking  at  it's  spec
file), then you should have known, too.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Our business is run on trust.  We trust you will pay in advance.
