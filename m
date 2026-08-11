Return-Path: <linuxppc-dev+bounces-25721-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CAEC5B56A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 04:59:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJztM0bqWz2yvG;
	Tue, 11 Aug 2026 14:59:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786424347;
	cv=none; b=YtsUtEmcMiL6BYXA9V2fVXUQd/6AnuA2cf9t43fpd0VeMaOKJhGgCzyDCCjGcsR6IJ/vKbHRP7u3rIvJc3BEJYx4v0mnlq3Aog/TyCjEf/VpmSqe1UCJnmmWErH3Q1fdjhUQKrg96eRztFdJYE9Aen22/pUUa+LFEQ1ecdI/vO9trN5ldeKdIWdgks5sxLIh4kjlcnbn9mO/oQRSoVt6IGmx0Z1RvuOgJ7Itg1ORTgfSSH6Cb+65r5CJK7kLYHr2PupBc+NMCLuRyh5NLJjxrXauSdnjrVx4dVccqQm69f7OSjzkCHAgOfNCBkJzLDX/TSF5DdndQujftRJcTiAV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786424347; c=relaxed/relaxed;
	bh=VpmP0/V/f3nYUUeEX4OZFCdq3p8rw9FlptRhR3LAYSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9nMirB8bAU5oqpa28wGA3jMSGECmWq0XNEZZ4dWddSOXeSQk01s7p6QHMe80MUqfd2fMae50jUVRQYklpj51x8Q5mLIyW0ULm3cJcWKsXlsj2DPJNf2c/kQq85A/F19KCK0tPGOzw7MBj77btiA3zhjt4BVJBAB+E3atgKPV3d64L6jJtBLHNKOm/yjt+icPsUe1niS3Tbh0ouqZ5vh4GGr71xOGr7LXfR+aGuc2riPsW1S2oF4Kh5IR5geBHoea5xPdffHEwSB67chLhn3mxN+tC+lGN6YAyFsAv7FgexIuxx4f9EYkHXXo3ilCJsGA5G4SKXfPD7QJ3aAhBHf4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gx25TPM0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gx25TPM0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJztL2wH7z2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 14:59:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B2CFD4185F;
	Tue, 11 Aug 2026 04:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56CC1F000E9;
	Tue, 11 Aug 2026 04:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786424343;
	bh=VpmP0/V/f3nYUUeEX4OZFCdq3p8rw9FlptRhR3LAYSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Gx25TPM0IQQuJ6Jt9Y43E/IQ6dVfolSgn1TdiB0fleynDN7oPw4YRKYboFKtHg0NQ
	 EEX2jrLsp9v7+TlvUug+fBMqZzhfA83Cq+U5WQmeChknJ8ifPDPeSHFC2vPHKut2UZ
	 Oi5FQmgTR3oHER0N/FVFX/uzLCzJWNlEVEBk5HWg04NUwj8iVsiv0pPd/GKgED8J+J
	 fAzQaSFMzQfJRQGSIjIIR5aKOVyEbltgSQ0S6UrTEvqyMalGkxVwPmGllSBpk3iu5u
	 WHMes8RO1gPlhZ941IvwOV5zoYeCQFQZyhmvNwqornTBtjS24uPtHpDWfPaJ93zjRF
	 bXnBuiQdQYHNA==
Message-ID: <eff5c192-ed33-44e8-8834-fa5b4803f39b@kernel.org>
Date: Tue, 11 Aug 2026 06:58:57 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] powerpc: userspace processes crash in ld64.so.2 when
 running recent linux-next kernels
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Ritesh Harjani <riteshh@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, ajd@linux.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <75419f88-eab9-444b-bf97-28a9765819ad@linux.ibm.com>
 <627c5c2f-a0b3-4fba-811f-7b4ed4c74dbb@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <627c5c2f-a0b3-4fba-811f-7b4ed4c74dbb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/08/2026 à 06:23, Venkat Rao Bagalkote a écrit :
> 
> As part of debugging and suggested by Maddy, I reverted the following 
> commit:
> 
>    263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for 
> ptrace")
> 
> and rebuilt/booted linux-next with only that change reverted.
> 
> After booting the reverted kernel, I rebuilt the latest upstream kernel
> using the same userspace and toolchain. The build completed
> successfully and I did not observe any of the ld64.so.2 userspace
> segfaults that were previously seen during kernel compilation.
> 
> Kernel used for testing:
> 
>    7.2.0-rc5-next-20260731-00001-g79d9c1ce90a9
> 
> Top of tree:
> 
>    commit 79d9c1ce90a9873422ca4d6d0124a1d1c10a098c
>    Revert "powerpc: Fix exit_flags field placement in pt_regs for ptrace"
> 
> The upstream kernel build completed successfully:
> 
>    INSTALL /lib/modules/7.2.0-rc7/kernel/net/openvswitch/vport-gre.ko
>    DEPMOD  /lib/modules/7.2.0-rc7
>    INSTALL /boot
> 
> Based on this testing, reverting commit 263e5159e00a appears to
> eliminate the random userspace crashes observed during kernel builds,
> suggesting that the issue may be related to that change.

But commit 263e5159e00a fixes commit d7a6797e0bc1 ("powerpc: add 
exit_flags field in pt_regs"), by reverting commit 263e5159e00a you 
re-introduce other bugs.

It's a bit difficult to see what commit 263e5159e00a is doing exactly, 
most of it is a revert of commit d7a6797e0bc1 but it does something 
instead. Need to see what remains with both commits applied.

Christophe

