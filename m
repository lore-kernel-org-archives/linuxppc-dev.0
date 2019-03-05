Return-Path: <SRS0=9sKl=RI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFA0C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 06:59:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3412082C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 06:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3412082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44D7700HVyzDqGm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 17:59:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44D74t1NhbzDqDr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 17:57:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44D74s6270z9s6w;
 Tue,  5 Mar 2019 17:57:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: Printing of machine check severity
Date: Tue, 05 Mar 2019 17:57:47 +1100
Message-ID: <87pnr5vmdw.fsf@concordia.ellerman.id.au>
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
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, satheera@in.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

RE: https://github.com/linuxppc/issues/issues/230

> Host dmesg throws lot of below SLB [Multihit] HMI's
> 
> [295216.837358] Severe Machine check interrupt [Recovered]
> [295216.837365] Harmless Hypervisor Maintenance interrupt [Recovered]
> [295216.837374]   Guest NIP: c00000000024a7dc
> [295216.837378]  Error detail: Processor Recovery done
> [295216.837381]         HMER: 2040000000000000
> [295216.837388]   Initiator: CPU
> [295216.837406]   Error type: SLB [Multihit]
> [295216.837415]     Effective address: d00000000316c400


Paul points out that these aren't severe errors from the hosts point of
view, and possibly not even for the guest.

I think the key problem here is that we print "Severe" for most types of
MCEs, even though some really aren't.

That comes from the severity being set to `MCE_SEV_ERROR_SYNC` in the
i/derror table.

All the enum values are `MCE_SEV` so the value is actually `ERROR_SYNC`,
which I think means "synchronous error". That is correct. But I don't
think it's correct that all synchronous errors are "severe".

We also have some errors in `mce_ierror_table` that are marked
`MCE_SEV_FATAL` and then have a comment saying `/* ASYNC is fatal */`.

So I feel like we have severity and sync/async conflated in the severity
value, ie. we should split out sync/async and then have a separate
severity field.

We need to be careful because a few places check for `MCE_SEV_ERROR_SYNC`,
it's not *only* used for the severity string.

We could then mark eg. SLB multi-hits as warning rather than severe.

Additionally we probably want to use the `in_guest` flag to modulate the
severity or the message, or both.

cheers
