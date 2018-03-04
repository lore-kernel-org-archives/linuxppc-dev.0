Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvdnF0dcMzDrTf
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 10:01:05 +1100 (AEDT)
Date: Mon, 5 Mar 2018 09:49:27 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix guest time accounting with
 VIRT_CPU_ACCOUNTING_GEN
Message-ID: <20180304224927.GB14569@fergus.ozlabs.ibm.com>
References: <20180302105156.19506-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180302105156.19506-1-lvivier@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 02, 2018 at 11:51:56AM +0100, Laurent Vivier wrote:
> Since commit 8b24e69fc47e ("KVM: PPC: Book3S HV: Close race with testing
> for signals on guest entry"), if CONFIG_VIRT_CPU_ACCOUNTING_GEN is set, the
> guest time is not accounted to guest time and user time, but instead to
> system time.
> 
> This is because guest_enter()/guest_exit() are called while interrupts
> are disabled and the tick counter cannot be updated between them.
> 
> To fix that, move guest_exit() after local_irq_enable(), and as
> guest_enter() is called with IRQ disabled, calls guest_enter_irqoff()
> instead.
> 
> Fixes: 8b24e69fc47e
> ("KVM: PPC: Book3S HV: Close race with testing for signals on guest entry")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Thanks, applied to my kvm-ppc-fixes branch.

Paul.
