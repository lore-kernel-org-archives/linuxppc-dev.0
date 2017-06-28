Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyMdL4FsHzDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 22:32:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com
Subject: Re: [PATCH] powernv:idle: Clear r12 on wakeup from stop lite
In-Reply-To: <20170628143646.5e92bcb5@roar.ozlabs.ibm.com>
References: <1498612609-13677-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20170628143646.5e92bcb5@roar.ozlabs.ibm.com>
Date: Wed, 28 Jun 2017 22:32:53 +1000
Message-ID: <87vangb8cq.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Wed, 28 Jun 2017 06:46:49 +0530
> Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:
>
>> pnv_wakeup_noloss expects R12 to contain SRR1 value to determine if
>> the wakeup reason is an HMI in CHECK_HMI_INTERRUPT.
>> 
>> When we wakeup with ESL=0, SRR1 will not contain the wakeup reason, so
>> there is no point setting R12 to SRR1.
>> 
>> However, we don't set R12 at all and R12 contains garbage, and still
>> being used to check HMI assuming that it had SRR1. causing the
>> OPAL msglog to be filled with the following print:
>> 	HMI: Received HMI interrupt: HMER = 0x0040000000000000
>> 
>> This patch clears R12 after waking up from stop with ESL=EC=0, so that
>> we don't accidentally enter the HMI handler in pnv_wakeup_noloss if
>> the R12[42:45] corresponds to HMI as wakeup reason.
>> 
>> Bug existed prior to "commit 9d29250136f6 ("powerpc/64s/idle: Avoid SRR
>> usage in idle sleep/wake paths")  but was never hit in practice
>> 
>> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
>> Fixes: 9d29250136f6 ("powerpc/64s/idle: Avoid SRR usage in idle
>> sleep/wake paths")
>
> Thanks guys, appreciate you finding and fixing my bug :)
>
> I think this looks like the best fix. Really minor nitpick but you
> could adjust the line widths on the comment slightly (mpe might do
> that when merging).

You know me too well :}

cheers
