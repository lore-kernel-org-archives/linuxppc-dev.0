Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDRjH0YmYzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 12:25:23 +1100 (AEDT)
Date: Sat, 14 Oct 2017 12:24:48 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: POWER9 more doorbell fixes
Message-ID: <20171014012448.GD26120@fergus.ozlabs.ibm.com>
References: <20171010101828.5950-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171010101828.5950-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 10, 2017 at 08:18:28PM +1000, Nicholas Piggin wrote:
> - Add another case where msgsync is required.
> - Required barrier sequence for global doorbells is msgsync ; lwsync
> - POWER9 DD1 has a different barrier sequence that we don't implement,
>   so remove
> 
> When msgsnd is used for IPIs to other cores, msgsync must be executed by
> the target to order stores performed on the source before its msgsnd
> (provided the source executes the appropriate sync).
> 
> Fixes: 1704a81ccebc ("KVM: PPC: Book3S HV: Use msgsnd for IPIs to other cores on POWER9")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Thanks, applied to my kvm-ppc-fixes branch (minus the comment about DD1).

Paul.
