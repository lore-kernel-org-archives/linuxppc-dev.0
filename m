Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 16B35DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 03:45:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Another Update (SUCCESS) on: MPC85xx git/MPC8548cds - PCI/PCIE
	problemS w/ Marvel SATA driver...
Date: Tue, 27 Feb 2007 11:45:28 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90106A8CAEC@EMPBEDEX.empirix.com>
In-Reply-To: <45E22753.2020809@freescale.com>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>	<BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>	<8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>	<BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
	<1172305505.1902.27.camel@localhost.localdomain>
	<45E22753.2020809@freescale.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As indicated before, I got the SATA drive fully=20
accessed via the PCI interface (that uses the Marvell=20
6042 chip).

With some help from Freescale and based upon the CDS/Carrier/
Motherboard combination that I have (2.2/1.2/3.0), I was
required to merge the PCI Express piece of the Standard=20
DTS file into the legacy version. Further, I modified=20
the standard sata_mv.c to recognize the Marvell 7042 chip=20
as a valid/supportable id.

The question now is:  What do I do with these changes?

I am assuming that someone from Freescale will update the
DTS changes, but what about the change to sata_mv.c?

It is a one line change to add the Marvell version of=20
7042 chip to the pci_device_id table (mv_pci_tbl):

	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },

I know that for Marvell, the only difference between the=20
PCI version (6042) and PCI Express version (7042) is=20
the external bridge interface (PCI to PCI bridge for the=20
6042 & PCI to PCI Express bridge for the 7042) which
is transparent to this driver anyways. Thus, I am=20
pretty sure it's a safe change?

But, I've never submitted a change and/or I do not=20
want to step on anyone else's toes (J.G. comes in mind)=20
if they are already staging this change.

Suggestions/Comments?

Thanks in advance...

Tom Morrison
Principal Software Engineer
EMPIRIX=20
20 Crosby Drive - Bedford, MA  01730
p: 781.266.3567 f: 781.266.3670=20
email: tmorrison@empirix.com=20
www.empirix.com
