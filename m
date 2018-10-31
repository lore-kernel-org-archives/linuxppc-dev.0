Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6DDC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 05:53:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F5320657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 05:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F5320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lHZG2f19zF3Jx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 16:53:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lHLC5g24zDrJn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 16:42:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42lHLC562Tz9sMM; Wed, 31 Oct 2018 16:42:59 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42lHLC4gsjz9sNC; Wed, 31 Oct 2018 16:42:59 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c43befca86ae35cc82bd889484bd179bff27b6c6
In-Reply-To: <20181020095455.GA12489@blackberry>
To: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] KVM: PPC: Use exported tb_to_ns() function in decrementer
 emulation
Message-Id: <42lHLC4gsjz9sNC@ozlabs.org>
Date: Wed, 31 Oct 2018 16:42:59 +1100 (AEDT)
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
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2018-10-20 at 09:54:55 UTC, Paul Mackerras wrote:
> This changes the KVM code that emulates the decrementer function to do
> the conversion of decrementer values to time intervals in nanoseconds
> by calling the tb_to_ns() function exported by the powerpc timer code,
> in preference to open-coded arithmetic using values from the
> decrementer_clockevent struct.  Similarly, the HV-KVM code that did
> the same conversion using arithmetic on tb_ticks_per_sec also now
> uses tb_to_ns().
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c43befca86ae35cc82bd889484bd17

cheers
