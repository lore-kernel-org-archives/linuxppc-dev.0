Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B6C3F2C0326
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2013 22:23:31 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Stefan Roese <sr@denx.de>
Subject: RE: [PATCH v2] net: fec_mpc52xx: Read MAC address from device-tree
Date: Tue, 12 Feb 2013 11:23:24 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D065A1614@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1360660088-27464-1-git-send-email-sr@denx.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D065A0271@039-SN2MPN1-023.039d.mgd.msft.net>
 <511A219A.7080000@denx.de>
In-Reply-To: <511A219A.7080000@denx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Anatolij Gustschin <agust@denx.de>, "David S. Miller" <davem@davemloft.net>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Stefan Roese [mailto:sr@denx.de]
> Sent: Tuesday, February 12, 2013 4:34 PM
> To: Bhushan Bharat-R65777
> Cc: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org; Anatolij Gustschin; =
David
> S. Miller
> Subject: Re: [PATCH v2] net: fec_mpc52xx: Read MAC address from device-tr=
ee
>=20
> On 12.02.2013 11:56, Bhushan Bharat-R65777 wrote:
> >> Until now, the MPC5200 FEC ethernet driver relied upon the bootloader
> >> (U-Boot) to write the MAC address into the ethernet controller
> >> registers. The Linux driver should not rely on such a thing. So lets
> >> read the MAC address from the DT as it should be done here.
> >>
> >> The following priority is now used to read the MAC address:
> >>
> >> 1) First, try OF node MAC address, if not present or invalid, then:
> >>
> >> 2) Read from MAC address registers, if invalid, then:
> >
> > Why we read from MAC registers if Linux should not rely on bootloader?
>=20
> It was suggested by David. Backwards compatibility. Here Davids comment t=
o my
> original patch which removed this register reading completely:
>=20
> "
> I don't think this is a conservative enough change.
>=20
> You have to keep the MAC register reading code around, as a backup code p=
ath in
> case the OF device node lacks a MAC address "

Ok,

But this is really a backward compatibility or hiding some bug? My thought =
is that if DT does not have a valid MAC address then it is a BUG and should=
 be fixed. Is not it?

-Bharat

>=20
> Thanks,
> Stefan
