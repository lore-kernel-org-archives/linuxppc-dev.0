Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2505CB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 21:03:08 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13658DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 21:03:08 +1000 (EST)
Subject: Re: [PATCH] powerpc/perfctr: Check oprofile_cpu_type for NULL
	before using it
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1249531356.18245.73.camel@pasglop>
References: <1249531356.18245.73.camel@pasglop>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 21:03:06 +1000
Message-Id: <1249556586.4800.79.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-06 at 14:02 +1000, Benjamin Herrenschmidt wrote:
> If the current CPU doesn't support performance counters,
> cur_cpu_spec->oprofile_cpu_type can be NULL. The current
> perfctr modules don't test for that case and would thus
> crash.

> +	if (!cur_cpu_spec->oprofile_cpu_type ||
..
> +	if (!cur_cpu_spec->oprofile_cpu_type ||
..
> +	if (!cur_cpu_spec->oprofile_cpu_type ||
..
> +	if (!cur_cpu_spec->oprofile_cpu_type ||
..
> +	if (!cur_cpu_spec->oprofile_cpu_type ||
..
> +	if (!cur_cpu_spec->oprofile_cpu_type ||
..
> +	if (!cur_cpu_spec->oprofile_cpu_type ||

Typing it seven times didn't make you think "how about a helper?" :)

Perhaps:

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cput
index 80f315e..956cbc3 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -123,6 +123,11 @@ struct cpu_spec {
 
 extern struct cpu_spec         *cur_cpu_spec;
 
+static inline int oprofile_cpu_type_matches(const char *s)
+{
+       return s && (strcmp(cur_cpu_spec->oprofile_cpu_type, s) == 0);
+}
+
 extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
 
 extern struct cpu_spec *identify_cpu(unsigned long offset, unsigned int pvr);


And then callsites become:

 static int init_mpc7450_pmu(void)
 {
        if (!oprofile_cpu_type_matches("ppc/7450"))
                return -ENODEV;


cheers
