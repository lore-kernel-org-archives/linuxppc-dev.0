Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFdWZ04jYzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Feb 2017 13:50:18 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 75so3448859pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Feb 2017 18:50:17 -0800 (PST)
Date: Sat, 4 Feb 2017 12:49:59 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 07/10] powerpc: add NMI IPI infrastructure
Message-ID: <20170204124959.76d786f2@roar.ozlabs.ibm.com>
In-Reply-To: <20170203214524.3ad3729a@roar.ozlabs.ibm.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
 <20161219183011.28310-8-npiggin@gmail.com>
 <20170203214524.3ad3729a@roar.ozlabs.ibm.com>
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

On Fri, 3 Feb 2017 21:45:24 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Tue, 20 Dec 2016 04:30:08 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > +static void do_smp_send_nmi_ipi(int cpu)
> > +{
> > +	if (cpu >= 0) {
> > +		do_message_pass(cpu, PPC_MSG_NMI_IPI);
> > +	} else {
> > +		unsigned int c;
> > +
> > +		for_each_online_cpu(c) {
> > +			if (c == raw_smp_processor_id())
> > +				continue;
> > +			do_message_pass(cpu, PPC_MSG_NMI_IPI);  
> 
> Okay this has a bug in the fallback path. Needs the following
> incremental patch. sysrq+x works okay with this (tested in mambo),
> and also recovers with "x" okay.

Also requires removal of get_online_cpus/put_online_cpus.

---
 arch/powerpc/kernel/smp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 81256522985d..e1a429251a7d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -448,8 +448,6 @@ static int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
 	if (unlikely(!smp_ops))
 		return 0;
 
-	get_online_cpus();
-
 	/* Take the nmi_ipi_busy count/lock with interrupts hard disabled */
 	nmi_ipi_lock_start(&flags);
 	while (nmi_ipi_busy_count) {
@@ -491,8 +489,6 @@ static int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
 	nmi_ipi_busy_count--;
 	nmi_ipi_unlock_end(&flags);
 
-	put_online_cpus();
-
 	return ret;
 }
 #endif /* CONFIG_NMI_IPI */
-- 
2.11.0
