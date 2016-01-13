Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA3D81A028C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:09:00 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jan 2016 16:08:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7DB3C3578058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:08:57 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0D68p0w30867528
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:08:59 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0D68OAb015143
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 17:08:25 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: paulus@samba.org, mpe@ellerman.id.au, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V1 14/33] powerpc/mm: Use helper for finding pte bits
 mapping I/O area
In-Reply-To: <1452657437.2403.17.camel@kernel.crashing.org>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1452582968-22669-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAOJe8K0sgNvOA5pP8jUt7rpfstW2d-hqOOjSXszihLDkpT4JXQ@mail.gmail.com>
 <1452657437.2403.17.camel@kernel.crashing.org>
Date: Wed, 13 Jan 2016 11:37:57 +0530
Message-ID: <87pox6c8qq.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2016-01-12 at 10:42 +0300, Denis Kirjanov wrote:
>> > +static inline unsigned long pte_io_cache_bits(void)
>> > +{
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return _PAGE_NO_CACHE | _PAGE_GUARDED;
>> > +}
>> This could be just plain #define
>
> Or just use=C2=A0pgprot_noncached()
>
#define pgprot_noncached(prot)	  (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE=
_CTL) | \
				            _PAGE_NO_CACHE | _PAGE_GUARDED))


That will return me a pgprot_t.  I can fix that by using
pgprot_val(pgprot_noncached(0)). Is that what you are suggesting ?

-aneesh
