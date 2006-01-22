Return-Path: <cedric.pradalier@inrialpes.fr>
Date: Sun, 22 Jan 2006 18:11:26 +1000
From: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 001/001] PMAC HD runtime blinking control
Message-Id: <20060122181126.357df500.cedric.pradalier@inrialpes.fr>
In-Reply-To: <1137898193.12998.83.camel@localhost.localdomain>
References: <20060122121907.792abc72.cedric.pradalier@free.fr>
	<1137898193.12998.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

According to Benjamin Herrenschmidt, on Sun, 22 Jan 2006
13:49:53 +1100, 
>On Sun, 2006-01-22 at 12:19 +1000, Cedric Pradalier wrote:
>> Hi,
>> 
>> I've finally spend the time to mend the patch for control of
>> the HD led blinking at runtime. This is a patch against
>> 2.6.15
>> 
>> The sysfs entry is attached to the PCI device and to the
>> MACIO device if available. I think that was what Ben was
>> asking for:
>
>Heh, nice :) Almost ! It would be better if it was attached to the sysfs
>node of the ide interface, you can find it in the HWIF array after
>probe, but I won't be too much of a pain about that for now :)
>

Yep, now I remember, that was what you where asking for.
Can you give me an idea of the sysfs path you're expecting?
Is it in 
bus/ide/..., 
bus/pci/drivers/ide-pmac,
bus/pci/drivers/ide-disk
devices/pci0001:10/0001:10:17.0/0.80000000:mac-io/0.0001f000:ata-4/ide0

I would guess on the latter. 
For now I'm using the pmif->mdev->ofdev.dev as attachment
device, which brings me into 0.0001f000:ata-4
What in pmif can brings me to the ide0? pmif->node? Or one
of its siblings?

In ide_hwif_t, I'm using the pci_dev. Where in the pci_dev
can I find ide0? or is it somewhere else in ide_hwif_t?

For the HWIF array, I guess you're talking about ide_hwifs.
How do I identify the interface itself there?

Hmm, plenty of questions. I hope at least one is relevant
for this problem...

Thanks
--
Cedric
