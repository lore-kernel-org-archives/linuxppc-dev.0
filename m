Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34C711A1FB8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 19:29:42 +1000 (AEST)
In-Reply-To: <1440415228-8006-4-git-send-email-haokexin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [v2,3/6] powerpc: kill mfvtb()
Message-Id: <20150907092942.1EF38140281@ozlabs.org>
Date: Mon,  7 Sep 2015 19:29:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-24-08 at 11:20:25 UTC, Kevin Hao wrote:
> This function is only used by get_vtb(). They are almost the same
> except the reading from the real register. Move the mfspr() to
> get_vtb() and kill the function mfvtb(). With this, we can eliminate
> the use of cpu_has_feature() in very core header file like reg.h.
> This is a preparation for the use of jump label for cpu_has_feature().

I don't mind this change. But can you elaborate a bit on the issue with using
cpu_has_feature() in reg.h? Just so I can understand the problem.

I assume you ended up in a big mess of includes when you tried to include
jump_label.h from reg.h?

cheers
