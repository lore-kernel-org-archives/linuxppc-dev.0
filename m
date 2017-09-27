Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y26Fz6dllzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 15:44:23 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i23so5962044pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 22:44:23 -0700 (PDT)
Date: Wed, 27 Sep 2017 15:44:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Meng YK Li <shlimeng@cn.ibm.com>
Subject: Re: [PATCH] powerpc: Fix action argument for cpufeatures-based TLB
 flush
Message-ID: <20170927154406.2f94b799@roar.ozlabs.ibm.com>
In-Reply-To: <1506488151-9825-1-git-send-email-jk@ozlabs.org>
References: <1506488151-9825-1-git-send-email-jk@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Sep 2017 12:55:51 +0800
Jeremy Kerr <jk@ozlabs.org> wrote:

> Commit 41d0c2ecde introduced calls to __flush_tlb_power[89] from the
> cpufeatures code, specifying the number of sets to flush.
> 
> However, these functions take an action argument, not a number of sets.
> This means we hit the BUG() in __flush_tlb_{206,300} when using
> cpufeatures-style configuration.
> 
> This change passes TLB_INVAL_SCOPE_GLOBAL instead.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> CC: Nicholas Piggin <npiggin@gmail.com>

Thanks for this, yes it's obviously correct. Sigh, I thought I'd posted
the the same thing, but I didn't actually send it to linuxppc-dev. I had
another one to use early_radix_enabled() rather than radix_enabled()
in the series too. I'll send it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
