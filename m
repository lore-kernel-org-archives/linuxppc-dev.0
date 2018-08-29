Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420cR24dqnzDrJ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 17:18:06 +1000 (AEST)
Subject: Re: [PATCH 4/6] net/wan/fsl_ucc_hdlc: default hmask value
To: Qiang Zhao <qiang.zhao@nxp.com>,
 David Gounaris <david.gounaris@infinera.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20180828110921.2542-1-david.gounaris@infinera.com>
 <20180828110921.2542-5-david.gounaris@infinera.com>
 <VI1PR04MB3247E6EBE63C39F5E1C792F191090@VI1PR04MB3247.eurprd04.prod.outlook.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <4244fe46-e8ed-9fd2-d243-cc84e7264a88@c-s.fr>
Date: Wed, 29 Aug 2018 09:18:01 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB3247E6EBE63C39F5E1C792F191090@VI1PR04MB3247.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/08/2018 à 04:54, Qiang Zhao a écrit :
> From: David Gounaris <david.gounaris@infinera.com>
> Date: 2018/8/28 19:09
>> Subject: [PATCH 4/6] net/wan/fsl_ucc_hdlc: default hmask value
>>
>> Set default HMASK to 0x0000 to use
>> promiscuous mode in the hdlc controller.

Why do you need to do that ?

An HDLC frame encapsulating Ethernet should look like:

HDLC Frame includes:
– Opening Flag		7E hex
– Address field		FF hex
– Control field		03 hex
– Information field	Original Ethernet Packet, 1522 octets max.
– FCS CRC16		(2 bytes)
– Closing Flag		7E hex

What do you mean by 'promiscuous mode' ?

In any case, should a filter mask be changed for promiscuous mode, I 
believe the change should be done at the time you enter promiscuous 
mode, not at all time.

Christophe

>>
>> Signed-off-by: David Gounaris <david.gounaris@infinera.com>
>> ---
>>   drivers/net/wan/fsl_ucc_hdlc.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wan/fsl_ucc_hdlc.h b/drivers/net/wan/fsl_ucc_hdlc.h
>> index c21134c1f180..5bc3d1a6ca6e 100644
>> --- a/drivers/net/wan/fsl_ucc_hdlc.h
>> +++ b/drivers/net/wan/fsl_ucc_hdlc.h
>> @@ -134,7 +134,7 @@ struct ucc_hdlc_private {
>>
>>   #define HDLC_HEAD_MASK		0x0000
>>   #define DEFAULT_HDLC_HEAD	0xff44
>> -#define DEFAULT_ADDR_MASK	0x00ff
>> +#define DEFAULT_ADDR_MASK	0x0000
>>   #define DEFAULT_HDLC_ADDR	0x00ff
>>
>>   #define BMR_GBL			0x20000000
>> --
> 
> It is not proper to set default HMASK to 0x0000, how about to add a new property standing for hmask into device tree,
> If get this property from dtb, then set it with the value from dtb, otherwise, set it with default HMASK ox00ff?
> 
> Best Regards
> Qiang Zhao
> 
