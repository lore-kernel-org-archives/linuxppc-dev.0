Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 25B942C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 07:50:37 +1000 (EST)
Date: Wed, 12 Jun 2013 16:50:26 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [BUG] PCI related panic on powerpc based board with 3.10-rcX
To: Rojhalat Ibrahim <imr@rtschenk.de>
References: <1370971739.18413.27@snotra> <34279395.MbRViMjbAR@pcimr>
In-Reply-To: <34279395.MbRViMjbAR@pcimr> (from imr@rtschenk.de on Wed Jun 12
 03:19:30 2013)
Message-ID: <1371073826.18413.52@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Guntsche <michael.guntsche@it-loops.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/2013 03:19:30 AM, Rojhalat Ibrahim wrote:
> On Tuesday 11 June 2013 12:28:59 Scott Wood wrote:
> > Yes, I figured it was non-PCIe because the code change that you said
> > helped was on the non-PCIe branch of the if/else.  Generally it's =20
> good
> > to explicitly mention the chip you're using, though.
> >
> > fsl_setup_indirect_pci should be renamed to fsl_setup_indirect_pcie.
> > Your patch above should be applied, and fsl_setup_indirect_pcie =20
> should
> > be moved into the booke/86xx ifdef to avoid an unused function =20
> warning.
> >
> > -Scott
>=20
> How about this patch? It uses setup_indirect_pci for the PCI case in
> mpc83xx_add_bridge. Additionally it adds a check in =20
> fsl_setup_indirect_pci
> to only use the modified read function in case of PCIe.

If we're adding the check to fsl_setup_indirect_pci, there's no need to =20
change the 83xx call back to setup_indirect_pci.  I see that 85xx is =20
also callirng fsl_setup_indirect_pci for both; it'd be good to be =20
consistent.

In any case, can you send a proper patch with a signoff and commit =20
message?

-Scott=
