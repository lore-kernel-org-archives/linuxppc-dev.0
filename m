Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7BC93bHJzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 18:58:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [RESEND PATCH v3 2/2] powernv: Fix MCE handler to avoid trashing
 CR0/CR1 registers.
In-Reply-To: <147064570604.6908.10782297574634779096.stgit@jupiter.in.ibm.com>
References: <147064569946.6908.3260124681746222838.stgit@jupiter.in.ibm.com>
 <147064570604.6908.10782297574634779096.stgit@jupiter.in.ibm.com>
Date: Mon, 08 Aug 2016 18:58:12 +1000
Message-ID: <87shufskm3.fsf@concordia.ellerman.id.au>
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

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> The current implementation of MCE early handling modifies CR0/1 registers
> without saving its old values. Fix this by moving early check for
> powersaving mode to machine_check_handle_early().
>
> The power architecture 2.06 or later allows the possibility of getting
> machine check while in nap/sleep/winkle. The last bit of HSPRG0 is set
> to 1, if thread is woken up from winkle. Hence, clear the last bit of
> HSPRG0 (r13) before MCE handler starts using it as paca pointer.
>
> Also, the current code always puts the thread into nap state irrespective
> of whatever idle state it woke up from. Fix that by looking at
> paca->thread_idle_state and put the thread back into same state where it
> came from.
>
> Cc: stable@vger.kernel.org

The information I need is "which commit introduced the bug".

Given that I can work out which stable releases we should backport the
patch to.

cheers
