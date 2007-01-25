Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx023.isp.belgacom.be (outmx023.isp.belgacom.be
	[195.238.4.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8F3DDE297
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 20:17:57 +1100 (EST)
Received: from outmx023.isp.belgacom.be (localhost [127.0.0.1])
	by outmx023.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l0P9Hh1R009800
	for <linuxppc-embedded@ozlabs.org>; Thu, 25 Jan 2007 10:17:46 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: JTAG emulator for MPC8548E (v2)
Date: Thu, 25 Jan 2007 10:17:40 +0100
References: <20070124204944.172BB353BC5@atlas.denx.de>
In-Reply-To: <20070124204944.172BB353BC5@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701251017.40279.laurent.pinchart@technotrade.biz>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

> > The new unit works *mostly* fine. No debugging issue (not that I use it
> > that much anyway, now that the board boots Linux), but still a flash
> > programming issue. Programming the target parallel NOR flash works in
> > slow JTAG mode, but not in faster mode using the internal workspace. I
> > reported the problem
>
> This may as well be a misconfiguration in your config file, like
> setting wrong flash timings.

I agree with you there, but I haven't been able to find which setting I got 
wrong. I dumped the registers contents after the board gets initialised by 
U-Boot, and all related values are identical. I even traced the U-Boot code 
and tried to reproduce the exact initialisation sequence, without luck.

This is definitely an initialisation issue, as programming in workspace mode 
works when the board gets initialised by U-Boot first (wrong reset vector 
setting in the config file, which makes the BDI freeze the processor after it 
started up).

> > several months ago and still haven't received any solution. It might not
> > be Abatron's fault, the French distributor might not have reported the
> > problem to them. Abatron people speak German only, and will not respond
> > to e-mails written in English (nor will they talk to you on the phone,
> > they just hang up).
>
> I cannot confirm this. On contrary. Abatron's support is one  of  the
> best  I've  ever  seen,  and I have seen a few. And of course you can
> send messages in  English  to  support@abatron.ch,  and  you  do  get
> replies.  And  they  do  answer  the phone (in German and in English,
> too).

I might have been unlucky, but the person who picked the phone definitely hung 
up on us when he/she realized we were speaking English.

> > The BDI-2000 is a nice product, but has a few bugs, is IMHO overprized
> > and has one of the worst support service I've had to deal with.
>
> Hm... we have about 15 such devices in daily use. I don't doubt  your
> report, but you must have had really bad luck. This is NOT the normal
> situation with Abatron or the BDI.

Glad to hear :-) I will try again then. Thanks.

Best regards,

Laurent Pinchart
