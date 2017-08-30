Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjCbp6cx2zDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 03:46:14 +1000 (AEST)
Date: Wed, 30 Aug 2017 10:46:08 -0700 (PDT)
Message-Id: <20170830.104608.2080967179463692935.davem@davemloft.net>
To: pasha.tatashin@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, willy@infradead.org, mhocko@kernel.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com, catalin.marinas@arm.com,
 sam@ravnborg.org, mgorman@techsingularity.net, Steven.Sistare@oracle.com,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v7 07/11] sparc64: optimized struct page zeroing
From: David Miller <davem@davemloft.net>
In-Reply-To: <e07c05b1-c0be-bf7f-9a29-11dc41b79d10@oracle.com>
References: <1503972142-289376-8-git-send-email-pasha.tatashin@oracle.com>
 <20170829.181208.171985548699678313.davem@davemloft.net>
 <e07c05b1-c0be-bf7f-9a29-11dc41b79d10@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 30 Aug 2017 09:19:58 -0400

> The reason I am not doing initializing stores is because they require
> a membar, even if only regular stores are following (I hoped to do a
> membar before first load). This is something I was thinking was not
> true, but after consulting with colleagues and checking processor
> manual, I verified that it is the case.

Oh yes, that's right, now I remember.
