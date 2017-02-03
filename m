Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFFRn1HSmzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 22:45:40 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id e4so1450394pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Feb 2017 03:45:40 -0800 (PST)
Date: Fri, 3 Feb 2017 21:45:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 07/10] powerpc: add NMI IPI infrastructure
Message-ID: <20170203214524.3ad3729a@roar.ozlabs.ibm.com>
In-Reply-To: <20161219183011.28310-8-npiggin@gmail.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
 <20161219183011.28310-8-npiggin@gmail.com>
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

On Tue, 20 Dec 2016 04:30:08 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> +static void do_smp_send_nmi_ipi(int cpu)
> +{
> +	if (cpu >= 0) {
> +		do_message_pass(cpu, PPC_MSG_NMI_IPI);
> +	} else {
> +		unsigned int c;
> +
> +		for_each_online_cpu(c) {
> +			if (c == raw_smp_processor_id())
> +				continue;
> +			do_message_pass(cpu, PPC_MSG_NMI_IPI);

Okay this has a bug in the fallback path. Needs the following
incremental patch. sysrq+x works okay with this (tested in mambo),
and also recovers with "x" okay.

Thanks,
Nick

---
 arch/powerpc/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 81256522985d..a9f8c70d1033 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -420,12 +420,12 @@ static void do_smp_send_nmi_ipi(int cpu)
 	if (cpu >= 0) {
 		do_message_pass(cpu, PPC_MSG_NMI_IPI);
 	} else {
-		unsigned int c;
+		int c;
 
 		for_each_online_cpu(c) {
 			if (c == raw_smp_processor_id())
 				continue;
-			do_message_pass(cpu, PPC_MSG_NMI_IPI);
+			do_message_pass(c, PPC_MSG_NMI_IPI);
 		}
 	}
 }
-- 
2.11.0
