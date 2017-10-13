Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yDCYs0zsmzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 03:18:08 +1100 (AEDT)
Date: Fri, 13 Oct 2017 17:18:09 +0100
From: Will Deacon <will.deacon@arm.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 Michal Hocko <mhocko@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
 sam@ravnborg.org, mgorman@techsingularity.net,
 Steve Sistare <steven.sistare@oracle.com>,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
Message-ID: <20171013161809.GE4746@arm.com>
References: <20171010155619.GA2517@arm.com>
 <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
 <20171010171047.GC2517@arm.com>
 <CAOAebxtrSthSP4NAa0obBbsCK1KZxO+x0w5xNrpY6m2y9UZFvQ@mail.gmail.com>
 <CAOAebxu5WL-FQLgfCxNcWy36V6zsTO1v3LLqXv5rM1Pp9R-=YA@mail.gmail.com>
 <20171013144319.GB4746@arm.com>
 <CAOAebxv4h+8ej6JA_DZbXaNV5JsAk4MbcCLf1+2RvwKGF2+MxQ@mail.gmail.com>
 <20171013154426.GC4746@arm.com>
 <CAOAebxspETEqFXL1Ez_4TK9CAwwk+uhHbYOmZk2QR8b=GO80cQ@mail.gmail.com>
 <CAOAebxv=u4cKS=_Bvyqs7pDA=5Oi0HNWvC4zRmhCiaEUMgQu3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOAebxv=u4cKS=_Bvyqs7pDA=5Oi0HNWvC4zRmhCiaEUMgQu3w@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 13, 2017 at 12:00:27PM -0400, Pavel Tatashin wrote:
> BTW, don't we need the same aligments inside for_each_memblock() loop?

Hmm, yes actually, given that we shift them right for the shadow address.

> How about change kasan_map_populate() to accept regular VA start, end
> address, and convert them internally after aligning to PAGE_SIZE?

That's what my original patch did, but it doesn't help on its own because
kasan_populate_zero_shadow would need the same change.

Will
