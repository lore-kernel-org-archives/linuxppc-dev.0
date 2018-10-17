Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB4DC5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:17:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009652147E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009652147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZXn764WfzF3V3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 11:17:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZXkN1jLlzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 11:15:07 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9H0EIaZ022868;
 Tue, 16 Oct 2018 19:14:23 -0500
Message-ID: <cd4f6bd709b80646bad628f94724505fdb352459.camel@kernel.crashing.org>
Subject: Re: What is an address translation in powerISA jarogn ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Raz <raziebe@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 Oct 2018 11:14:15 +1100
In-Reply-To: <CAPB=Z-ospEB9cyjaqk1zKy8axVKnri4=A=wBRHB_fMM_MKgCbA@mail.gmail.com>
References: <CAPB=Z-ospEB9cyjaqk1zKy8axVKnri4=A=wBRHB_fMM_MKgCbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-10-16 at 20:58 +0300, Raz wrote:
> Section 5.7.3
> "Storage accesses in real, hypervisor real, and virtual real
> addressing modes are performed in a manner that depends on the
> contents of MSR HV , VPM, VRMASD, HRMOR, RMLS, RMOR (see Chapter 2),
> bit 0 of the
> effective address (EA0),"
> 
> Hello
> 1. If MSR_IR = 0 and MSR_DR = 0, does it mean that addresses are not
> translated by the MMU ?

It depends.

If HV=1 (hypervisor mode), then they are only translated to the extent
that HRMOR is applied if the MSB is 0, and untranslated if the MSB is
1.

If HV=0 (guest mode), then they *are* translated but using a different
mechanism than what's normally used when IR/DR=1. This mechanism
depends on whether you are using the Radix or the Hash MMU, and the top
2 bits are ignored.

With hash MMU, it's using things like VRMASD etc... (RMOR is deprecated
afaik) to lookup a "Virtual real mode" area in the hash table. It's
essentially a mapping of the guest "physical" space to real physical
space. It's usually initialized (and maintained) by the HV but the
guest can extend it using things like H_ENTER afaik.

With the radix MMU, it's the guest physical space as mapped by the 2nd
level page tables maintained by the hypervisor.

> 2. If EA0 is the 63-rd bit of the effective address e address ? Does
> this mean that the translation model is
>    derived from the address ? a non privileged context may access
> privileged memory.

Nope.

Cheers,
Ben.


