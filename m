Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 162A61A0557
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 09:29:43 +1100 (AEDT)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5CA1A1400E9
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2014 09:29:42 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 15:29:40 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id F2E35C40007
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2014 15:18:20 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBAMSbf618677818
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2014 15:28:37 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBAMTZ26005647
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2014 15:29:36 -0700
Date: Wed, 10 Dec 2014 14:29:13 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] perf/powerpc/hv-24x7: Use per-cpu page buffer
Message-ID: <20141210222912.GA30869@us.ibm.com>
References: <20141210070637.GA27377@us.ibm.com>
 <1418202549.9279.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418202549.9279.0.camel@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Jiri Olsa <jolsa@redhat.com>, dev@codyps.com,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
| On Tue, 2014-12-09 at 23:06 -0800, Sukadev Bhattiprolu wrote:
| > From 470c16c8955672103a9529c78dffbb239e9e27b8 Mon Sep 17 00:00:00 2001
| > From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| > Date: Tue, 9 Dec 2014 22:17:46 -0500
| > Subject: [PATCH 1/2] perf/poweprc/hv-24x7: Use per-cpu page buffer
| > 
| > diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
| > index dba3408..18e1f49 100644
| > --- a/arch/powerpc/perf/hv-24x7.c
| > +++ b/arch/powerpc/perf/hv-24x7.c
| > @@ -217,11 +217,14 @@ static bool is_physical_domain(int domain)
| >  		domain == HV_24X7_PERF_DOMAIN_PHYSICAL_CORE;
| >  }
| >  
| > +DEFINE_PER_CPU(char, hv_24x7_reqb[4096]);
| > +DEFINE_PER_CPU(char, hv_24x7_resb[4096]);
| 
| Do we need it to be 4K aligned also? I would guess so.

Yes, fixed in the patch below.
| 
| Rather than declaring these as char arrays and then casting below, can you pull
| the struct definitions up and then declare the per cpu variables with the
| proper type.

Well, the structures, used for communication with HV, have variable length
arrays, like:

	struct hv_24x7_request_buffer {
		...
		struct hv_24x7_request requests[];
	};

i.e the buffer needs to be larger than reported by sizeof(). So we
allocate a large buffer and cast it. Not sure if there is a trick to
get DEFINE_PER_CPU() to do that. We could add code to allocate pages
per cpu during init, but that would mean more code, error handling etc.

| 
| 
| >  static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
| >  					 u16 lpar, u64 *res,
| >  					 bool success_expected)
| >  {
| > -	unsigned long ret = -ENOMEM;
| > +	unsigned long ret;
| >  
| >  	/*
| >  	 * request_buffer and result_buffer are not required to be 4k aligned,
| > @@ -243,13 +246,11 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
| >  	BUILD_BUG_ON(sizeof(*request_buffer) > 4096);
| >  	BUILD_BUG_ON(sizeof(*result_buffer) > 4096);
| >  
| > -	request_buffer = kmem_cache_zalloc(hv_page_cache, GFP_USER);
| > -	if (!request_buffer)
| > -		goto out;
| > +	request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
| > +	result_buffer = (void *)get_cpu_var(hv_24x7_resb);
| >  
| > -	result_buffer = kmem_cache_zalloc(hv_page_cache, GFP_USER);
| > -	if (!result_buffer)
| > -		goto out_free_request_buffer;
| > +	memset(request_buffer, 0, 4096);
| > +	memset(result_buffer, 0, 4096);
| 
| Do we have to memset them? That's not going to speed things up.

I agree about the speed, specially since we have a larger buffer. But we
are reusing the buffer for independent events and some fields need to be 0
(hence the zalloc in the current code).

---


>From 545ad0771ef8f22085ed8bb486f0a81b3afc5757 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 9 Dec 2014 22:17:46 -0500
Subject: [PATCH 1/2] powerpc/perf/hv-24x7: Use per-cpu page buffer

The 24x7 counters are continuously running and not updated on an interrupt.
So we record the event counts when stopping the event or deleting it.

But to "read" a single counter in 24x7, we allocate a page and pass it
into the hypervisor (The HV returns the page full of counters from which
we extract the specific counter for this event).

We allocate a page using GFP_USER and when deleting the event, we end up
with the following warning because we are blocking in interrupt context.

	[  698.641709] BUG: scheduling while atomic: swapper/0/0/0x10010000

We could use GFP_ATOMIC but that could result in failures. Pre-allocate
a buffer so we don't have to allocate in interrupt context. Further as
Michael Ellerman suggested, use Per-CPU buffer so we only need to allocate
once per CPU.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

Changelog[v2]:
	[Michael Ellerman] Ensure buffer is aligned to 4K.


diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index dba3408..d073e06 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -217,11 +217,14 @@ static bool is_physical_domain(int domain)
 		domain == HV_24X7_PERF_DOMAIN_PHYSICAL_CORE;
 }
 
+DEFINE_PER_CPU(char, hv_24x7_reqb[4096]) __aligned(4096);
+DEFINE_PER_CPU(char, hv_24x7_resb[4096]) __aligned(4096);
+
 static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 					 u16 lpar, u64 *res,
 					 bool success_expected)
 {
-	unsigned long ret = -ENOMEM;
+	unsigned long ret;
 
 	/*
 	 * request_buffer and result_buffer are not required to be 4k aligned,
@@ -243,13 +246,11 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 	BUILD_BUG_ON(sizeof(*request_buffer) > 4096);
 	BUILD_BUG_ON(sizeof(*result_buffer) > 4096);
 
-	request_buffer = kmem_cache_zalloc(hv_page_cache, GFP_USER);
-	if (!request_buffer)
-		goto out;
+	request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
+	result_buffer = (void *)get_cpu_var(hv_24x7_resb);
 
-	result_buffer = kmem_cache_zalloc(hv_page_cache, GFP_USER);
-	if (!result_buffer)
-		goto out_free_request_buffer;
+	memset(request_buffer, 0, 4096);
+	memset(result_buffer, 0, 4096);
 
 	*request_buffer = (struct reqb) {
 		.buf = {
@@ -278,15 +279,11 @@ static unsigned long single_24x7_request(u8 domain, u32 offset, u16 ix,
 				domain, offset, ix, lpar, ret, ret,
 				result_buffer->buf.detailed_rc,
 				result_buffer->buf.failing_request_ix);
-		goto out_free_result_buffer;
+		goto out;
 	}
 
 	*res = be64_to_cpu(result_buffer->result);
 
-out_free_result_buffer:
-	kfree(result_buffer);
-out_free_request_buffer:
-	kfree(request_buffer);
 out:
 	return ret;
 }
-- 
1.8.3.1
