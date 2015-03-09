Return-Path: <Horia.Geanta@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0105.outbound.protection.outlook.com [157.56.111.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A42C41A0008
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 23:08:44 +1100 (AEDT)
Message-ID: <54FD8D3B.5040409@freescale.com>
Date: Mon, 9 Mar 2015 14:08:27 +0200
From: =?UTF-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@freescale.com>
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 5/5] crypto: talitos: Add software backlog queue
 handling
References: <1425388897-5434-1-git-send-email-mort@bork.org>
 <1425388897-5434-6-git-send-email-mort@bork.org>
 <20150303182332.546523088b5891a776880c0f@freescale.com>
 <54F8235B.5080301@freescale.com> <20150306044821.GA1411@gondor.apana.org.au>
In-Reply-To: <20150306044821.GA1411@gondor.apana.org.au>
Content-Type: text/plain; charset="utf-8"
Cc: Martin Hicks <mort@bork.org>, linux-crypto@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/6/2015 6:48 AM, Herbert Xu wrote:
> On Thu, Mar 05, 2015 at 11:35:23AM +0200, Horia Geantă wrote:
>>
>>> Only potential problem is getting the crypto API to set the GFP_DMA
>>> flag in the allocation request, but presumably a
>>> CRYPTO_TFM_REQ_DMA crt_flag can be made to handle that.
>>
>> Right. And this flag would apply only to request __ctx[].
>>
>> Herbert, would this be an acceptable addition to crypto API?
> 
> How would such a flag work?

Hm, I thought that GFP_DMA memory could be allocated only for request
private ctx. This is obviously not the case.

*_request_alloc(tfm, gfp) crypto API functions would do:
if (crypto_tfm_get_flags(tfm) & CRYPTO_TFM_REQ_DMA)
        gfp |= GFP_DMA;

Thanks,
Horia
