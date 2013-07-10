Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B91A72C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 06:30:18 +1000 (EST)
Date: Wed, 10 Jul 2013 15:30:05 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: =?UTF-8?b?562U5aSNOg==?= [PATCH] Powerpc/t4240: change the
 compatible flags for t4240qds board
To: Zhang Haijun-B42677 <B42677@freescale.com>
References: <99E897753B6F7048BD8CCDB4661D02E1396F57@039-SN2MPN1-021.039d.mgd.msft.net>
 <1373400262.8183.201@snotra>
 <99E897753B6F7048BD8CCDB4661D02E139CE27@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <99E897753B6F7048BD8CCDB4661D02E139CE27@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B42677@freescale.com on Tue Jul  9 22:41:22 2013)
Message-ID: <1373488205.8183.228@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Wrobel Heinz-R39252 <r39252@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2013 10:41:22 PM, Zhang Haijun-B42677 wrote:
> > No.  It's still supposed to be describing the sdhc block itself, =20
> not the
> > board -- and any workarounds that key off of this will still fail =20
> to work
> > with existing device trees.
> [Haijun Wrote:] So, leave dts unchanged and to check compitable for =20
> board in sdhci-pltfm.c
> e.g.:
> 	unsigned long root =3D of_get_flat_dt_root();
>=20
> 	if (of_flat_dt_is_compatible(root, "fsl,T4240QDS"))
> 		host->quirks |=3D XXX;

Why are you looking at the flat tree at this point?  Use the normal OF =20
accessors.  The flat stuff is only for early boot.

Also make sure that you only do this for quirks that are actually =20
board-specific.  In your last patch you had two quirks keyed off of the =20
board, one of which is keyed off of the SoC for other chips.

-SCott=
