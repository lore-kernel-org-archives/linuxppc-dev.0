Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t30F13999zDvhS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 15:15:33 +1100 (AEDT)
Date: Tue, 25 Oct 2016 15:15:30 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, shreyas@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com
Subject: Re: [RFC PATCH] powerpc/powernv: recheck lock bit in
 core_idle_lock_held after lwarx
Message-ID: <20161025041530.GA17852@fergus.ozlabs.ibm.com>
References: <1477365874.10026.7.camel@TP420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477365874.10026.7.camel@TP420>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 25, 2016 at 11:24:34AM +0800, Li Zhong wrote:
> The core_idle_lock_held loops when the lock bit is held by others.
> However, it is possible that after the lock bit is cleared, some one
> else sees it first and sets the lock bit. And lwarx loads a value with
> lock bit set, and the lock bit may be cleared in the following stwcx.
> It is possible the first one is still executing in the critical section.
> 
> This patch rechecks the lock bit after lwarx, and go back to loop if it
> is set.

You're quite correct, in fact I posted almost exactly the same patch a
few days ago...  See http://patchwork.ozlabs.org/patch/684963/.

Thanks,
Paul.
