Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhj9W0j0QzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 07:55:10 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7TLsMub053630
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:55:07 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cnaxe8qm7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:55:07 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 15:55:06 -0600
Date: Tue, 29 Aug 2017 14:54:54 -0700
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Dan Streetman <ddstreet@ieee.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 mikey@neuling.org, suka@us.ibm.com, Ram Pai <linuxram@us.ibm.com>,
 npiggin@gmail.com, Haren Myneni <hbabu@us.ibm.com>
Subject: Re: [PATCH V3 6/6] crypto/nx: Add P9 NX support for 842 compression
 engine
References: <1500699702.23205.8.camel@hbabu-laptop>
 <CALZtONBGVQy2iwkb8WpVd-_QG7bLFTvUbnuub6CCXP55YpQiSQ@mail.gmail.com>
 <1504041817.2358.32.camel@kernel.crashing.org>
In-Reply-To: <1504041817.2358.32.camel@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <59A5E2AE.5060400@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/29/2017 02:23 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2017-08-29 at 09:58 -0400, Dan Streetman wrote:
>>> +
>>> +       ret = -EINVAL;
>>> +       if (coproc && coproc->vas.rxwin) {
>>> +               wmem->txwin = nx842_alloc_txwin(coproc);
>>
>> this is wrong.  the workmem is scratch memory that's valid only for
>> the duration of a single operation.

Correct, workmem is used until crypto_free is called. 
>>
>> do you actually need a txwin per crypto transform?  or do you need a
>> txwin per coprocessor?  or txwin per processor?  either per-coproc or
>> per-cpu should be created at driver init and held separately
>> (globally) instead of a per-transform txwin.  I really don't see why
>> you would need a txwin per transform, because the coproc should not
>> care how many different transforms there are.
> 
> We should only need a single window for the whole kernel really, plus
> one per user process who wants direct access but that's not relevant
> here.

Opening send window for each crypto transform (crypto_alloc, compression/decompression, ..., crypto_free) so that does not have to wait for the previous copy/paste complete. VAS will map send and receive windows, and can cache in send windows (up to 128). So I thought using the same send window (per chip) for more requests (say 1000) may be adding overhead.

I will make changes if you prefer using 1 send window per chip.  

> 
> Cheers,
> Ben.
> 
