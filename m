Return-Path: <herbert@gondor.apana.org.au>
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlxp44VdKzDr0H
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 21:35:00 +1100 (AEDT)
Date: Tue, 20 Feb 2018 18:34:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 "David S. Miller" <davem@davemloft.net>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 16/18] crypto: talitos - do hw_context DMA mapping
 outside the requests
Message-ID: <20180220103436.GA20571@gondor.apana.org.au>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <e47bf94ae44f23230b1647e31c9623f1075d3b79.1507284818.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3342A0A8530F74D408CA2F0298FC0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <2338eb8d-a26a-9722-d667-5a9785b32977@c-s.fr>
 <VI1PR0402MB3342D90D574C8829701882BE98C90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <630c313c-5eca-224d-a5ac-fb3f2783573a@c-s.fr>
 <VI1PR0402MB334256E1706A4E1AED09F4A598C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <d5809df9-fc17-03da-b7f4-038d973dbd1f@c-s.fr>
 <VI1PR0402MB334299B37F17771BFA9AFDDA98C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <VI1PR0402MB334299B37F17771BFA9AFDDA98C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 19, 2018 at 01:16:30PM +0000, Horia Geantă wrote:
>
> > And what about ALGIF path from user space ?
> > What if the user never calls the last sendmsg() which will call 
> > hash_finup() ?
> > 
> User is expected to follow the rules of the crypto API.
> Of course, kernel won't (or at least shouldn't) crash in case of misuse.
> However, in these cases some resources might not be freed - it's unavoidable.

the crypto API does not require the presence of a finalisation.
It is entirely optional.  So leaving resources pinned down until
final/finup occurs is unacceptable, both from user-space and the
kernel.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
