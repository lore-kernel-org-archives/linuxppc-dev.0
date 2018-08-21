Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vgz43qh0zF1Wr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 16:40:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Michal Hocko <mhocko@kernel.org>, Ram Pai <linuxram@us.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-mm <linux-mm@kvack.org>
Subject: Re: Odd SIGSEGV issue introduced by commit 6b31d5955cb29 ("mm,
 oom: fix potential data corruption when oom_reaper races with writer")
In-Reply-To: <7767bdf4-a034-ecb9-1ac8-4fa87f335818@c-s.fr>
References: <7767bdf4-a034-ecb9-1ac8-4fa87f335818@c-s.fr>
Date: Tue, 21 Aug 2018 16:40:15 +1000
Message-ID: <871sasmddc.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:
...
>
> And I bisected its disappearance with commit 99cd1302327a2 ("powerpc: 
> Deliver SEGV signal on pkey violation")

Whoa that's weird.

> Looking at those two commits, especially the one which makes it 
> dissapear, I'm quite sceptic. Any idea on what could be the cause and/or 
> how to investigate further ?

Are you sure it's not some corruption that just happens to be masked by
that commit? I can't see anything in that commit that could explain that
change in behaviour.

The only real change is if you're hitting DSISR_KEYFAULT isn't it?

What happens if you take 087003e9ef7c and apply the various hunks from
99cd1302327a2 gradually (or those that you can anyway)?

cheers
