Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 686F1679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 08:46:55 +1000 (EST)
To: "Walter L. Wimer III" <walt.wimer@timesys.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: IMAP_ADDR on PPC 8xx 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 May 2006 13:23:03 EDT."
	<1147108983.27101.63.camel@excalibur.timesys.com>
Date: Tue, 09 May 2006 00:46:53 +0200
Sender: wd@denx.de
Message-Id: <20060508224653.C4B48352B0C@atlas.denx.de>
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

In message <1147108983.27101.63.camel@excalibur.timesys.com> you wrote:
> 
> In particular, I have an MPC885ADS board running "U-Boot 1.1.3 (Apr 19
> 2005 - 13:39:58)".  It will boot neither 2.6.15 nor 2.6.16.11.  After
> U-Boot decompresses the kernel, I get no kernel output at all; it just
> hangs.

Probably you forgot to specify a correct  console  device  with  your
boot arguments.

> After some debugging, I think things go awry when the code starts
> dereferencing IMAP_ADDR as a direct pointer.  IMAP_ADDR is defined to be
> 0xFF000000, but the MPC885ADS documentation says that the internal

Correct.

> memory map is supposed to at 0x22000000.  In addition, when I look at
> the bd_t pointer from U-Boot, it's saying that 0x22000000 is the correct
> address.

No. U-Boot uses 0xFF000000. At least the official U-Boot source  tree
does. I don't know where you got yours from, or who might have broken
it.

> Why is this a problem for us and apparently not for anyone else on this
> list?  Is no one else using U-Boot?  Or does everyone else's U-Boot use
> 0xFF000000 instead of 0x22000000?  Or do I have a different problem

Most probably everybody else who uses U-Boot uses a good version with
a high mapping.

> While reading through the archives, I see that using IMAP_ADDR the way
> it is currently used is somewhat frowned upon anyway.  Is this one of
> those things that we (the PPC Linux community) should fix the "right
> way" once and for all?  I'm happy to submit a patch once I understand
> what the "right way" is...  :-)

The memory map requirements of PowerPC systems  have  been  explained
many  times  before,  so a little search in the archives, HOWTOs etc.
should point you quickly for good description why a low mapping  like
0x22000000 cannot work.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Hokey religions and ancient weapons are  no  substitute  for  a  good
blaster at your side.                                      - Han Solo
