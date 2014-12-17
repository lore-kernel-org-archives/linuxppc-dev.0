Return-Path: <agraf@suse.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E225D1A0549
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 23:40:50 +1100 (AEDT)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6352E1401DC
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 23:40:50 +1100 (AEDT)
Message-ID: <549179CE.7030100@suse.de>
Date: Wed, 17 Dec 2014 13:40:46 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: powernv: Return to cpu offline loop when finished
 in KVM guest
References: <20141203034840.GA612@iris.ozlabs.ibm.com>
In-Reply-To: <20141203034840.GA612@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03.12.14 04:48, Paul Mackerras wrote:
> When a secondary hardware thread has finished running a KVM guest, we
> currently put that thread into nap mode using a nap instruction in
> the KVM code.  This changes the code so that instead of doing a nap
> instruction directly, we instead cause the call to power7_nap() that
> put the thread into nap mode to return.  The reason for doing this is
> to avoid having the KVM code having to know what low-power mode to
> put the thread into.
> 
> In the case of a secondary thread used to run a KVM guest, the thread
> will be offline from the point of view of the host kernel, and the
> relevant power7_nap() call is the one in pnv_smp_cpu_disable().
> In this case we don't want to clear pending IPIs in the offline loop
> in that function, since that might cause us to miss the wakeup for
> the next time the thread needs to run a guest.  To tell whether or
> not to clear the interrupt, we use the SRR1 value returned from
> power7_nap(), and check if it indicates an external interrupt.  We
> arrange that the return from power7_nap() when we have finished running
> a guest returns 0, so pending interrupts don't get flushed in that
> case.
> 
> Note that it is important a secondary thread that has finished
> executing in the guest, or that didn't have a guest to run, should
> not return to power7_nap's caller while the kvm_hstate.hwthread_req
> flag in the PACA is non-zero, because the return from power7_nap
> will reenable the MMU, and the MMU might still be in guest context.
> In this situation we spin at low priority in real mode waiting for
> hwthread_req to become zero.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> I think this would be best going through the powerpc tree.  Alex,
> if you can give me an acked-by for this that would be appreciated.

Acked-by: Alexander Graf <agraf@suse.de>


Alex
