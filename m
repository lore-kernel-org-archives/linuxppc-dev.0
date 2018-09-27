Return-Path: <breno.debian@gmail.com>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LmcJ71pszF37q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 06:29:04 +1000 (AEST)
Received: by mail-qt1-f194.google.com with SMTP id z13-v6so4286608qts.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:29:04 -0700 (PDT)
Subject: Re: [RFC PATCH 01/11] powerpc/tm: Reclaim transaction on kernel entry
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, gromero@linux.vnet.ibm.com, mpe@ellerman.id.au,
 ldufour@linux.vnet.ibm.com
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-2-git-send-email-leitao@debian.org>
 <5013d84a59185cd7a1b941e6cc145a1fbfe52f48.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <1e00c875-436f-8cae-8d6e-032402486c80@debian.org>
Date: Thu, 27 Sep 2018 17:28:57 -0300
MIME-Version: 1.0
In-Reply-To: <5013d84a59185cd7a1b941e6cc145a1fbfe52f48.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mikey,

On 09/17/2018 10:31 PM, Michael Neuling wrote:
> On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
>> This patch creates a macro that will be invoked on all entrance to the
>> kernel, so, in kernel space the transaction will be completely reclaimed
>> and not suspended anymore.
> 
> There are still some calls to tm_reclaim_current() in process.c. Should these
> probably go now, right?

Yes, we shouldn't not call tm_reclaim_current() from anywhere else other than
TM_KERNEL_ENTRY anymore.

That said, I think we can still have some references for tm_reclaim_current()
in some specific checkpoints. Something as:

        if (WARN_ON(MSR_TM_SUSPENDED(mfmsr())))
                tm_reclaim_current(0);

I initially wrote something as BUG_ON(MSR_TM_SUSPENDED(mfmsr()) but
scripts/checkpatch.pl suggested me writing a WARN_ON() and create a recovery
pass, which seems fair.

Anyway, if you think it is not a good strategy, I can get rid of them at v2.

Thank you!
