Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A18D62C0294
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 05:08:00 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Feb 2013 23:35:02 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DB654125804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 23:38:33 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1DI7n2q29229182
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 23:37:49 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1DI7pjM025231
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 05:07:52 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Laight <David.Laight@aculab.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 phileas-fogg@mail.ru, geoff@infradead.org
Subject: RE: [PATCH 2/2] powerpc: Make context bits depend on virtual addr
 size.
In-Reply-To: <87mwv8jnmj.fsf@linux.vnet.ibm.com>
References: <1360693905-23503-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360693905-23503-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360701185.2035.10.camel@pasglop> <87sj50kian.fsf@linux.vnet.ibm.com>
 <1360727211.2035.30.camel@pasglop> <87pq04jvb4.fsf@linux.vnet.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7148@saturn3.aculab.com>
 <87mwv8jnmj.fsf@linux.vnet.ibm.com>
Date: Wed, 13 Feb 2013 23:37:51 +0530
Message-ID: <87halgjde0.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> David Laight <David.Laight@aculab.com> writes:
>
>>> +#define CONTEXT_BITS		19
>>> +#define USER_ESID_BITS		18
>>> +#define USER_ESID_BITS_1T	6
>>> +
>>> +/*
>>> + * 256MB segment
>>> + * The proto-VSID space has 2^(CONTEX_BITS + USER_ESID_BITS) - 1 segments
>>> + * available for user + kernel mapping. The top 4 contexts are used for
>>> + * kernel mapping. Each segment contains 2^28 bytes. Each
>>> + * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
>>> + * (19 == 37 + 28 - 46).
>>> + */
>>
>> I can't help feeling this would be easier to understand if a full
>> 64? 80? bit address was shown with the various bit ranges identified.
>>
>> Given the comment, I'd have expected CONTEXT_BITS to be calculated
>> from three other named constants - rather than being set to 19.
>>
>
> May be the comments were misleading. We build proto vsid using a
> combination of context and ea bits.
>
> Current code does the below:
>
> for kernel:
> proto_vsid = ea >> SID_SHIFT;
> proto_vsid |= (1UL << (CONTEXT_BITS + USER_ESID_BITS));
> for user:
> proto_vsid = ea >> SID_SHIFT
> proto_vsid |= context << USER_ESID_BITS 
>
> context range is 0 - (2^19 -1)
>
> With this patch we _don't_ give kernel half the proto vsid range.
> Instead, we reduce the proto vsid range and then the kernel is given
> top 4 context. ie, kernel proto vsid is now
>
> for kenel:
> proto_vsid = ea >> SID_SHIFT;
> context = (MAX_CONTEXT - 4) +  ((effective address >> 60) - 0xc);
> proto_vsid |= context << USER_ESID_BITS 
>

Hmm that may be an issue, considering ESID for kernel is 36 bits.
We have overlapping bits between shifted value of context and kernel
ESID.

-aneesh
