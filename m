Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A77B42BF07
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 04:56:48 +1100 (EST)
Date: Wed, 5 Jan 2005 09:56:46 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: J?n Benediktsson <jonb@marel.is>
Message-ID: <20050105175646.GC14485@gate.ebshome.net>
References: <OFE3F13085.168CF615-ON00256F80.003C6775-00256F80.004A9C3D@marel.is>
	<OF9A6BA55A.0E01CA7E-ON00256F80.0051303B-00256F80.0051795E@marel.is>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF9A6BA55A.0E01CA7E-ON00256F80.0051303B-00256F80.0051795E@marel.is>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 - problem with CF card
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 05, 2005 at 02:49:42PM +0000, J?n Benediktsson wrote:
> > I am working with a custom MPC5200 board which uses the built-in 
> > ATA/IDE controller for a compact flash card. 
> > The Linux kernel is Denx linux_2_4_devel. 

[snip]

> > mpc5xxx_ide: Setting up IDE interface ide0... 
> > Probing IDE interface ide0... 
> > hda: SanDisk SDCFBI-1024, ATA DISK drive 
> > hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x7f) 
> > ide0: unexpected interrupt, status=0x00, count=1 

I had similar problem with some CF cards (while other like in your 
case worked fine).

Try disabling probing of the slave ide0 interface (hdb). I'm not 
familiar with MPC5xxx, but most likely you can modify mpc5xxx_ide or 
whatever code sets up access to your CF card.

Find where an instance of ide_hwif_t is initialized for ide0 and add 
something like:

	/* Don't probe second drive */
        hwif->drives[1].noprobe = 1;

--
Eugene
