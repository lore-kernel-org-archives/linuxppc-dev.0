Return-Path: <SRS0=dmdX=PA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C738C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Oct 2021 02:09:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E4F60FD7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Oct 2021 02:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0E4F60FD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSzcx1N0mz303D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Oct 2021 13:09:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=JOVVwsUf;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HSzcC2pNSz2xy3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Oct 2021 13:08:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=JOVVwsUf; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HSzcB30wCz4xbc;
 Tue, 12 Oct 2021 13:08:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1634004538;
 bh=hzcHFArt94zy363Gzhk7t10ot1lGPm8IAL6s4wImyCc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=JOVVwsUfORu9PY7ma0fPedRzQxhk7QXd0AJrZ0JblugIjzl2isW6Y21f8YJ94OgVe
 plHnW8dcsdZOwQhajUHBotDHm/EtfgOT94xWFVu3vqTvpl6xjgUmBZQT7iyyYknFT1
 XaymkcVsdHgoALaIW/0efoF5xxRIDW2XqDm1mfm0TYAMd4nEGAijnK7wzkXFfc6mF5
 pBNylazJAscSKJjkCl+d59LkhoU5ckjAi5Z8nt8vZJX1/bBFlIjA+ioJoIz7jgCF4Q
 PGi//H0HsQwQpDPZuUVUjfH9yfrGeBnCysoyhkQeKso6wWfyt/M+zwLNW3gnAgBIAJ
 +PnmIrCuR6zBg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 02/52] powerpc/64s: guard optional TIDR SPR with CPU
 ftr test
In-Reply-To: <87v9235rl2.fsf@linux.ibm.com>
References: <20211004160049.1338837-1-npiggin@gmail.com>
 <20211004160049.1338837-3-npiggin@gmail.com>
 <87v9235rl2.fsf@linux.ibm.com>
Date: Tue, 12 Oct 2021 13:08:57 +1100
Message-ID: <87k0ijm1ty.fsf@mpe.ellerman.id.au>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fabiano Rosas <farosas@linux.ibm.com> writes:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
>> The TIDR SPR only exists on POWER9. Avoid accessing it when the
>> feature bit for it is not set.
>
> Not related to this patch, but how does this work with compat mode? A P9
> compat mode guest would get an invalid instruction when trying to access
> this SPR?

Good question.

I assume you're talking about P9 compat mode on P10.

In general compat mode only applies to userspace, because it's
implemented by setting the PCR which only (mostly?) applies to PR=3D1.

I don't think there's any special casing in the ISA for the TIDR, so I
think it just falls into the unimplemented SPR case for mt/fspr.

That's documented in Book III section 5.4.4, in particular on page 1171
it says:

  Execution of this instruction specifying an SPR number
  that is undefined for the implementation causes one of
  the following.
  =E2=80=A2 if spr[0]=3D0:
    - if MSR[PR]=3D1: Hypervisor Emulation Assistance interrupt
    - if MSR[PR]=3D0: Hypervisor Emulation Assistance interrupt for SPR
      0,4,5, and 6, and no operation (i.e., the instruction is treated
      as a no-op) when LPCR[EVIRT]=3D0 and Hypervisor Emulation Assistance
      interrupt when LPCR[EVIRT]=3D1 for all other SPRs

Linux doesn't set EVIRT, and I assume neither does phyp, so it behaves
like a nop.

We actually use that behaviour in xmon to detect that an SPR is not
implemented, by noticing that the mfspr has no effect on the target
register, see dump_one_spr().

We should really write some docs on compat mode in the linuxppc wiki
and/or Documentation ;)

cheers
