Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w35Vs5Z8PzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 00:13:25 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 34so2720348pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:13:25 -0700 (PDT)
Date: Thu, 13 Apr 2017 00:12:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s: catch external interrupts going to host in
 POWER9
Message-ID: <20170413001252.250018c4@roar.ozlabs.ibm.com>
In-Reply-To: <1492004742.7236.58.camel@kernel.crashing.org>
References: <20170412131123.17445-1-npiggin@gmail.com>
 <1492004742.7236.58.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 Apr 2017 23:45:42 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2017-04-12 at 23:11 +1000, Nicholas Piggin wrote:
> > After setting LPES0 in the host on POWER9, the host external interrupt
> > handler no longer works correctly, because it's set to HV mode (HSRR)
> > for POWER7/8 with LPES0 clear. We don't expect to get any EE in the host
> > with XIVE, but it seems preferable to catch unexpected interrupts in case
> > there are bugs or unexpected behaviour.
> >   
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> > ---  
> 
> No. Let's just get LPES back to P8 value in the host, we don't care as
> we don't get those EEs on normal systems. Then make sure KVM properly
> sets it the way we want when setting up the guest LPCR (which it should
> be doing with my patches).
> Much simpler patch...


Yeah sure that sounds good. How's this then?

---
 arch/powerpc/kernel/exceptions-64s.S | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 857bf7c5b946..c78165e5fb77 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -735,8 +735,20 @@ EXC_VIRT_END(hardware_interrupt, 0x4500, 0x100)
 
 TRAMP_KVM(PACA_EXGEN, 0x500)
 TRAMP_KVM_HV(PACA_EXGEN, 0x500)
-EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
 
+EXC_COMMON_BEGIN(hardware_interrupt_common)
+BEGIN_FTR_SECTION
+	/*
+	 * The POWER9 XIVE interrupt controller should be configured to send
+	 * all interrupts to the host as HVI, even with the OPAL XICS
+	 * emulation, so HVMODE should never see a 0x500 interrupt. However we
+	 * catch it in case of a bug.
+	 */
+	b	unknown_host_ee_common
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_300)
+	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt_common, do_IRQ)
+
+EXC_COMMON_ASYNC(unknown_host_ee_common, 0x500, unknown_exception)
 
 EXC_REAL(alignment, 0x600, 0x100)
 EXC_VIRT(alignment, 0x4600, 0x100, 0x600)
-- 
2.11.0
