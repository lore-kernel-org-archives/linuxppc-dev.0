Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVylM4yNGzDqs8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 08:30:55 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rVylL5wzqz9t1N
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 08:30:54 +1000 (AEST)
Message-ID: <1466116236.24271.26.camel@kernel.crashing.org>
Subject: Re: kernel bug in "Drop WIMG in favour of new constants"?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Darrick J. Wong"
 <darrick.wong@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Date: Fri, 17 Jun 2016 08:30:36 +1000
In-Reply-To: <87twgt8ask.fsf@skywalker.in.ibm.com>
References: <20160616043340.GB22590@birch.djwong.org>
 <1466054627.5400.5.camel@ellerman.id.au>
 <20160616055746.GC22590@birch.djwong.org>
 <8737oda1lt.fsf@skywalker.in.ibm.com>
 <87ziql8l93.fsf@skywalker.in.ibm.com>
 <87wplp8kxh.fsf@skywalker.in.ibm.com>
 <87twgt8ask.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-16 at 20:01 +0530, Aneesh Kumar K.V wrote:
> The pHyp part of the comment was added by you in 
> 3c726f8dee6f55e96475574e9f645327e461884c ([PATCH] ppc64: support 64k
> page) really an old commit. I also remember we having the discussion and
> concluding that it should be safe to assume that we can always enable
> memory coherence. Should we do the below patch of get Qemu fixed up ?
> like below
> 
> -        if ((ptel & (HPTE64_R_W | HPTE64_R_I | HPTE64_R_M)) != HPTE64_R_I) {
> +        wimg_flags = (ptel & (HPTE64_R_W | HPTE64_R_I | HPTE64_R_M));
> +
> +        if (wimg_flags != HPTE64_R_I && wimg_flags != (HPTE64_R_I | HPTE64_R_M)) {
>              return H_PARAMETER;
>          }

Makes sense.

Cheers,
Ben.
