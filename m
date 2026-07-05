Return-Path: <linuxppc-dev+bounces-23566-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42924C43458
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Jul 2026 06:49:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtJ562FBkz2yYd;
	Sun, 05 Jul 2026 16:49:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783234186;
	cv=none; b=MT3iKaeZbA16lWaXFhD+1mK1X8FeVI8kSRMxiNfluO3tP8qqFFNT288DgYAH8y4xQPq11K2k7pXKBoqVq4eLd9EIMNHyTjBOcU4HBmhCa6hRVDv/eLsAzXYH0p34xQqB28sYziwM7fDygRlobUMXaMGakA833yMDRf5DnVDxuObFpJIlUyptqFtfzuHCiL3AtwqDm56+4OsIa4YJw2AC5ztxa8aj2swkFumFBGBphbZw6TmaKvpSwG99HAnCuWG4pSs97YyNtvhnJ1eyNcFQiwCbYgBN+2IH1L9bTrsrU+WWSbEWc3B3kqs/Xh4fUzMWPchwGKuScnmwES5qO/J3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783234186; c=relaxed/relaxed;
	bh=/b6p9VCxXgOfRXqAwZht7+2IgpRpMZFd44FX/w6ztGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aX7VZpa0SQlYYNjH5tcZGle32l3gqiel6cQDAhMXaBgBXnsI+NrrxC+QxGUyKjWssvz47qtold3I7lxs/WtSt/rfFA/8IhgH8lrFl60bhW/B2k//ZhC+h3UHNS9TkvTJ5aT8+eOFkfaCxqlUC5BD/csdsECpoQavAZgmYcju+AbFnxAufmPRzNbZ1mKdZXVpZMejFqEAOaAPCtjqFmuA8qEBmlQW0EmJRbHajcHjshaxyBtv3PMDTpFBTU13KS9eAoCNxwkVZA6BHpj1cfOgIr9vgdeZ1CvlOdfnsrV5+ZHEAskiVbl3AmvdmBLDog/fFU1RtqLK+mHrict8dzb2bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qyn8XJpz; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qyn8XJpz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtJ551YHPz2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2026 16:49:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8EA4E60051;
	Sun,  5 Jul 2026 06:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E6D1F000E9;
	Sun,  5 Jul 2026 06:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783234180;
	bh=/b6p9VCxXgOfRXqAwZht7+2IgpRpMZFd44FX/w6ztGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Qyn8XJpzjSmPL7YiwiLhovppcEnMpXVioLtNASLgdoGzlyYn0SUN+KhCgaX6RlqyE
	 a8ZugqKkvzl+V7xPnBDLIk79AVJI4QWbzOfv3F+O9iLUTqBukGmm96Yfw6snMMr5kF
	 uuZstsIwC3HbsRn/KWgQL2Uxb5sP63iYznWJwnHNCHjUrWgZfFQxmeAvbUqOxJZ3R9
	 jrsd9mseYDtG8pE+m7tIwh2ci+08LKYUFPSsDZcUKv7JAxD/jSjc2AhNlzbu4Vl2TB
	 tX83MO6q3hMxSW8fvl3wzdvld5oKKdnSnDSoW2uneVZVb0dDlsdMRPBbwvmbrlySMg
	 xZaRrTg47hvVQ==
Message-ID: <1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
Date: Sun, 5 Jul 2026 08:49:27 +0200
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
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
To: Andreas Schwab <schwab@linux-m68k.org>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, oleg@redhat.com,
 kees@kernel.org, luto@amacapital.net, wad@chromium.org,
 mchauras@linux.ibm.com, sshegde@linux.ibm.com, thuth@redhat.com,
 ruanjinjie@huawei.com, akpm@linux-foundation.org, macro@orcam.me.uk,
 ldv@strace.io, charlie@rivosinc.com, deller@gmx.de, kevin.brodsky@arm.com,
 ritesh.list@gmail.com, yeoreum.yun@arm.com, agordeev@linux.ibm.com,
 segher@kernel.crashing.org, mark.rutland@arm.com, ryan.roberts@arm.com,
 pmladek@suse.com, feng.tang@linux.alibaba.com, peterz@infradead.org,
 kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20260427122742.210074-1-mkchauras@gmail.com>
 <87wlvazrdy.fsf@igel.home>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <87wlvazrdy.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/07/2026 à 17:49, Andreas Schwab a écrit :
> This breaks booting on the PowerMac G5 (PowerMac7,3), there is a panic
> somwhere in an irq.
> 

Do you have more details ? Like at least the dump of the panic Oops ?

Can it be reproduced on QEMU ?

Christophe

