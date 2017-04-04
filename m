Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxzW46XcZzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 16:25:52 +1000 (AEST)
Date: Tue, 4 Apr 2017 16:25:45 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] KVM: PPC: Book3S PR: Do not fail emulation with
 mtspr/mfspr for unknown SPRs
Message-ID: <20170404062545.2ajhqhhyeiime5mp@oak.ozlabs.ibm.com>
References: <1491218595-10943-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491218595-10943-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 03, 2017 at 01:23:15PM +0200, Thomas Huth wrote:
> According to the PowerISA 2.07, mtspr and mfspr should not generate
> an illegal instruction exception when being used with an undefined SPR,
> but rather treat the instruction as a NOP, inject a privilege exception
> or an emulation assistance exception - depending on the SPR number.

The emulation assist interrupt is a hypervisor interrupt, so the guest
would not be expecting to receive it.  On a real machine, the
hypervisor would synthesize an illegal instruction type program
interrupt as described in the last programming note in section 6.5.9
of Book III of Power ISA v2.07B.  Since we are the hypervisor here, we
should synthesize a program interrupt rather than an emulation assist
interrupt.

> Also turn the printk here into a ratelimited print statement, so that
> the guest can not flood the dmesg log of the host by issueing lots of
> illegal mtspr/mfspr instruction here.

Good idea.

Paul.
