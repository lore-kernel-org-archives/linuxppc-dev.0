Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420cFl4xCMzF0PW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 17:10:02 +1000 (AEST)
Subject: Re: [PATCH 1/6] net/wan/fsl_ucc_hdlc: allow ucc index up to 4
To: David Gounaris <david.gounaris@infinera.com>, qiang.zhao@nxp.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180828110921.2542-1-david.gounaris@infinera.com>
 <20180828110921.2542-2-david.gounaris@infinera.com>
 <917e8baf-3623-6fde-fed0-9ff859b72fea@c-s.fr>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <417caa76-2f37-d220-fb52-326529eb83af@c-s.fr>
Date: Wed, 29 Aug 2018 09:09:56 +0200
MIME-Version: 1.0
In-Reply-To: <917e8baf-3623-6fde-fed0-9ff859b72fea@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 28/08/2018 à 15:34, Christophe LEROY a écrit :
> 
> 
> Le 28/08/2018 à 13:09, David Gounaris a écrit :
>> There is a need to allow higher indexes to be
>> able to support MPC83xx platforms. (UCC1-UCC5)
> 
> As far as I can see, MPC8358 has 8 UCCs (ref 
> https://www.nxp.com/products/processors-and-microcontrollers/power-architecture-processors/powerquicc-processors/powerquicc-ii-pro/powerquicc-ii-pro-processor-with-ddr2-tdm-pci-security-usb-quicc-engine-with-1-gb-ethernet-utopia:MPC8358E) 

Indeed, the code should use UCC_MAX_NUM which is defined in 
include/soc/fsl/qe/ucc.h

Christophe

> 
> 
> Christophe
> 
>>
>> Signed-off-by: David Gounaris <david.gounaris@infinera.com>
>> ---
>>   drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c 
>> b/drivers/net/wan/fsl_ucc_hdlc.c
>> index 5f0366a125e2..3c0e0a1d19ba 100644
>> --- a/drivers/net/wan/fsl_ucc_hdlc.c
>> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
>> @@ -1015,7 +1015,7 @@ static int ucc_hdlc_probe(struct platform_device 
>> *pdev)
>>       }
>>       ucc_num = val - 1;
>> -    if ((ucc_num > 3) || (ucc_num < 0)) {
>> +    if ((ucc_num > 4) || (ucc_num < 0)) {
>>           dev_err(&pdev->dev, ": Invalid UCC num\n");
>>           return -EINVAL;
>>       }
>>
