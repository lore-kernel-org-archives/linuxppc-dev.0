Return-Path: <SRS0=5PiN=6Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B30EC47255
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 14:19:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CAC206DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 14:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="HcmtsGhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CAC206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49LNN90JBpzDr2p
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2020 00:19:05 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49LJYQ68h6zDqgx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2020 21:26:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=HcmtsGhW; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49LJYN0Wgxz9sV6;
 Mon, 11 May 2020 21:26:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1589196409;
 bh=4NvXf9toL+4UXpT6HxsGqGALQmokSTs3VQyX07XztTk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=HcmtsGhW3vvibCLKVXSur3CJ6fDr8ntOm4mcDszKPhs4GTP737/Wdfw0z6huCxBCe
 HVcsEEd/MTSe9PIvxR4g1mJyWlY9pNfzuhdWrgSLDvrxv0HoV0uCl81kNTDqjk5Cxc
 TgCZNgAde0FVNfAZ4JhAxZ7N9PiEsN+zjxPDzb7Rc4uXtU4HmRtqRWhhDdLzWuCB8l
 GZBwk+W4cMwAKVsgp5G9PAyRFVaBbJ0zWJP9A9TDVJYCcc8SUNVV+6i8c+OlC0UZIZ
 A+Tdq4kCohHBk3kW2wY1c8d3rP7bLfFFQlHv8A/x1THr3dNj5iLBtWGWEfQ2IcZBQ0
 S3FUgyHwBmyow==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH v3 1/3] powerpc/numa: Set numa_node for all possible cpus
In-Reply-To: <20200508132130.GC1961@linux.vnet.ibm.com>
References: <20200501031128.19584-1-srikar@linux.vnet.ibm.com>
 <20200501031128.19584-2-srikar@linux.vnet.ibm.com>
 <alpine.DEB.2.21.2005022254170.28355@www.lameter.com>
 <20200508132130.GC1961@linux.vnet.ibm.com>
Date: Mon, 11 May 2020 21:27:07 +1000
Message-ID: <87v9l2btkk.fsf@mpe.ellerman.id.au>
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
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, Michal Hocko <mhocko@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Vlastimil Babka <vbabka@suse.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Christopher Lameter <cl@linux.com> [2020-05-02 22:55:16]:
>
>> On Fri, 1 May 2020, Srikar Dronamraju wrote:
>> 
>> > -	for_each_present_cpu(cpu)
>> > -		numa_setup_cpu(cpu);
>> > +	for_each_possible_cpu(cpu) {
>> > +		/*
>> > +		 * Powerpc with CONFIG_NUMA always used to have a node 0,
>> > +		 * even if it was memoryless or cpuless. For all cpus that
>> > +		 * are possible but not present, cpu_to_node() would point
>> > +		 * to node 0. To remove a cpuless, memoryless dummy node,
>> > +		 * powerpc need to make sure all possible but not present
>> > +		 * cpu_to_node are set to a proper node.
>> > +		 */
>> > +		if (cpu_present(cpu))
>> > +			numa_setup_cpu(cpu);
>> > +		else
>> > +			set_cpu_numa_node(cpu, first_online_node);
>> > +	}
>> >  }
>> 
>> Can this be folded into numa_setup_cpu?
>> 
>> This looks more like numa_setup_cpu needs to change?
>
> We can fold this into numa_setup_cpu().
>
> However till now we were sure that numa_setup_cpu() would be called only for
> a present cpu. That assumption will change.
> + (non-consequential) an additional check everytime cpu is hotplugged in.
>
> If Michael Ellerman is okay with the change, I can fold it in.

Yes I agree it would be better in numa_setup_cpu().

cheers
