Return-Path: <afleming@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 53C54B709A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 06:19:24 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0C90DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 06:19:22 +1000 (EST)
Message-Id: <ED58F994-6BDC-4496-8445-EA1D984F1379@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090624182734.GA14306@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] gianfar: Fix half-duplex operation for non-MII/RMII
	interfaces
Date: Wed, 24 Jun 2009 15:18:59 -0500
References: <20090624182734.GA14306@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Li Yang <leoli@freescale.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 24, 2009, at 1:27 PM, Anton Vorontsov wrote:

> It appears that gianfar driver has the same problem[1] that I
> just fixed for ucc_geth.
>
> NFS boot using 10/half link takes about 10 minutes to complete:
>

>
> The symptoms were observed on MPC8379E-RDB boards (eTSEC). Although
> I didn't find where documentation forbids clearing Full Duplex bit
> for non-MII/RMII modes, it's pretty distinct that the bit should be
> set.
>
> It's no wonder though, QE Ethernet and TSEC are pretty similar.

> -			if (!(phydev->duplex))
> -				tempval &= ~(MACCFG2_FULL_DUPLEX);
> +			if (!phydev->duplex &&
> +					(phyi == PHY_INTERFACE_MODE_MII ||
> +					 phyi == PHY_INTERFACE_MODE_RMII))


Hmm....have you tested this on a GMII interface?  *Technically*, full  
duplex is required for GMII, as GMII is used only for gigabit.   
However, we've been treating the GMII interface type as an indicator  
that the PHY *has* a GMII connection to the NIC.  When gianfar detects  
the speed is 10/100 it switches to the compatible MII interface via  
this code, just below:

                         case 100:
                         case 10:
                                 tempval =
                                     ((tempval & ~(MACCFG2_IF)) |  
MACCFG2_MII);


My concern is that you will be detecting the GMII interface, and  
disallowing half-duplex, despite the fact that the interface is  
actually running at 10 or 100 Mbit.

Andy
