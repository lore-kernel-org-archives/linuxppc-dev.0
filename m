Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B108DC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 22:17:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169C321019
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 22:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169C321019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KR5q4zdXzDqLk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 09:17:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KR4028hyzDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 09:15:27 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2DMEghi031276;
 Wed, 13 Mar 2019 17:14:42 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x2DMEcO4031272;
 Wed, 13 Mar 2019 17:14:38 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 13 Mar 2019 17:14:37 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: Re: bpf jit PPC64 (BE) test_verifier PTR_TO_STACK store/load failure
Message-ID: <20190313221436.GO3969@gate.crashing.org>
References: <xuny4l87qc2v.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xuny4l87qc2v.fsf@redhat.com>
User-Agent: Mutt/1.4.2.3i
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
Cc: Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@redhat.com>,
 Sandipan Das <sandipan@linux.ibm.com>, netdev@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Wed, Mar 13, 2019 at 12:54:16PM +0200, Yauheni Kaliuta wrote:
> This is because of the handling of the +2 offset.

The low two bits of instructions with primary opcodes 58 and 62 are part
of the opcode, not the offset.  These instructions can not have offsets
with the low two bits non-zero.

> For stores it is:
> #define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | ___PPC_RS(r) |	      \
> 				     ___PPC_RA(base) | ((i) & 0xfffc))
> 
> and for loads
> #define PPC_LD(r, base, i)	EMIT(PPC_INST_LD | ___PPC_RT(r) |	      \
> 				     ___PPC_RA(base) | IMM_L(i))
> #define IMM_L(i)		((uintptr_t)(i) & 0xffff)
> 
> So, in the load case the offset +2 (immediate value) is not
> masked and turns the instruction to lwa instead of ld.
> 
> Would it be correct to & 0xfffc the immediate value as well?

That is only part of it.  The other thing is you have to make sure those
low bits are zero *already* (and then you do not need the mask anymore).
For example, if the low two bits are not zero load the offset into a
register instead (and then do ldx or lwax).


Segher
