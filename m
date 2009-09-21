Return-Path: <markus.t.metzger@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by ozlabs.org (Postfix) with ESMTP id 27773B7B6F
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 17:22:57 +1000 (EST)
From: "Metzger, Markus T" <markus.t.metzger@intel.com>
To: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>, Peter
	Zijlstra <a.p.zijlstra@chello.nl>, "davem@davemloft.net"
	<davem@davemloft.net>
Date: Mon, 21 Sep 2009 08:12:12 +0100
Subject: RE: [PATCH] perf_counter/powerpc: Fix compilation after
	perf_counter_overflow change
Message-ID: <928CFBE8E7CB0040959E56B4EA41A77EC69BA5E0@irsmsx504.ger.corp.intel.com>
References: <19127.8400.376239.586120@drongo.ozlabs.ibm.com>
In-Reply-To: <19127.8400.376239.586120@drongo.ozlabs.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>-----Original Message-----
>From: Paul Mackerras [mailto:paulus@samba.org]
>Sent: Monday, September 21, 2009 8:45 AM


>Markus, please take care in future to mention it in the changelog if
>your patches touch definitions used by other architectures.  If you
>could go so far as to use grep a bit more and fix up other
>architectures' callsites for the things you're changing, that would be
>very much appreciated.  Thanks.

I'm sorry I missed that.

There's one more place in arch/sparc/.
The below patch should fix it, but I have no means to test it.

Index: b/arch/sparc/kernel/perf_counter.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/sparc/kernel/perf_counter.c
+++ b/arch/sparc/kernel/perf_counter.c
@@ -493,7 +493,6 @@ static int __kprobes perf_counter_nmi_ha
=20
 	regs =3D args->regs;
=20
-	data.regs =3D regs;
 	data.addr =3D 0;
=20
 	cpuc =3D &__get_cpu_var(cpu_hw_counters);
@@ -513,7 +512,7 @@ static int __kprobes perf_counter_nmi_ha
 		if (!sparc_perf_counter_set_period(counter, hwc, idx))
 			continue;
=20
-		if (perf_counter_overflow(counter, 1, &data))
+		if (perf_counter_overflow(counter, 1, &data, regs))
 			sparc_pmu_disable_counter(hwc, idx);
 	}


thanks and regards,
markus.

---------------------------------------------------------------------
Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen Germany
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Douglas Lusk, Peter Gleissner, Hannes Schwaderer
Registergericht: Muenchen HRB 47456 Ust.-IdNr.
VAT Registration No.: DE129385895
Citibank Frankfurt (BLZ 502 109 00) 600119052

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
