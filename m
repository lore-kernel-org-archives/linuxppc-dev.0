Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 37037B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 05:27:25 +1100 (EST)
Date: Wed, 29 Feb 2012 13:25:13 -0500 (EST)
Message-Id: <20120229.132513.1607879808995168004.davem@davemloft.net>
To: jwboyer@gmail.com
Subject: Re: [PATCH 2/2] powerpc/44x: Add more changes for APM821XX EMAC driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <CA+5PVA5hciQSvfkodX-oP_kUZueiTp=0+t8X_0iHQ+ehU0ecOQ@mail.gmail.com>
References: <1329466058-15969-1-git-send-email-dhdang@apm.com>
 <CA+5PVA5hciQSvfkodX-oP_kUZueiTp=0+t8X_0iHQ+ehU0ecOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: dhdang@apm.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Josh Boyer <jwboyer@gmail.com>
Date: Wed, 29 Feb 2012 08:43:46 -0500

> On Fri, Feb 17, 2012 at 3:07 AM, Duc Dang <dhdang@apm.com> wrote:
>> This patch includes:
>>
>> =A0Configure EMAC PHY clock source (clock from PHY or internal clock=
).
>>
>> =A0Do not advertise PHY half duplex capability as APM821XX EMAC does=
 not
>> support half duplex mode.
>>
>> =A0Add changes to support configuring jumbo frame for APM821XX EMAC.=

>>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
> =

> This should have been sent to netdev.  CC'ing them now.
> =

> Ben and David, I can take this change through the 4xx tree if it look=
s OK to
> both of you.  The pre-requisite DTS patch will go through my tree, so=
 it might
> make sense to keep them together.

Well the patch has coding style problems, for one:

>> +			dev->features |=3D (EMAC_APM821XX_REQ_JUMBO_FRAME_SIZE
>> +					| EMAC_FTR_APM821XX_NO_HALF_DUPLEX
>> +					| EMAC_FTR_460EX_PHY_CLK_FIX);

Should be:

>> +			dev->features |=3D (EMAC_APM821XX_REQ_JUMBO_FRAME_SIZE |
>> +					  EMAC_FTR_APM821XX_NO_HALF_DUPLEX |
>> +					  EMAC_FTR_460EX_PHY_CLK_FIX);

And this:

>> +		dev->phy_feat_exc =3D (SUPPORTED_1000baseT_Half
>> +					| SUPPORTED_100baseT_Half
>> +					| SUPPORTED_10baseT_Half);

Should be:

>> +		dev->phy_feat_exc =3D (SUPPORTED_1000baseT_Half |
>> +				     SUPPORTED_100baseT_Half |
>> +				     SUPPORTED_10baseT_Half);
