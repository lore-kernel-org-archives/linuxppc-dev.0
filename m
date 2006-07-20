Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id DBE2467B96
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 16:46:28 +1000 (EST)
To: "Lei Sun" <leisun124@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: reboot on PQ2FADS board. 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 Jul 2006 23:46:37 EDT."
	<f9a7e7a80607192046s3f17e8a5s4cfba43f1747e9ec@mail.gmail.com>
Date: Thu, 20 Jul 2006 08:46:26 +0200
Sender: wd@denx.de
Message-Id: <20060720064626.30695352681@atlas.denx.de>
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

In message <f9a7e7a80607192046s3f17e8a5s4cfba43f1747e9ec@mail.gmail.com> you wrote:
>
> m8260_restart(char * cmd)
...
>         startaddr = 0x04400000; /* this is taken from u-boot-1.1.4 */

This is a random address which  happens  to  be  not  mapped  in  the
specific  board  (MPC8260ADS.h).  The approach taken here is strongly
deprecated - it is juat an examp[le of a badly maintained board.  In-
stead, I recommend to use an addrress which causes a checkstop on all
boards,  idependently of the cspecific memory map. This is what we do
here:

> >         dummy = ((immap_t *)IMAP_ADDR)->im_clkrst.res[0];

In the end, the effect is the same.

And I have no idea why it would not work  on  your  board.  Attach  a
debugger and find out where exactly the code is hanging.

Ummm... and if you run under a debugger, *detach*  it  and  check  if
reset starts to work...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It's certainly  convenient  the  way  the  crime  (or  condition)  of
stupidity   carries   with   it  its  own  punishment,  automatically
admisistered without remorse, pity, or prejudice. :-)
         -- Tom Christiansen in <559seq$ag1$1@csnews.cs.colorado.edu>
