Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ztGp82C3LzF1lQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Mar 2018 04:42:07 +1100 (AEDT)
Subject: Re: [PATCH 17/18] crypto: talitos - chain in buffered data for ahash
 on SEC1
To: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <28d351a973d31d140239c7e7e64999d95a011e8c.1507284818.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3342BDF9D4E389B4E296A53298C50@VI1PR0402MB3342.eurprd04.prod.outlook.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <355bc65b-fbc4-deee-058a-999e5b740819@c-s.fr>
Date: Fri, 2 Mar 2018 18:42:00 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB3342BDF9D4E389B4E296A53298C50@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 02/03/2018 à 18:27, Horia Geantă a écrit :
> On 10/6/2017 4:05 PM, Christophe Leroy wrote:
> [...]
>> @@ -1778,6 +1814,36 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
>>   	if (is_sec1 && from_talitos_ptr_len(&desc->ptr[3], true) == 0)
>>   		talitos_handle_buggy_hash(ctx, edesc, &desc->ptr[3]);
>>   
>> +	if (is_sec1 && req_ctx->nbuf && length) {
>> +		struct talitos_desc *desc2 = desc + 1;
>> +		dma_addr_t next_desc;
> [...]
>> +		next_desc = dma_map_single(dev, &desc2->hdr1, TALITOS_DESC_SIZE,
>> +					   DMA_BIDIRECTIONAL);
>> +		desc->next_desc = cpu_to_be32(next_desc);
> Where is desc->next_desc initialized for the !is_sec1 case?
> Memory allocation is done using kmalloc(), and since desc->next_desc is checked
> in some cases also for SEC 2.x+, it should be initialized to 0.

See 
https://elixir.bootlin.com/linux/v4.16-rc3/source/drivers/crypto/talitos.c#L1411

	edesc = kmalloc(alloc_len, GFP_DMA | flags);
	if (!edesc) {
		dev_err(dev, "could not allocate edescriptor\n");
		err = ERR_PTR(-ENOMEM);
		goto error_sg;
	}
	memset(&edesc->desc, 0, sizeof(edesc->desc));


Christophe
