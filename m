Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10A421A2AE0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 14:32:24 +1100 (AEDT)
Date: Mon, 23 Mar 2015 14:32:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH] For machine check occurring while in guest, KVM
 layer tries recovery
Message-ID: <20150323033221.GC8257@drongo>
References: <20150317092707.16806.62378.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150317092707.16806.62378.stgit@mars>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, David Gibson <dgibson@redhat.com>,
 Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 17, 2015 at 02:57:48PM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> and deliver MCE to guest if recovery is failed. For recovered errors
> we just go back to normal functioning of guest. But there are cases
> where we may hit MCE in guest with MSR(RI=0), which means MCE interrupt is
> not recoverable and guest can not function normally it should go down to
> panic path. The current implementation does not have check for MSR(RI=0)
> which can cause guest to crash with Bad kernel stack pointer instead of
> machine check oops message.
> 
> [26281.490060] Bad kernel stack pointer 3fff9ccce5b0 at c00000000000490c
> [26281.490434] Oops: Bad kernel stack pointer, sig: 6 [#1]
> [26281.490472] SMP NR_CPUS=2048 NUMA pSeries
> 
> This patch fixes this issue by checking MSR(RI=0) in KVM layer and forwarding
> unrecoverable interrupt to guest which then panics with proper machine check
> Oops message.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

The patch itself is fine, but you need a proper headline (something
like "KVM: PPC: Book3S HV: Inform guest of unrecoverable machine
checks" perhaps) as the subject of the email, and you need to post the
patch to both the kvm@vger.kernel.org list and the
kvm-ppc@vger.kernel.org list.  Also, the English in the patch
description could use some improvement.

Acked-by: Paul Mackerras <paulus@samba.org>
