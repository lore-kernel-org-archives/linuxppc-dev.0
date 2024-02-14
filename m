Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BE3C48BC1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Feb 2024 13:13:00 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=PXecqrRp;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TZdsl03Dfz3dWD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Feb 2024 00:12:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=PXecqrRp;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TZdrx19t6z30h8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2024 00:12:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1707916337;
	bh=cffIQaN+beGj/3I55DE0oSZyt9HMVBTYGB8h4ZzGgFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PXecqrRpHtYxJ6SUFHBQzOAh2a0YYaeO0XPb2mSR2WxwP6MRed/W8GLCOaiCGcbYV
	 c6s2L6Ig7F8LAjyZnhYunbAbKP/0zlfLNJpWZGlhNHCqBakEulsIaVBnKelEgfyTq+
	 Wn64QkwKpeyEiJs5LNzV1Z/mbxz1bN8bVgRVxUs7UN+mxZ2GBYNK0xP76XIfhr/mNX
	 WIbkll1rUJZkEsJucoHdXkmpIKfoPXm8aOozw7d7PJSRFMsehTHb8WG08jGqa6cdN1
	 OYTqcJAvYKomfda+wyCdDgljL8zl+gCpbo/bVVhSCLmNCAVqrVs/5N5Bb0jlY+iVCV
	 h2VRkoEcJOaVA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TZdrw1wb5z4wcK;
	Thu, 15 Feb 2024 00:12:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Bohac <jbohac@suse.cz>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH 5/5] powerpc/smp: Remap boot CPU onto core 0 if >=
 nr_cpu_ids
In-Reply-To: <ZcZLEe1mQHXvh44Y@dwarf.suse.cz>
References: <20231229120107.2281153-1-mpe@ellerman.id.au>
 <20231229120107.2281153-5-mpe@ellerman.id.au> <87cyukny0j.fsf@kernel.org>
 <ZcZLEe1mQHXvh44Y@dwarf.suse.cz>
Date: Thu, 15 Feb 2024 00:12:13 +1100
Message-ID: <87frxv6vgy.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Pingfan Liu <piliu@redhat.com>, Pingfan Liu <kernelfans@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jiri Bohac <jbohac@suse.cz> writes:
> On Tue, Jan 02, 2024 at 10:16:04AM +0530, Aneesh Kumar K.V wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>> 
>> ....
>> 
>> >  #ifdef CONFIG_PPC64
>> >  int boot_cpu_hwid = -1;
>> > @@ -492,12 +493,26 @@ void __init smp_setup_cpu_maps(void)
>> >  			avail = !of_property_match_string(dn,
>> >  					"enable-method", "spin-table");
>> >  
>> > -		cpu = assign_threads(cpu, nthreads, avail, intserv);
>> > +		if (boot_core_hwid >= 0) {
>> > +			if (cpu == 0) {
>> > +				pr_info("Skipping CPU node %pOF to allow for boot core.\n", dn);
>> > +				cpu = nthreads;
>> > +				continue;
>> > +			}
>> >  
>> > -		if (cpu >= nr_cpu_ids) {
>> > +			if (be32_to_cpu(intserv[0]) == boot_core_hwid) {
>> > +				pr_info("Renumbered boot core %pOF to logical 0\n", dn);
>> > +				assign_threads(0, nthreads, avail, intserv);
>> > +				of_node_put(dn);
>> > +				break;
>> >
>> 
>> I was expecting a 'continue' here. Why 'break' the loop? The condition that
>> should break the loop should be cpu >= nr_cpu_ids 
>
> No, the patch seems correct:
>
> We're in the "if (boot_core_hwid >= 0)" branch, meaning that it
> was determined by early_init_dt_scan_cpus() that boot_cpuid >=
> nr_cpu_ids. So we loop until we get to the boot CPU, so it can be
> renumbered to 0. Once we do that we break, because we
> know we are already past nr_cpu_ids - otherwise boot_core_hwid
> would not be >= 0. 

Yes that's exactly right.

Thanks for answering for me (was on leave and still catching up).

cheers
