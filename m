Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A3B2DE0AC
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 03:39:05 +1000 (EST)
Message-Id: <87783420-F027-486A-8ABD-3708DE5E21BA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1239987912.7210.17.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: pci32 code - early_*config*
Date: Fri, 17 Apr 2009 12:38:56 -0500
References: <8393884A-D1B0-4081-980C-CF464A38FD6C@kernel.crashing.org>
	<1239953159.7443.33.camel@pasglop>
	<c8485d470904170103g35e331b0g95d83613ed4bc1f4@mail.gmail.com>
	<1239957182.7443.58.camel@pasglop>
	<5A611DAC-A7E2-4E96-A087-B9BFD8DF59F9@kernel.crashing.org>
	<1239987912.7210.17.camel@pasglop>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Roderick Colenbrander <thunderbird2k@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2009, at 12:05 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2009-04-17 at 09:08 -0500, Kumar Gala wrote:
>> The problem is that the "normal" PCI config access routines need a
>> pci_bus.  However we don't have one yet and we need to do PCI config
>> cycles to the PHB before we call the remainder of the setup code to
>> get one.
>>
>> We could all call our own ops directly and provide a fake bus but
>> this
>> is pretty much what the early routines do for us in a common way.
>
> Ah right, slipped out of my mind. Oh well, easy to make the code
> common, move it to pci-common.c

Right, I can do that... In doing so I was wondering two things w/ 
regards to fake_pci_bus:

1. can we drop the hose == 0 check, it looks like there are 3 users of  
the early pci ops code (fsl, 4xx, pmac).  The FSL one I can say passes  
a valid hose in and it looks like 4xx does as well.  The pmac code is  
always a bit more trick so I figured you might know

2. Do we believe those hose->ops is always valid -- again FSL & 4xx it  
is, pmac??

static struct pci_bus *
fake_pci_bus(struct pci_controller *hose, int busnr)
{
         static struct pci_bus bus;

         if (hose == 0) {
                 hose = pci_bus_to_hose(busnr);
                 if (hose == 0)
                         printk(KERN_ERR "Can't find hose for PCI bus  
%d!\n", busnr);
         }
         bus.number = busnr;
         bus.sysdata = hose;
         bus.ops = hose? hose->ops: &null_pci_ops;
         return &bus;
}
