Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21E7ADDE29
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 04:17:47 +1100 (EST)
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90106A8CAEC@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>	<BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>	<8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>	<BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
	<1172305505.1902.27.camel@localhost.localdomain>
	<45E22753.2020809@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D90106A8CAEC@EMPBEDEX.empirix.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3B3A3CDA-4450-449E-9171-8E5B87E531E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Another Update (SUCCESS) on: MPC85xx git/MPC8548cds - PCI/PCIE
	problemS w/ Marvel SATA driver...
Date: Tue, 27 Feb 2007 11:16:54 -0600
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 27, 2007, at 10:45 AM, Morrison, Tom wrote:

> As indicated before, I got the SATA drive fully
> accessed via the PCI interface (that uses the Marvell
> 6042 chip).
>
> With some help from Freescale and based upon the CDS/Carrier/
> Motherboard combination that I have (2.2/1.2/3.0), I was
> required to merge the PCI Express piece of the Standard
> DTS file into the legacy version. Further, I modified
> the standard sata_mv.c to recognize the Marvell 7042 chip
> as a valid/supportable id.
>
> The question now is:  What do I do with these changes?
>
> I am assuming that someone from Freescale will update the
> DTS changes, but what about the change to sata_mv.c?

For the sata_mv.c change I would create a patch as per Documentation/ 
SubmittingPatches and email Jeff Garzik with the patch and copy linux- 
ide@vger.kernel.org.	

> It is a one line change to add the Marvell version of
> 7042 chip to the pci_device_id table (mv_pci_tbl):
>
> 	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
>
> I know that for Marvell, the only difference between the
> PCI version (6042) and PCI Express version (7042) is
> the external bridge interface (PCI to PCI bridge for the
> 6042 & PCI to PCI Express bridge for the 7042) which
> is transparent to this driver anyways. Thus, I am
> pretty sure it's a safe change?
>
> But, I've never submitted a change and/or I do not
> want to step on anyone else's toes (J.G. comes in mind)
> if they are already staging this change.
>
> Suggestions/Comments?
>
> Thanks in advance...
>
> Tom Morrison
> Principal Software Engineer
> EMPIRIX
> 20 Crosby Drive - Bedford, MA  01730
> p: 781.266.3567 f: 781.266.3670
> email: tmorrison@empirix.com
> www.empirix.com
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
