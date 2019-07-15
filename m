Return-Path: <SRS0=O2mS=VM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDA4C73C66
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 02:25:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F5920C01
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 02:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F5920C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45n6pC75TyzDqTx
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 12:25:55 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45n6lj1zDkzDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2019 12:23:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45n6lh4LPgz9sP0;
 Mon, 15 Jul 2019 12:23:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: mm: Limit rma_size to 1TB when running without
 HV mode
In-Reply-To: <1563155904.2145.1.camel@gmail.com>
References: <20190710052018.14628-1-sjitindarsingh@gmail.com>
 <87o91ze6wx.fsf@concordia.ellerman.id.au> <1563155904.2145.1.camel@gmail.com>
Date: Mon, 15 Jul 2019 12:23:44 +1000
Message-ID: <87d0ic9gsv.fsf@concordia.ellerman.id.au>
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
Cc: kvm-ppc@vger.kernel.org, david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
> On Fri, 2019-07-12 at 23:09 +1000, Michael Ellerman wrote:
>> Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
>> > The virtual real mode addressing (VRMA) mechanism is used when a
>> > partition is using HPT (Hash Page Table) translation and performs
>> > real mode accesses (MSR[IR|DR] = 0) in non-hypervisor mode. In this
>> > mode effective address bits 0:23 are treated as zero (i.e. the
>> > access
>> > is aliased to 0) and the access is performed using an implicit 1TB
>> > SLB
>> > entry.
>> > 
>> > The size of the RMA (Real Memory Area) is communicated to the guest
>> > as
>> > the size of the first memory region in the device tree. And because
>> > of
>> > the mechanism described above can be expected to not exceed 1TB. In
>> > the
>> > event that the host erroneously represents the RMA as being larger
>> > than
>> > 1TB, guest accesses in real mode to memory addresses above 1TB will
>> > be
>> > aliased down to below 1TB. This means that a memory access
>> > performed in
>> > real mode may differ to one performed in virtual mode for the same
>> > memory
>> > address, which would likely have unintended consequences.
>> > 
>> > To avoid this outcome have the guest explicitly limit the size of
>> > the
>> > RMA to the current maximum, which is 1TB. This means that even if
>> > the
>> > first memory block is larger than 1TB, only the first 1TB should be
>> > accessed in real mode.
>> > 
>> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>> 
>> I added:
>> 
>> Fixes: c3ab300ea555 ("powerpc: Add POWER9 cputable entry")
>> Cc: stable@vger.kernel.org # v4.6+
>> 
>> 
>> Which is not exactly correct, but probably good enough?
>
> I think we actually want:
> Fixes: c610d65c0ad0 ("powerpc/pseries: lift RTAS limit for hash")
>
> Which is what actually caused it to break and for the issue to present
> itself.

Thanks, I used that instead.

cheers
