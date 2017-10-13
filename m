Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDC9Y2cd2zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 03:00:33 +1100 (AEDT)
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v9DG0UYK006596
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 16:00:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v9DG0TA0014478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 16:00:29 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v9DG0Tku025656
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 16:00:29 GMT
Received: by mail-oi0-f52.google.com with SMTP id v9so14991485oif.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 09:00:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOAebxspETEqFXL1Ez_4TK9CAwwk+uhHbYOmZk2QR8b=GO80cQ@mail.gmail.com>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-8-pasha.tatashin@oracle.com>
 <20171010155619.GA2517@arm.com>
 <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
 <20171010171047.GC2517@arm.com>
 <CAOAebxtrSthSP4NAa0obBbsCK1KZxO+x0w5xNrpY6m2y9UZFvQ@mail.gmail.com>
 <CAOAebxu5WL-FQLgfCxNcWy36V6zsTO1v3LLqXv5rM1Pp9R-=YA@mail.gmail.com>
 <20171013144319.GB4746@arm.com>
 <CAOAebxv4h+8ej6JA_DZbXaNV5JsAk4MbcCLf1+2RvwKGF2+MxQ@mail.gmail.com>
 <20171013154426.GC4746@arm.com>
 <CAOAebxspETEqFXL1Ez_4TK9CAwwk+uhHbYOmZk2QR8b=GO80cQ@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 13 Oct 2017 12:00:27 -0400
Message-ID: <CAOAebxv=u4cKS=_Bvyqs7pDA=5Oi0HNWvC4zRmhCiaEUMgQu3w@mail.gmail.com>
Subject: Re: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 Michal Hocko <mhocko@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
 sam@ravnborg.org, mgorman@techsingularity.net,
 Steve Sistare <steven.sistare@oracle.com>, daniel.m.jordan@oracle.com,
 bob.picco@oracle.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BTW, don't we need the same aligments inside for_each_memblock() loop?

How about change kasan_map_populate() to accept regular VA start, end
address, and convert them internally after aligning to PAGE_SIZE?

Thank you,
Pavel


On Fri, Oct 13, 2017 at 11:54 AM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>> Thanks for sharing the .config and tree. It looks like the problem is that
>> kimg_shadow_start and kimg_shadow_end are not page-aligned. Whilst I fix
>> them up in kasan_map_populate, they remain unaligned when passed to
>> kasan_populate_zero_shadow, which confuses the loop termination conditions
>> in e.g. zero_pte_populate and the shadow isn't configured properly.
>
> This makes sense. Thank you. I will insert these changes into your
> patch, and send out a new series soon after sanity checking it.
>
> Pavel
