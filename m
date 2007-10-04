Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31199DDE1A
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 14:58:20 +1000 (EST)
Subject: Re: [PATCH] Fix performance monitor on machines with logical PVR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18180.27001.959843.273645@cargo.ozlabs.ibm.com>
References: <18180.27001.959843.273645@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 04 Oct 2007 14:58:15 +1000
Message-Id: <1191473895.22572.156.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This change works around this problem by taking out the PMU
> information from the cputable entries for the logical PVR values, and
> changing identify_cpu so that the second call to it won't overwrite
> the PMU information that was established by the first call (the one
> with the real PVR), but does update the other fields.

The description could be more precise. Something along the lines of: The
second call wlil not override the PMU information if the entry for the
logical PVR has a num_pmcs value of 0.

That way, we can -still- override them if future processor also
implement PMC backwater^H^H^Hrd compat mode via a different virtual PVR.

(This is what the code does, it's juse the description that is unclear).

Appart from that and pending testing...

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Oh, and another note: I dislike that:

+                       if (t->num_pmcs && !s->num_pmcs) {
+                               t->cpu_name = s->cpu_name;
+                               t->cpu_features = s->cpu_features;
+                               t->cpu_user_features =
s->cpu_user_features;
+                               t->icache_bsize = s->icache_bsize;
+                               t->dcache_bsize = s->dcache_bsize;
+                               t->cpu_setup = s->cpu_setup;
+                               t->cpu_restore = s->cpu_restore;
+                               t->platform = s->platform;
+                       } else
+                               *t = *s;

That means that we'll easily forget to update this bit of code when
we add things to cputable...

Thus, it would be best to put all the PMC related bits into a single
sub-structure, and rather than doing the above, save it, copy
everything, and eventually copy it back over (if it's a pointer it's
even easier).

Ben.
