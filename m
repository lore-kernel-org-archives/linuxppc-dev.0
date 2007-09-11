Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 25FA9DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 03:31:35 +1000 (EST)
Message-ID: <46E6D131.2030904@ovro.caltech.edu>
Date: Tue, 11 Sep 2007 10:32:33 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: PCI target implementation on AMCC PPC CPUs
References: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>
	<406A31B117F2734987636D6CCC93EE3C022417D2@ehost011-3.exch011.intermedia.net>
	<46E06259.5010305@ovro.caltech.edu>
	<200709111113.46508.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200709111113.46508.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matthias,

> we build a couple of PCI target designs using AMCC PowerPCs.
> You are right that some things could be better. But ..
> 
> On Thursday 06 September 2007 22:26, David Hawkins wrote:
>> There are several fundamental problems with the AMCC 440EP
>> acting as a PCI target/slave;
>>
>> 2. Look in the data sheet and see if you can figure out
>>     how the host processor can generate an interrupt to
>>     the PowerPC core ... oops, you can't. That kind of
>>     makes it difficult to work with doesn't it.
>
> You CAN! You can generate an interrupt to the PowerPC from the host
> CPU bei writing to the PCI command register. You have to read the user manual
> carefully. Perhaps it not that obvious.

Really!? Someone should tell AMCC tech support then.
When I failed to find a method (other than hooking up
an external GPIO), I contacted them and they came to
the same conclusion (on the 440EP anyway).

I'll look in the latest user manual to be sure ...

PPC440EP_UM2000_v1_23.pdf

p394 has their 'cheesy' implementation of PCI INTA# control;
toggle a single bit.

Then backing up a little, p388 has the PCI command register ...
Nope, no comment there that a write causes an interrupt to
the PowerPC core.

Ok, so going back to the UIC in Chapter 10, p224.

Ah-ha, PCI CMD write generates an interrupt 5!

So, I stand corrected; the host can generate an interrupt to
the PowerPC core, and the method is 'cheesier' than the PCI
INTA# control.

And my experience with AMCC's tech support is now a notch
lower, as even they did not offer this as a solution :)

I sure am glad I changed to a Freescale processor ;)

Cheers,
Dave
