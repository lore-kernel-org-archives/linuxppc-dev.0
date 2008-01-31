Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BA339DDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 16:57:49 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0V5vSPO023680
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 22:57:38 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m0V5vQJA023743
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 23:57:27 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/6] Add multi mport support.
Date: Thu, 31 Jan 2008 13:57:25 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AEBD0677@zch01exm26.fsl.freescale.net>
In-Reply-To: <AF4B8466-C1CE-4FFB-8341-4BFC1CB76116@kernel.crashing.org>
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
	<12016890773706-git-send-email-wei.zhang@freescale.com>
	<AF4B8466-C1CE-4FFB-8341-4BFC1CB76116@kernel.crashing.org>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
>=20
> On Jan 30, 2008, at 4:30 AM, Zhang Wei wrote:
>=20
> > Change lots of static variable to mport private. And add=20
> mport to some
> > function declaration.
>=20
> Can you explain this patch further.  Its not clear exactly from this =20
> commit message why we are doing this.
>=20
> - k

Sorry about I have a little hurry about it.

The original RapidIO driver suppose there is only one mpc85xx RIO
controller
in system. So, some data structures are defined as mpc85xx_rio global,
such as 'regs_win', 'dbell_ring', 'msg_tx_ring'. Now, I changed them to
mport's private members. And you can define multi RIO OF-nodes in dts
file
for multi RapidIO controller in one processor, such as PCI/PCI-Ex host
controllers
in Freescale's silicon. And the mport operation function declaration
should be changed
to know which RapidIO controller is target.

Thanks!
Wei
