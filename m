Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9D7C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 11:00:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E199120685
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 11:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E199120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zjQw5Q86zF3BW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 22:00:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zjNs3qXRzF3Bv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 21:58:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42zjNr5pRHz9s3l;
 Tue, 20 Nov 2018 21:58:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Sam Bobroff <sbobroff@linux.ibm.com>
Subject: Re: [PATCH kernel] powerpc/powernv/eeh/npu: Fix uninitialized
 variables in opal_pci_eeh_freeze_status
In-Reply-To: <54e863e23af0fbc5f83b663fe7d6c95f86024c3c.camel@russell.cc>
References: <20181119042517.45075-1-aik@ozlabs.ru>
 <877eh831id.fsf@concordia.ellerman.id.au>
 <20181120035123.GB9175@tungsten.ozlabs.ibm.com>
 <1c7660de-68fd-60b7-087d-b013479154e0@ozlabs.ru>
 <54e863e23af0fbc5f83b663fe7d6c95f86024c3c.camel@russell.cc>
Date: Tue, 20 Nov 2018 21:58:20 +1100
Message-ID: <87zhu410dv.fsf@concordia.ellerman.id.au>
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
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>, Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Russell Currey <ruscur@russell.cc> writes:
> On Tue, 2018-11-20 at 17:55 +1100, Alexey Kardashevskiy wrote:
>> 
>> On 20/11/2018 14:51, Sam Bobroff wrote:
>> > On Tue, Nov 20, 2018 at 01:51:06PM +1100, Michael Ellerman wrote:
>> > > Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>> > > 
>> > > > The current implementation of the OPAL_PCI_EEH_FREEZE_STATUS
>> > > > call in
>> > > > skiboot's NPU driver does not touch the pci_error_type
>> > > > parameter so
>> > > > it might have garbage but the powernv code analyzes it
>> > > > nevertheless.
>> > > > 
>> > > > This initializes pcierr and fstate to zero in all call sites.
>> > > > 
>> > > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> > > > ---
>> > > 
>> > > Can we tag this with a Fixes? And seems like it should probably
>> > > go to
>> > > stable, or can we not trigger this path on older kernels?
>> > > 
>> > > cheers
>> > 
>> > Hmm, it's triggered by use on an NPU PE so that would be any kernel
>> > that
>> > can run on P8 or later (AFAIK).
>> > 
>> > It looks like the issue was present earlier, but the code was last
>> > touched when it was moved, in...
>> > 
>> > 40ae5f693f6a ("powerpc/powernv: Drop PHB operation get_state()")
>> > 
>> > ... which was back in v4.1.
>> 
>> The original commit is
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c41a7f3f7593fe57
>> 
>> 2013-06-20 13:21:09 +0800
>> ===
>> powerpc/eeh: I/O chip EEH state retrieval
>> 
>> The patch adds I/O chip backend to retrieve the state for the
>> indicated PE. While the PE state is temperarily unavailable,
>> the upper layer (powernv platform) should return default delay
>> (1 second).
>> ===
>> 
>> This was 3.10-rc5 (this is what that sha1's Makefile has).
>> 
>> But this was not the issue till skiboot decided not to zero these
>> parameters so "Fixes:" should point to what?
>
> It should still be that commit, it's perfectly reasonable (however
> unlikely) that someone could be running a 3.10 kernel with a modern
> skiboot.

Yeah that kernel commit is the earliest point where we could hit the
bug, so that's where Fixes should point.

If the bug's not actually in that commit, as it sounds here, then you
can explain that in the change log.

The other way to think about is if someone has back ported
8c41a7f3f7593fe57 then they would also want this fix, so pointing the
Fixes tag at 8c41a7f3f7593fe57 expresses that.

cheers
