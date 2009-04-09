Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C94AADDFD5
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 14:27:53 +1000 (EST)
Message-Id: <E7CD85E9-BB6E-4598-A734-8D0E67090789@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1239234793.6214.5.camel@localhost>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Wed, 8 Apr 2009 23:23:01 -0500
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>
	<ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
	<1239156559.10104.7.camel@localhost>
	<ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com>
	<49DD1154.3040106@kernel.org> <49DD11D1.7060105@freescale.com>
	<49DD1375.8030400@kernel.org> <49DD1465.6070001@freescale.com>
	<49DD17C3.7040607@kernel.org>
	<ed82fe3e0904081515k6e53de00g7d5256f9b61a03da@mail.gmail.com>
	<1239234793.6214.5.camel@localhost>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Timur Tabi <timur@freescale.com>, Jeff Garzik <jeff@garzik.org>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 8, 2009, at 6:53 PM, Michael Ellerman wrote:

> On Wed, 2009-04-08 at 17:15 -0500, Timur Tabi wrote:
>> On Wed, Apr 8, 2009 at 4:31 PM, Tejun Heo <tj@kernel.org> wrote:
>>> Hmmm... for now,
>>> I think it would be best to revert the original change.  Jeff, can  
>>> you
>>> please do that?
>>
>> Actually, give me a few days before you do that.  A colleague gave me
>> some suggestions to debug this.
>
> What device did you say it was? A "ULI M1575" ?
>
> Is that this one?
>
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575,  
> hpcd_quirk_uli1575);
>
> static void __devinit hpcd_quirk_uli1575(struct pci_dev *dev)
> {
>        u32 temp32;
>
>        if (!machine_is(mpc86xx_hpcd))
>                return;
>
>        /* Disable INTx */
>        pci_read_config_dword(dev, 0x48, &temp32);
>        pci_write_config_dword(dev, 0x48, (temp32 | 1<<26));
> ..

It is the odd thing is the board he's running on is a mpc86xx_hpcd so  
he shouldn't be hitting the code that actually disables INTx.

- k
