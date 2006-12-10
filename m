Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF8DC679FD
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 04:07:37 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc: "IRQ probe failed (0x0)" on powerbook
References: <87lklg9rkz.fsf@briny.internal.ondioline.org>
	<1165737970.1103.171.camel@localhost.localdomain>
Date: Sun, 10 Dec 2006 18:07:19 +0100
In-Reply-To: <1165737970.1103.171.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Sun, 10 Dec 2006 19:06:10 +1100")
Message-ID: <jey7pfvfw8.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sun, 2006-12-10 at 19:45 +1300, Paul Collins wrote:
>> On my PowerBook when booting Linus's tree as of commit af1713e0 I get
>> something like this:
>> 
>>   [blah blah]
>>   ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 0
>>   Probing IDE interface ide0...
>>   hda: HTS541080G9AT00, ATA DISK drive
>>   IRQ probe failed (0x0)
>>   IRQ probe failed (0x0)
>>   IRQ probe failed (0x0)
>>   IRQ probe failed (0x0)
>> 
>> And then of course it fails to mount root.  No such problem using a
>> kernel built from commit 97be852f of December 2nd.
>
> I'll investigate tomorrow, looks like irq assignment got broken in a way
> or another for that IDE controller.

Bisection has identified this patch:

commit f90bb153b1493719d18b4529a46ebfe43220ea6c
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sat Nov 11 17:24:51 2006 +1100

    [POWERPC] Make pci_read_irq_line the default
    
Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
