Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 34943B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 04:51:00 +1100 (EST)
Message-ID: <4F4E6574.5050604@freescale.com>
Date: Wed, 29 Feb 2012 11:50:44 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Don't sync timebase when inside KVM
References: <1330481769-24390-1-git-send-email-agraf@suse.de>
In-Reply-To: <1330481769-24390-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/28/2012 08:16 PM, Alexander Graf wrote:
> When we know that we're running inside of a KVM guest, we don't have to
> worry about synchronizing timebases between different CPUs, since the
> host already took care of that.
> 
> This fixes CPU overcommit scenarios where vCPUs could hang forever trying
> to sync each other while not being scheduled.
> 
> Reported-by: Stuart Yoder <B08248@freescale.com>
> Signed-off-by: Alexander Graf <agraf@suse.de>

This should apply to any hypervisor, not just KVM.  On book3e, Power ISA
says timebase is read-only on virtualized implementations.  My
understanding is that book3s is paravirt-only (guest state is not
considered an implementation of the Power ISA), and it says "Writing the
Time Base is privileged, and can be done only in hypervisor state".

Which platforms are you seeing this on?  If it's on Freescale chips,
U-Boot should be doing the sync and Linux should never do it, even in
the absence of a hypervisor.

-Scott
