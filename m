Return-Path: <tnt@246tNt.com>
Received: from outmx001.isp.belgacom.be (outmx001.isp.belgacom.be
	[195.238.5.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7E7D67BD5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Nov 2006 10:22:00 +1100 (EST)
Received: from outmx001.isp.belgacom.be (localhost [127.0.0.1])
	by outmx001.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kAHNLk1n024835
	for <linuxppc-embedded@ozlabs.org>; Sat, 18 Nov 2006 00:21:46 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <455E4406.8050405@246tNt.com>
Date: Sat, 18 Nov 2006 00:21:42 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller using
	libata
References: <11637151391017-git-send-email-tnt@246tNt.com>
	<200611172049.49260.jarno.manninen@tut.fi>
	<455E0907.8000009@246tNt.com> <455E3A7E.3030807@garzik.org>
In-Reply-To: <455E3A7E.3030807@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux IDE <linux-ide@vger.kernel.org>, Sven Luther <sl@bplan-gmbh.de>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jeff Garzik wrote:
> Sylvain Munaut wrote:
>> Since the current libata doesn't really support overriding IO accessors,
>> I'd keep it like
>> that for now. Apparently some other architecture needs special IO stuff
>> so we could see
>> a way to hook io accessor soon, and then we can change it if we notice
>> big problems.
>
> Sure it does...  there are no individual outb etc. hooks, but you can
> override every available bitbang function.  This is intentional, so
> that arches have more power to control when and how a set of registers
> is blasted to the hardware.

That why I said "really" but in english that doesn't quite mean what I
meant.
I have a version that does it and it's not pretty, it needs to reimplement
every hook where I basically just cut & pasted the standard libata ones
and changed the outb to mpc52xx_ata_outb ...

I agree that this gives more flexibility when you need more than just change
IO accessors. But this also means than when you just need to replace IO
access, you need to do more work ...  IMHO it would have made sense to
add hooks for just inb and outb (not for all the possible io stuff like in
driver/ide), but heh, I'm kind of biased ;)

So it's possible but as in the current state of thing since it doesn't
matter
if we do it or not, I'd rather not. If it becomes necessary (when doing DMA
or ...), then we can always add it. But for the moment, I would keep it
as clean as possible.


Aside from that, does the driver looks ok ? It has been tested ok on another
5200b platform as well. I'd like to include it in a patch set I'll probably
send next weekend. I'll try to add the timing computation to the generic
call and make use of those.


Thanks,


    Sylvain
