Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy1cN47NdzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 18:00:36 +1000 (AEST)
Subject: Re: [PATCH] KVM: PPC: Book3S PR: Do not fail emulation with
 mtspr/mfspr for unknown SPRs
To: Paul Mackerras <paulus@ozlabs.org>
References: <1491218595-10943-1-git-send-email-thuth@redhat.com>
 <20170404062545.2ajhqhhyeiime5mp@oak.ozlabs.ibm.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Laurent Vivier <lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1267dbd0-0507-dc01-0b1c-96c1b2e80429@redhat.com>
Date: Tue, 4 Apr 2017 10:00:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170404062545.2ajhqhhyeiime5mp@oak.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04.04.2017 08:25, Paul Mackerras wrote:
> On Mon, Apr 03, 2017 at 01:23:15PM +0200, Thomas Huth wrote:
>> According to the PowerISA 2.07, mtspr and mfspr should not generate
>> an illegal instruction exception when being used with an undefined SPR,
>> but rather treat the instruction as a NOP, inject a privilege exception
>> or an emulation assistance exception - depending on the SPR number.
> 
> The emulation assist interrupt is a hypervisor interrupt, so the guest
> would not be expecting to receive it.  On a real machine, the
> hypervisor would synthesize an illegal instruction type program
> interrupt as described in the last programming note in section 6.5.9
> of Book III of Power ISA v2.07B.  Since we are the hypervisor here, we
> should synthesize a program interrupt rather than an emulation assist
> interrupt.

Ah, right, we're doing this in other spots, too, so a PROGILL is indeed
more consistent here. I'll send a v2 ...

 Thomas
