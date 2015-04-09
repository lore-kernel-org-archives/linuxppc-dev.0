Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0119.outbound.protection.outlook.com [157.56.110.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C2631A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 09:53:47 +1000 (AEST)
Message-ID: <1428623611.22867.561.camel@freescale.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
From: Scott Wood <scottwood@freescale.com>
To: Purcareata Bogdan <b43198@freescale.com>
Date: Thu, 9 Apr 2015 18:53:31 -0500
In-Reply-To: <55262DD3.2050707@freescale.com>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>
 <54E74A8C.30802@linutronix.de> <1424734051.4698.17.camel@freescale.com>
 <54EF196E.4090805@redhat.com> <54EF2025.80404@linutronix.de>
 <1424999159.4698.78.camel@freescale.com> <55158E6D.40304@freescale.com>
 <1428016310.22867.289.camel@freescale.com>
 <551E4A41.1080705@freescale.com> <1428096375.22867.369.camel@freescale.com>
 <55262DD3.2050707@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-rt-users@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 mihai.caraman@freescale.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-09 at 10:44 +0300, Purcareata Bogdan wrote:
> So at this point I was getting kinda frustrated so I decided to measure
> the time spend in kvm_mpic_write and kvm_mpic_read. I assumed these were
> the main entry points in the in-kernel MPIC and were basically executed
> while holding the spinlock. The scenario was the same - 24 VCPUs guest,
> with 24 virtio+vhost interfaces, only this time I ran 24 ping flood
> threads to another board instead of netperf. I assumed this would impose
> a heavier stress.
> 
> The latencies look pretty ok, around 1-2 us on average, with the max
> shown below:
> 
> .kvm_mpic_read	14.560
> .kvm_mpic_write	12.608
> 
> Those are also microseconds. This was run for about 15 mins.

What about other entry points such as kvm_set_msi() and
kvmppc_mpic_set_epr()?

-Scott
