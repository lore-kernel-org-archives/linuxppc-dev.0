Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D8DC4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 12:52:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E897F60E09
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 12:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E897F60E09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GddFX3BBkz30G9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 22:52:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=benh@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4GddFB4421z306F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Aug 2021 22:52:14 +1000 (AEST)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 172Cmjo5004672;
 Mon, 2 Aug 2021 07:48:46 -0500
Message-ID: <d74d17c761f55b0e2768527f4d5e57a6eb3ac84f.camel@kernel.crashing.org>
Subject: Re: Possible regression by ab037dd87a2f (powerpc/vdso: Switch VDSO
 to generic C implementation.)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Murphy <murp@ibm.com>,
 pmenzel@molgen.mpg.de
Date: Mon, 02 Aug 2021 22:48:45 +1000
In-Reply-To: <87czqwl67h.fsf@mpe.ellerman.id.au>
References: <b5f948b4-759d-bb9f-06aa-6c15d37cd2bb@molgen.mpg.de>
 <a273c619-9258-e29a-24c3-ea47a13c4817@molgen.mpg.de>
 <3661999754da1a5e5c810fa669654cc7db95b059.camel@kernel.crashing.org>
 <4f037af0-5066-ebb9-53a6-733b3bd8eeac@molgen.mpg.de>
 <878s1q1udj.fsf@mpe.ellerman.id.au>
 <OF44F7146F.67A4C1C2-ON00258720.004DBF64-00258720.004FCFCC@ibm.com>
 <87czqwl67h.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: parkerderek86@gmail.com, laboger@linux.vnet.ibm.com, xaionaro@gmail.com,
 paulus@samba.org, murphyp@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2021-08-02 at 16:18 +1000, Michael Ellerman wrote:
> 
> But to be fair the ABI of the VDSO has always been a little fishy,
> 
> because the entry points pretend to be a transparent wrapper around
> 
> system calls, but then in a case like this are not.

This is somewhat debatable :-) If your perspective is from an
application, whether your wrapper is glibc, the vdso or *** knows what
else, you can't make assumptions about the state of the registers on a
signal hitting somewhere in your call chain other than what's
guanranteed by the ABI overall (ie, TLS etc...).

Nowhere was it written that a VDSO call behaved strictly like an sc
instruction :-)
> 
> > Go up to this point has only used the vdso function __kernel_clock_gettime; it
> > is the only entry point which would need to explicitly avoid R30 for
> > Go's sake.
> 
> 
> I thought about limiting the workaround to just that code, but it seemed
> silly and likely to come back to bite us. Once the compilers decides to
> spill a non-volatile there are plenty of other ones to choose from.

Yeah fine graining this is a waste of time, I agree. Just stick with
fixing r30 for the whole vdso, it won't actually hurt, just make sure
this is somewhat documented as to why we do it (I don't remember what
you patch does off hand, I assume at least your git commit has all the
data, a comment near the offending line in the Makefile might be good
too).

Cheers,
Ben.


