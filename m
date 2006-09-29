Return-Path: <mgalassi@c-cor.com>
Received: from penguin.ncube.com (penguin.ncube.com [134.242.67.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B788367BBE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Sep 2006 08:14:46 +1000 (EST)
Message-Id: <200609292214.k8TMEZfw006857@penguin.ncube.com>
To: "Reeve Yang" <yang.reeve@gmail.com>
Subject: Re: Need help on PPC8343E bringup 
In-reply-to: <198592450609291503s7be0200ehf72925c2cae07787@mail.gmail.com> 
References: <198592450609291408w2dbf7e5ckf5e4cf7023d2000@mail.gmail.com>
	<200609292133.k8TLXUUv072654@penguin.ncube.com>
	<200609292139.k8TLdV10081103@penguin.ncube.com>
	<198592450609291503s7be0200ehf72925c2cae07787@mail.gmail.com>
Date: Fri, 29 Sep 2006 15:14:35 -0700
From: Michael Galassi <mgalassi@c-cor.com>
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

>Thanks Machael.
>
>On my flash data sheet, there are some command about security:
>
>Lock Block | Block Address | 0060h | Block Address | 0001h
>Unlock Block|Block Address| 0060h | Block Address | 00d0h
>
>So I guess it needs two write cycle to perfomr the command, and the unlock
>command should be 006000d0. I tried that but still get the same error. Bad!
>:(
>
>Another questions is that is there any way to change CPU register directy?
>For 8343E all registers are mapped to 1m starting from 0xff400000. I want to
>change on 0Xff400c08, but visionclick reject me to write on that address.
>
>- Reeve

Actually no, I made the assumption that you have two 16 bit wide flash
parts, one providing bits 0:15, the other 16:31.  Most PPC projects end
up doing this.  The write 0x00600060 ends up sending a 0x60 to the flash
on the low bits and another 0x60 to the flash part on the high bits.
The second write of 0x00d000d0 likewise sends a single 0xd0 to each
flash part.

If your tool gave you a command called mw which had a usage somewhat
like:
    mw <size> <address> <data>
where size is b/byte, w/word, l/longword you might you might try:
    mw l 0x00600060 0xff000000
    mw l 0x00d000d0 0xff000000
Does that make sense to you?

PS: some people here have nothing better to do than whine about
    top-posting, safe yourself the grief and respond bellow the
    post.
PS: Technicaly this is not a Linux topic, I'm responding here
    because this does turn out to be of general interest.

-michael
