Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B74606A32C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bUmwaVe0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV93K31TZz2xSl;
	Thu, 19 Nov 2026 05:23:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795026237;
	cv=none; b=gUv1WdyDOeJN4jjNlpyDMf9yyRAkfgSYz1dXXMhQzY+zwABHUfa25spDkOJBgtYAjern8IWDFuZgHGP2TFwCmPeJbl9tb0BV2r3teSuA9ybkpnWhM/GScqCZWvfMdZsMb5PMw2Azh/RLg0ligYocEwgSgAACRqIuDQ7pZMJq6GCygPJj/Vh3tgWYacqCYTjnUhNcUFQcb/NXN9v56hwx8aLIBGC4aW3W51VxSA9yMm7SsTIi/s80ZGomOzWsRP9XnIpaHBuZd66B+Q4FyyslcQtnpTvop3OyOJMClrsYTbXxW8YYjwILKNKnUv+jfv6AnvJRo2VQAVH3rfzl3oWSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795026237; c=relaxed/relaxed;
	bh=w7e84pTx1hFND/SqJPYWM+V16X6qXv0q0f3OXujMfRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKAMk95E6ciSKjh5uOfuSCzFS+NbbaWjIGUD3gcyUScufNce+AJeod9DSj6XtPqJfNptL/PcGT+cC0WOTexGoDDNnFdihDc/uRQ1WOJYalbOd5TUgt8G00rPqKGaF0h6Boh+JRFxiXsSr77cjE32WlBYnUTJafY95aGh79c0K7+6Y5iLzfI1y8PY5aoo5rJxyDW+aSEvDvdBuGlRWeaFZgYyKXXM06rFUIQSox7Km9QHnFNea1t3C5HANPiSuKjLNOddPLuwyBNJDrrfGUB0f6soFBpzRi734o+hTvukMknAACXfUafbziHGSQFxLUeJVHFOctzcF1J07Go6zkMImQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bUmwaVe0; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bUmwaVe0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV93J1gltz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 05:23:55 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHQD2O1730327;
	Wed, 18 Nov 2026 18:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w7e84p
	Tx1hFND/SqJPYWM+V16X6qXv0q0f3OXujMfRQ=; b=bUmwaVe0vc+1u8ldD3hI2a
	HjsSKqPibLmbLZ6QQYXLwzJLV2tci+Fd/Z7F6HDsapiyvWoZ6Y9SMszwzszAt0T+
	S8MrCThxOzb1M7aSoJuLkFqP/pWgqU4820kPY4aVYZKf6yjuaUeBIoZ/JA5ogsaS
	0rMOhD6Vbn+V3iFU4fY0JU2qWyT8pJQsBa8sskjxlcfREg6lCqv4VRhxKGlanRop
	6Oz7lCYmL3nqjUJlyC6H6YGyjTTy5l3UAynKFLASq9y9KQzCPavLWOLLiUgZe5bY
	xtOEBaPQRK+FKyVhLaXHdqXpCvqoDsCOA5erinypf1fq8TzRxKdfhfX1Kdam1BEg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vkw3v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 18:23:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHJsLs2384122;
	Wed, 18 Nov 2026 18:23:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb59ad2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 18:23:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIINgGB51708356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 18:23:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DE1B20049;
	Wed, 18 Nov 2026 18:23:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ECE820040;
	Wed, 18 Nov 2026 18:23:39 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Nov 2026 18:23:39 +0000 (GMT)
Date: Thu, 19 Nov 2026 00:02:08 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Vincent Donnefort <vdonnefort@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <20261118234433.5ff52f67-db-amachhiw@linux.ibm.com>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	Vincent Donnefort <vdonnefort@google.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-ppc@vger.kernel.org, stable@vger.kernel.org
References: <20261023145459.47516-1-amachhiw@linux.ibm.com>
 <20261117162842.5cb22a24@gandalf.local.home>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261117162842.5cb22a24@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: w8oT8vA_A5CLf9XQ-aSFOYIasGSAczcu
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afded33 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Mm8Sogoet2vpDDTUGKUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FSyKhUNZuQ6tU18BMC3aNlSbju3q4FZL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3MSBTYWx0ZWRfX9kx9zYxG0MdU
 Xi8yFpec4HQO+pByXSpeRMKs16iU+nXxryJ3Uj4nko1Lug//s3rxtgii680Os0SVItyR109TFgo
 MlbuaUty3DfuVtpJukmdLdrA6ALFvELcsl8pVRr5cXzBI/HbHnShJ6on/VOZ6ytwUAw++dQDMez
 Co7vCtHx2pv1y17J8iKn8OZaCehnipDCBPRmehCcYivtoIt+8vZVuzsXwm5yZE8l3b3DJyGIUDd
 nPpFSVvLO4zzx9ggxqkwXLO0eTwAJHMSxWWGmCZ2f6AXl+lgWs3H6Lz7tVylUpKnn0Kg9xXHojg
 t2xADslZ3gxyUtFwDw+068ZTG+fCRi6JcwsyZUsPk19IWP5F3NlxYazvnBqJG/myWMsp0YgL/pA
 BWEkWUP2wNBIN4xTM3rtbwTv6qo8UjLX97CxsMJwsJFfR9s3z/0pWYz0iDKWIKSdXP4aP8pSSjg
 3zoqo39RpcXe/xlsT2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3MSBTYWx0ZWRfXybxPwmzHkpqT
 wmzfr8pAVR3L1cDr68BMVgOShhyjE4QX4nRzm0VnfC+ut7tQ8gC2JDt1d468KGWoQvyglZPV3yy
 du+uzlfAA6ee+MrKmjeQ0BP4rfbImVQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180071
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/17 04:28 PM, Steven Rostedt wrote:
> On Fri, 23 Oct 2026 20:24:59 +0530
> Amit Machhiwal <amachhiw@linux.ibm.com> wrote:
> 
> > During early boot (early_trace_init() called from start_kernel()),
> > tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> > snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
> > smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare().
> > 
> > Before attempting page allocation, __rb_allocate_pages() performs a
> > heuristic check using si_mem_available() to return early with -ENOMEM if
> > memory appears insufficient.
> > 
> > However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> > NR_FREE_PAGES only reflects the initial non-deferred pool across the entire
> > period from early_trace_init() through smp_init().  defer_init() leaves
> > only a single section per node (e.g.  16 MiB with 64 KB pages) initialized
> > up-front, and on kernels with large static binary footprints (debug
> > configurations enabling PAGE_OWNER, DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG),
> > early core initialisations (SLUB caches, vmalloc, static ftrace records)
> > consume virtually all managed pages in this pool.
> > 
> > si_mem_available() therefore returns a false negative (often 0-1 pages)
> > across both SYSTEM_BOOTING (for the initial CPU 0 buffers) and
> > SYSTEM_SCHEDULING (for secondary CPU buffers via trace_rb_cpu_prepare()),
> > causing __rb_allocate_pages() to prematurely abort with -ENOMEM.
> > 
> > This failure is false: the buddy allocator is designed to replenish
> > ZONE_NORMAL on demand via deferred_grow_zone() when an actual allocation
> > is attempted.  Checking si_mem_available() before calling alloc_pages_node()
> > short-circuits this on-demand growth entirely.
> > 
> > deferred_grow_zone() is only permanently disabled after page_alloc_init_late()
> > completes (it spawns per-node kthreads and blocks until done), which happens
> > inside kernel_init_freeable() — before system_state is set to
> > SYSTEM_FREEING_INITMEM.  Skip the si_mem_available() check until
> > SYSTEM_FREEING_INITMEM, at which point all deferred pages are initialized
> > and si_mem_available() is accurate.
> > 
> > Use IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) to set i = LONG_MAX during
> > this window, unconditionally bypassing the threshold check.  On kernels
> > without deferred init IS_ENABLED() compiles the branch away and the original
> > check is preserved unchanged.
> 
> As Vincent mentioned, the above is just word salad. Please make it human
> readable. That is, state what the actual issue is and how it's fixed and
> remove all the AI fluff.
> 
> Also note, just because we no longer require an "Assisted-by" tag, it
> should still be mentioned how the patch was created. I want to know.

Hi Steven,

To answer how this was created: I investigated the issue, carried out the RCA
and debug runs on a Power11 KVM setup, and authored the patch logic.  When
writing the commit message, in a (clearly failed) attempt to explain the
details thoroughly, I ended up introducing the wordiness and fluff.  Later I did
use an LLM for a quick rewording and spell checking, which only made it worse I
guess.

For v5, I have completely rewritten the commit message myself to be concise
and to the point: stating the actual issue (deferred page init leaves
NR_FREE_PAGES near zero, making si_mem_available() under-report), the
spurious -ENOMEM failure during early_trace_init() and smp_init(), and the
fix mechanism.

<snip>

> >  		i = si_mem_available();
> > +		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
> > +		    system_state < SYSTEM_FREEING_INITMEM)
> > +			i = LONG_MAX;
> 
> Make the above an if/else statement.
> 
> 		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
> 		    unlikely(system_state < SYSTEM_FREEING_INITMEM))
> 			i = LONG_MAX;
> 		else
> 	  		i = si_mem_available();

Sure, this makes more sense and avoids calling si_mem_available() when it is not
reliable anyway.  I have incorporated this in v5.

Thanks,
Amit

