Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A4036B70A2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 07:11:48 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id D3D3DDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 07:11:47 +1000 (EST)
Date: Thu, 25 Jun 2009 01:10:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] gianfar: Fix half-duplex operation for non-MII/RMII
	interfaces
Message-ID: <20090624211038.GA29555@oksana.dev.rtsoft.ru>
References: <20090624182734.GA14306@oksana.dev.rtsoft.ru>
	<ED58F994-6BDC-4496-8445-EA1D984F1379@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <ED58F994-6BDC-4496-8445-EA1D984F1379@freescale.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Li Yang <leoli@freescale.com>, David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 24, 2009 at 03:18:59PM -0500, Andy Fleming wrote:
>
> On Jun 24, 2009, at 1:27 PM, Anton Vorontsov wrote:
>
>> It appears that gianfar driver has the same problem[1] that I
>> just fixed for ucc_geth.
>>
>> NFS boot using 10/half link takes about 10 minutes to complete:
>>
>
>>
>> The symptoms were observed on MPC8379E-RDB boards (eTSEC). Although
>> I didn't find where documentation forbids clearing Full Duplex bit
>> for non-MII/RMII modes, it's pretty distinct that the bit should be
>> set.
>>
>> It's no wonder though, QE Ethernet and TSEC are pretty similar.
>
>> -			if (!(phydev->duplex))
>> -				tempval &= ~(MACCFG2_FULL_DUPLEX);
>> +			if (!phydev->duplex &&
>> +					(phyi == PHY_INTERFACE_MODE_MII ||
>> +					 phyi == PHY_INTERFACE_MODE_RMII))
>
>
> Hmm....have you tested this on a GMII interface?

Nope, only RGMII.

>  *Technically*, full  
> duplex is required for GMII, as GMII is used only for gigabit.  However, 
> we've been treating the GMII interface type as an indicator that the PHY 
> *has* a GMII connection to the NIC.  When gianfar detects the speed is 
> 10/100 it switches to the compatible MII interface via this code, just 
> below:
>
>                         case 100:
>                         case 10:
>                                 tempval =
>                                     ((tempval & ~(MACCFG2_IF)) |  
> MACCFG2_MII);
>
>
> My concern is that you will be detecting the GMII interface, and  
> disallowing half-duplex, despite the fact that the interface is actually 
> running at 10 or 100 Mbit.

Very interesting, though I'm not sure I'm completely following. :-)

Are you saying that I should do this instead:

	if (!phydev->duplex &&
			(phyi == PHY_INTERFACE_MODE_MII ||
			 phyi == PHY_INTERFACE_MODE_RMII ||
			 (phyi == PHY_INTERFACE_MODE_GMII &&
			  phydev->speed < 1000)))
		tempval &= ~MACCFG2_FULL_DUPLEX;
	else
		tempval |= MACCFG2_FULL_DUPLEX;

i.e. we detected GMII interface initially, but it downgraded
to MII since speed is < 1000, thus we can set half-duplex in MAC?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
