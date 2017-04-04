Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy5s42rnyzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 21:11:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Haren Myneni <haren@linux.vnet.ibm.com>, herbert@gondor.apana.org.au,
 ddstreet@ieee.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 benh@kernel.crashing.org, mikey@neuling.org, suka@us.ibm.com, hbabu@us.ibm.com
Subject: Re: [PATCH 1/5] crypto/nx: Rename nx842_powernv_function as icswx
 function
In-Reply-To: <1491065941.29552.26.camel@hbabu-laptop>
References: <1491065941.29552.26.camel@hbabu-laptop>
Date: Tue, 04 Apr 2017 21:11:51 +1000
Message-ID: <87inmkv348.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Haren Myneni <haren@linux.vnet.ibm.com> writes:

> [PATCH 1/5] crypto/nx: Rename nx842_powernv_function as icswx function
>
> nx842_powernv_function is points to nx842_icswx_function and
> will be point to VAS function which will be added later for
> P9 NX support.

I know it's nit-picking but can you give it a better name while you're
there.

I was thinking it should be called "send" or something, but it actually
synchronously sends and waits for a request.

So perhaps just nx842_exec(), for "execute a request", and then you can
have nx842_exec_icswx() and nx842_exec_vas().

cheers
