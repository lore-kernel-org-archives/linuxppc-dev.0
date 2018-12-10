Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC0BC07E85
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 02:31:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432ED2081F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 02:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432ED2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CnBV1sQnzDqvl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 13:31:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Cn8C4s9qzDqVW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 13:29:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43Cn8C2q94z9s6w; Mon, 10 Dec 2018 13:29:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43Cn8B1bpmz9s0t;
 Mon, 10 Dec 2018 13:29:14 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH bpf] bpf: powerpc: fix broken uapi for
 BPF_PROG_TYPE_PERF_EVENT
In-Reply-To: <20181209223424.pvdigrtm4tdbt4h7@ast-mbp.dhcp.thefacebook.com>
References: <20181206092701.4153-1-sandipan@linux.ibm.com>
 <20181209223424.pvdigrtm4tdbt4h7@ast-mbp.dhcp.thefacebook.com>
Date: Mon, 10 Dec 2018 13:29:14 +1100
Message-ID: <87efaqf72d.fsf@concordia.ellerman.id.au>
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
Cc: naveen.n.rao@linux.ibm.com, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Dec 06, 2018 at 02:57:01PM +0530, Sandipan Das wrote:
>> Now that there are different variants of pt_regs for userspace and
>> kernel, the uapi for the BPF_PROG_TYPE_PERF_EVENT program type must
>> be changed by exporting the user_pt_regs structure instead of the
>> pt_regs structure that is in-kernel only.
>> 
>> Fixes: 002af9391bfb ("powerpc: Split user/kernel definitions of struct pt_regs")
>> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
>
> Thanks! Applied to bpf tree.

I already have this in the fixes branch of the powerpc tree. I don't
mind if you take it also, git should probably handle the merge OK.

cheers
