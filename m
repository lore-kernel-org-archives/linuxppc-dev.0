Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00D8C282C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 02:26:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5662084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 02:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5662084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yV5v20SZzDqNt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 13:26:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yV4868PLzDqMM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 13:24:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43yV484fHzz9sBZ;
 Mon, 11 Feb 2019 13:24:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver <oohall@gmail.com>
Subject: Re: [PATCH 7/7] powerpc/eeh: Add eeh_force_recover to debugfs
In-Reply-To: <CAOSf1CFJqFaAwE34GFU4cwWkhGd-jwUPGANadAcNNwp3H2mvqg@mail.gmail.com>
References: <20190208030802.10805-1-oohall@gmail.com>
 <20190208030802.10805-7-oohall@gmail.com>
 <87tvheihqa.fsf@concordia.ellerman.id.au>
 <CAOSf1CFJqFaAwE34GFU4cwWkhGd-jwUPGANadAcNNwp3H2mvqg@mail.gmail.com>
Date: Mon, 11 Feb 2019 13:24:56 +1100
Message-ID: <87ftsvhxjb.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Oliver <oohall@gmail.com> writes:
> On Fri, Feb 8, 2019 at 11:32 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Oliver O'Halloran <oohall@gmail.com> writes:
>>
>> > This patch adds a debugfs interface to force scheduling a recovery event.
>> > This can be used to recover a specific PE or schedule a "special" recovery
>> > even that checks for errors at the PHB level.
>> > To force a recovery of a normal PE, use:
>> >
>> >  echo '<#pe>:<#phb>' > /sys/kernel/debug/powerpc/eeh_force_recover
>> >
>> > To force a scan broken PHBs:
>> >
>> >  echo 'null' > /sys/kernel/debug/powerpc/eeh_force_recover
>>
>> Why 'null', that seems like an odd choice. Why not "all" or "scan" or
>> something?
>
> When an EEH event occurs the bit that is sent to the event handler is
> just a pointer the the struct eeh_pe. If the pointer is null it's then
> treated as a special event which indicates a PHB failure. I agree it's
> a bit dumb, but I don't really expect anyone except me or samb to use
> this interface so I went with what would make sense to someone
> familiar with the internals.

Yeah, nah. Let's use something that's at least vaguely self documenting
so people like me can have some clue what it's doing.

cheers
