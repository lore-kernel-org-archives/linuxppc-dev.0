Return-Path: <horia.geanta@nxp.com>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50079.outbound.protection.outlook.com [40.107.5.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zktlZ6bDkzDrJn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 04:14:09 +1100 (AEDT)
From: =?windows-1258?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 16/18] crypto: talitos - do hw_context DMA mapping outside
 the requests
Date: Sun, 18 Feb 2018 17:14:03 +0000
Message-ID: <VI1PR0402MB3342D90D574C8829701882BE98C90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <e47bf94ae44f23230b1647e31c9623f1075d3b79.1507284818.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3342A0A8530F74D408CA2F0298FC0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <2338eb8d-a26a-9722-d667-5a9785b32977@c-s.fr>
Content-Type: text/plain; charset="windows-1258"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/17/2018 6:32 PM, Christophe LEROY wrote:=0A=
> =0A=
> =0A=
> Le 07/02/2018 =E0 15:39, Horia Geant=E3 a =E9crit=A0:=0A=
>> On 10/6/2017 4:06 PM, Christophe Leroy wrote:=0A=
>>> At every request, we map and unmap the same hash hw_context.=0A=
>>>=0A=
>>> This patch moves the dma mapping/unmapping in functions ahash_init()=0A=
>>> and ahash_import().=0A=
>>>=0A=
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>=0A=
>>> ---=0A=
>>>   drivers/crypto/talitos.c | 80 ++++++++++++++++++++++++++++++++++-----=
---------=0A=
>>>   1 file changed, 57 insertions(+), 23 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c=0A=
>>> index ebfd6d982ed6..d495649d5267 100644=0A=
>>> --- a/drivers/crypto/talitos.c=0A=
>>> +++ b/drivers/crypto/talitos.c=0A=
>>> @@ -819,6 +819,7 @@ struct talitos_ctx {=0A=
>>>   	unsigned int keylen;=0A=
>>>   	unsigned int enckeylen;=0A=
>>>   	unsigned int authkeylen;=0A=
>>> +	dma_addr_t dma_hw_context;=0A=
>> This doesn't look correct.=0A=
>>=0A=
>> talitos_ctx structure is the tfm context.=0A=
>> dma_hw_context is the IOVA of hw_context, located in talitos_ahash_req_c=
tx=0A=
>> structure (request context).=0A=
> =0A=
> Yes but I have now found how I can know that the request context is =0A=
> being released in order to unmap() dma at that time.=0A=
> It is tricky to use the tmf context I agree, but at least I know when =0A=
> tmf context get destroyed, ie in talitos_cra_exit_ahash()=0A=
> The request context is created by ahash_request_alloc() and released by=
=0A=
> ahash_request_free(). I have not found the way to call dma_unmap() =0A=
> before ahash_request_free() gets called.=0A=
> =0A=
>>=0A=
>> If there are multiple requests in flight for the same tfm, dma_hw_contex=
t will=0A=
>> be overwritten.=0A=
> =0A=
> Before overwritting dma_hw_context, it is always released, see =0A=
> talitos_cra_exit_ahash(), ahash_init(), ahash_import()=0A=
> =0A=
The problem is not the unmapping.=0A=
If there are two requests for the same tfm, then given the following sequen=
ce=0A=
1. tfm->ahash_init(req1)=0A=
	tfm_ctx->dma_hw_context points to req1_ctx->hw_context=0A=
2. tfm->ahash_init(req2)=0A=
	tfm_ctx->dma_hw_context [unmapped, then] points to req2_ctx->hw_context=0A=
i.e. req1 will use the hw_context of req2.=0A=
=0A=
>>=0A=
>> dma_hw_context needs to be moved in request context (talitos_ahash_req_c=
tx struct).=0A=
> =0A=
> Any suggestion then on how to handle the issue explained above ?=0A=
> =0A=
There is no ahash_exit() callback mirroring ahash_init().=0A=
=0A=
The clean-up of request ctx should be done in the last states of the hash f=
lows=0A=
described here:=0A=
https://www.kernel.org/doc/html/latest/crypto/devel-algos.html#cipher-defin=
ition-with-struct-shash-alg-and-ahash-alg=0A=
for e.g. in the final() callback.=0A=
=0A=
Hope this helps,=0A=
Horia=0A=
