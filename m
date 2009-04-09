Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51C54DE099
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 15:33:40 +1000 (EST)
Message-ID: <49DD8871.2030404@garzik.org>
Date: Thu, 09 Apr 2009 01:32:33 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: michael@ellerman.id.au, Kumar Gala <galak@kernel.crashing.org>,
	Timur Tabi <timur@freescale.com>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>	
	<ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>	
	<1239156559.10104.7.camel@localhost>	
	<ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com>	
	<49DD1154.3040106@kernel.org> <49DD11D1.7060105@freescale.com>	
	<49DD1375.8030400@kernel.org> <49DD1465.6070001@freescale.com>	
	<49DD17C3.7040607@kernel.org>	
	<ed82fe3e0904081515k6e53de00g7d5256f9b61a03da@mail.gmail.com>	
	<1239234793.6214.5.camel@localhost>	
	<E7CD85E9-BB6E-4598-A734-8D0E67090789@kernel.crashing.org>
	<1239251928.22777.2.camel@localhost>
In-Reply-To: <1239251928.22777.2.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Wed, 2009-04-08 at 23:23 -0500, Kumar Gala wrote:
>> On Apr 8, 2009, at 6:53 PM, Michael Ellerman wrote:
>>
>>> On Wed, 2009-04-08 at 17:15 -0500, Timur Tabi wrote:
>>>> On Wed, Apr 8, 2009 at 4:31 PM, Tejun Heo <tj@kernel.org> wrote:
>>>>> Hmmm... for now,
>>>>> I think it would be best to revert the original change.  Jeff, can  
>>>>> you
>>>>> please do that?
>>>> Actually, give me a few days before you do that.  A colleague gave me
>>>> some suggestions to debug this.
>>> What device did you say it was? A "ULI M1575" ?
>>>
>>> Is that this one?
>>>
>>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575,  
>>> hpcd_quirk_uli1575);
>>>
>>> static void __devinit hpcd_quirk_uli1575(struct pci_dev *dev)
>>> {
>>>        u32 temp32;
>>>
>>>        if (!machine_is(mpc86xx_hpcd))
>>>                return;
>>>
>>>        /* Disable INTx */
>>>        pci_read_config_dword(dev, 0x48, &temp32);
>>>        pci_write_config_dword(dev, 0x48, (temp32 | 1<<26));
>>> ..
>> It is the odd thing is the board he's running on is a mpc86xx_hpcd so  
>> he shouldn't be hitting the code that actually disables INTx.
> 
> Sorry Kumar that's not parsing :)
> 
> He is running an mpc86xx_hpcd, so he _should_ be hitting the code that
> disables INTX?

The reversed logic of the PCI bit itself also makes for confusing 
discusion.  In an attempt to be helpful, here is a restatement of what 
is happening:

1) Old 'ahci' used to clear PCI_COMMAND_INTX_DISABLE, thus ensuring INTX 
interrupts are enabled... if and only if MSI is unavailable.

2) Current 'ahci' no longer does this

3) As a result, Timur's 'ahci' is no longer receiving interrupts. 
Presumably this means that BOTH of the following conditions are true

	a) INTX is disabled
	b) MSI is not available

Today I am thinking we should either revert the libata commit 
(a5bfc4714b3f01365aef89a92673f2ceb1ccf246), or poke PCI to twiddle INTX 
for us at pci_enable_device() time, perhaps.

I lean towards the former, but maybe the platform folks prefer a third 
solution?

	Jeff
