Return-Path: <B35336@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C33D9B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 22:21:19 +1100 (EST)
From: Zhao Chenhui-B35336 <B35336@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/4] fsl_pci: Add a workaround for PCI 5 errata in MPC8548
Date: Thu, 8 Mar 2012 11:21:11 +0000
Message-ID: <7AA2FF042C086D469F577FA6723434DA01EE73@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1331025056-15983-1-git-send-email-chenhui.zhao@freescale.com>
 <1331025056-15983-2-git-send-email-chenhui.zhao@freescale.com>
 <9449E54A-E134-45B9-A012-C824753D0C97@kernel.crashing.org>
In-Reply-To: <9449E54A-E134-45B9-A012-C824753D0C97@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mar 6, 2012, at 3:10 AM, Zhao Chenhui wrote:
>=20
> > +		if ((fsl_svr_is(SVR_8548) || fsl_svr_is(SVR_8548_E)) &&
>=20
> Should this also have 8547, 8547E, 8545, 8545E, 8543, & 8543E?

Yes. I will include these chips.

-Chenhui

>=20
> > +		    !early_find_capability(hose, 0, 0, PCI_CAP_ID_PCIX)) {
> > +			early_read_config_word(hose, 0, 0,
> > +						PCI_BUS_FUNCTION, &temp);
> > +			temp |=3D PCI_BUS_FUNCTION_MDS;
> > +			early_write_config_word(hose, 0, 0,
> > +						PCI_BUS_FUNCTION, temp);
> > +		}
> > 	}
>=20
