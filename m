Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A705C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 11:37:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480062085A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 11:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480062085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SXLf4nVMzDqJL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 22:37:46 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SXJH4ttWzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 22:35:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44SXJG5M9sz9sNw;
 Mon, 25 Mar 2019 22:35:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ben Hutchings <ben@decadent.org.uk>, Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM
 configurations
In-Reply-To: <cf9154f1812e0e9a328a1e21ef13d80a46e5feb6.camel@decadent.org.uk>
References: <20190317011756.abjylw3nzfnc6gnh@decadent.org.uk>
 <44QjSh4zGhz9sV2__48832.6491251186$1553257542$gmane$org@ozlabs.org>
 <87k1gnq5lp.fsf@igel.home>
 <eb21be1ac183dd206da3a389b426707c535c463c.camel@decadent.org.uk>
 <87ftrbq0qe.fsf@igel.home>
 <cf9154f1812e0e9a328a1e21ef13d80a46e5feb6.camel@decadent.org.uk>
Date: Mon, 25 Mar 2019 22:35:41 +1100
Message-ID: <87a7hjp4oi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ben Hutchings <ben@decadent.org.uk> writes:
> On Mon, 2019-03-25 at 01:03 +0100, Andreas Schwab wrote:
>> On M=C3=A4r 24 2019, Ben Hutchings <ben@decadent.org.uk> wrote:
>>=20
>> > Presumably you have CONFIG_PPC_BOOK3S_64 enabled and
>> > CONFIG_SPARSEMEM
>> > disabled?  Was this configuration actually usable?
>>=20
>> Why not?
>
> I assume that CONFIG_SPARSEMEM is the default for a good reason.
> What I don't know is how strong that reason is (I am not a Power expert
> at all).  Looking a bit further, it seems to be related to CONFIG_NUMA
> in that you can enable CONFIG_FLATMEM if and only if that's disabled.=20
> So I suppose the configuration you used works for non-NUMA systems.

Aneesh pointed out this fix would break FLATMEM after I'd merged it, but
it didn't break any of our defconfigs so I wondered if anyone would
notice.

I checked today and a G5 will boot with FLATMEM, which I assume is what
Andreas is using.

I guess we should fix this build break for now.

Even some G5's have discontiguous memory, so FLATMEM is not clearly a
good choice even for all G5's, and actually a fresh g5_defconfig uses
SPARSEMEM.

So I'm inclined to just switch to always using SPARSEMEM on 64-bit
Book3S, because that's what's well tested and we hardly need more code
paths to test. Unless anyone has a strong objection, I haven't actually
benchmarked FLATMEM vs SPARSEMEM on a G5.

cheers
