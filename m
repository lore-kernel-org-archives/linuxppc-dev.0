Return-Path: <linuxppc-dev+bounces-25423-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C443C55822
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:34:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFQGX1ryzz2y8c;
	Wed, 05 Aug 2026 19:34:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785922452;
	cv=pass; b=EuCBbUXrka4/M//2ljuRuM8kYh3HVmkYAFeGcuAEvNHjHJiqsqChpal4d/nLnTjNAaJGybiIeSxsTXB5VTbujl5QxOyz7WU5AnoqwdlznknMC6HMpuWjuPLUq1ev8VCHNx7n0aTp/7q1jIAHpQPlIdcQB7yxKyJrv7Ibxswx0gPLpeHUk5HXm6/+861zxQtuC32TIWIRMhpQEQ4Q9q7r/eyvBXCOdigYbU7Gx87yCCkugqrGNYX5QHojWrm74fsdkE3uDZ/3oF/ARla3NKmgkBNpFOdDPejScSLbMyLIlDjNlSUhlew6lSBFDKLPcZ7+T2u3OR2MDrhqy8KP4RvAXQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785922452; c=relaxed/relaxed;
	bh=UaGNs+E1Ex6iz5T9/0x/HPxcs/WYGeua7JSZh/+RxWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1707ctAvIsvldyMYCMnfTqZ64PW5HX5W6Pp67WKQHaizrut5Yq3in4lL4tSb22CSL83YmguBrg1ASLGMbnuNnw6kVMOiuj9c79BzDvrs3WAqXCqrisUGJmMuio+tnVxwcR4Hk3xGnBHFQBUt5JflLnajeGNQapwGUtLoyJpZyYB8dRmdrO+VG4uuZrKXQCUDtJgvd2ldk6mCJOjsCWIKa+4OkSEh7a0OJE9Xu2kwynw6MlICjpqbf/XWhkxjx77KvljjrkAnoNX1Mn3miynPcz20zJW/nUOjOV1bTwaR6JQzeTSx6VIyXPoi6mULDS5rDIaqt4ocZviJZmnh8anhg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qMO1MQPh; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qMO1MQPh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFQGW2Vdnz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 19:34:11 +1000 (AEST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so1169135a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 02:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785922448; cv=none;
        d=google.com; s=arc-20260327;
        b=WK8BLxx8/52Rhtiq2MGupwb7JpZ17b4mzUxagk0ux7tasX47RgjMDaSEpUNTvvwzkD
         aWs9Wpg/yDHTGSx8OGefHQuEnfaeFGavfZJ5W4msXWritBaFT8lUgp94xj6rfkGTTkis
         5R9js3PZp8wiy8IyGRjXqRLvRInTea9DPEfq4xr4iQRkfnf5sQY2ONKfQxaOHl47/fJn
         31A+fnTtrZ+fVRwlpVk732GwwGQeDTe1nFc4Cp7XcVGJqu2KHS0PwWuLTUYFVM+rkaIZ
         ngps3m1RSfX5ftmkeiRQp0oMDTxUx9vOTbtDQ3QfkPIWxykSwtoaEVHyXlqeY9wwz5oD
         l+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UaGNs+E1Ex6iz5T9/0x/HPxcs/WYGeua7JSZh/+RxWI=;
        fh=rLGsZ+LuLrjrJcVBLbKz3SOjBKDQL1Iag+/coaDe3ws=;
        b=I94SBDuYDIw6+el0j8nH3u3Q6b9FuyC8sn1G9HU3htFjCGJnZz9RHlAVnidSvcILEr
         zaNdZydpyvk9pwrv5EctlPWNJ/ly3udeJub4Bo0najBviLckv55RIJrNGzETr75Gmieh
         koy4N+PZLTRaZ0EILLZVdU4f6wqnCazaYaW9Cau3+7xsMPosSEhAjk8EP2LRv7ktr1t9
         sRwA/tqngI59oHVgDHJiie4uNqXlSOZgxNXgwySPMwSny2eonF0IOP4LRk07ZvBsFJ6m
         ogmq2Cim8qNCLG2YcrHKcZpnMQBu7zru4ORMye6CnHRCFO3eQNUHgvK4w8vMHxYWrk7G
         RG5A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785922448; x=1786527248; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UaGNs+E1Ex6iz5T9/0x/HPxcs/WYGeua7JSZh/+RxWI=;
        b=qMO1MQPhwu7aAwJ6JnhHE2NRLE0rThlluywMoLHbKGT9OHIOiBjbqKYI1Qj9LiICtq
         KWq3RxIsH63yuwJiAjp2N7cqvV9MxEGRtzs75+xkP1BrVgKg9Lbg0bpgylbIiuhkPe3F
         k/xP54KiGgDvSYgQx/L59dLEwBoJmR2QHSQm0XmJpEwniSuRaEDqbUD0ggotxRc0lzT4
         T2/OF+Tea/Ihmz7/lsdNCSR3FKMROD3SaiQFA5RZCVMerlSTx33uRkCmjJo+UOl786+c
         JFKffIS2Xr/lrCHKtr06Hv0jDlLNZFDBjwNhyLCC65Gkg3greBrayAR18OeiCcnFN8ar
         cYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785922448; x=1786527248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaGNs+E1Ex6iz5T9/0x/HPxcs/WYGeua7JSZh/+RxWI=;
        b=I3L9PQupl5nodU/yYcY3X5ENKwRHlysQTKosdaoHEF4DKiYHJ5VddXMZcCiBoK9ph8
         Zo4euTTC12txE95aJo8j2Cj7YGGxf9OoGHfnfemAwllVL0UGadDIF3bDzR6+qasizvbM
         J3XMaJeYDUVMzmU+W+RsEvlEZcZmGMgBNA1OWBotQCyrIKfppPJU9zL9O6p65QoAgGVP
         ZD3gzVO2GLbfhl787nVYEjkJ7ZuGOFod9u/xERhgQgacIPtkOF0gpyTJB+uDdxTnUGag
         PWNEGns0iHy0ZArQhmP1wPR7OTC2BE6R90Bsvrq7MhG/RrMCMaFlKMlvrbKkxbTMw4Yw
         Tc7A==
X-Forwarded-Encrypted: i=1; AHgh+RoapNEOSAWztW0eIQf3oymC/3c5Obn1xgtD2BadVkoLyqOe1jAu2dcf6AMdQh4UmZXGe2qArNBogmmJai4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxdWA8iCdOzpVKffsqMZxXQp3EvOXVX9UuiuczjBYjDgUbeMGPL
	eSZ168oUz2b4x8ao2EnK1Qt0e8KAVkS1vTsm/mG2n1WeffpSPRUa6Ri9NFkNL1fEDjOED+IiO/8
	vkx2nHtJDxtb3sbOrGP+sbieEEu2poro=
X-Gm-Gg: AR+sD10sby6jJpsmwYpTuTk2ccpHrxc6H9oYWApZkq6eCQPq38Ljdv2wRp6R8Kak+/4
	O5kzs5Eu86jd3ETRchc/pqOs0X+LRAS7LN9QQujU2c/tL3WdfblhyTrdaOrc6kC6zILM1Ycopne
	I2TA82pImsO99iQ4dlx8ZlMBgj0XOqQGNfB8eKIQ2PfT6iPkxDIKMdh1ezVJjRImUGo6do9beNF
	WrxIQIUONS2NpxN+FHC+UQWrkfa4yLnAc5rLVkAJrC4f1sKLPvN6g/CJ7CIZphTFr1NX/5leH/z
	6/a3cf7InGR1ClJe4NbiD51pOTLENWO/22iCGbjw0vlNTuQMt7wRkuN6limVTlb9guvTKIDy8W1
	3heJXdquv5fuc9k5VnOZi8LxQdI7iXzk=
X-Received: by 2002:a05:6402:1f08:b0:6a1:b0b:ba6 with SMTP id
 4fb4d7f45d1cf-6a14f13e482mr2509895a12.15.1785922446933; Wed, 05 Aug 2026
 02:34:06 -0700 (PDT)
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
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com> <20260803-alpha-fp-exceptions-v1-2-c99d75608e60@gmail.com>
In-Reply-To: <20260803-alpha-fp-exceptions-v1-2-c99d75608e60@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 5 Aug 2026 11:33:54 +0200
X-Gm-Features: AUfX_mwnXqPqc_k9xGwWzJEiKBh4lXhngC_jeS43aqM9K90q-yJsxGFkXMu1yFY
Message-ID: <CA+=Fv5Tgq7X6Tqt2s6OuoWUQirzYwwyrmwQR_tDXpHRrczK22A@mail.gmail.com>
Subject: Re: [PATCH 2/3] alpha: don't leak hardware-fabricated FP exception
 bits to user space
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:40=E2=80=AFAM Matt Turner <mattst88@gmail.com> wro=
te:
>
> On EV6 and later the hardware records exception status bits in the FPCR
> before delivering a software completion trap, and those bits can be wrong
> for the instruction that trapped.  Converting a double that is exactly
> representable as a subnormal float sets FPCR_UNF even though the result
> is exact, and an underflow trap additionally sets FPCR_INE even when the
> emulated operation turns out to be exact.
>
> alpha_fp_emul() only wrote the FPCR when soft-fp raised an exception, so
> whenever it determined that the instruction was exact the fabricated bits
> stayed in the FPCR and were reported to user space by fetestexcept().
>
> Pass the exception summary register down from do_entArith() so the
> handler can tell which exceptions the hardware attributed to the trapping
> instruction, and always write the FPCR.  Clear the exceptions that the
> trap reported but that soft-fp did not raise.  EXC_SUM reports only the
> underflow or overflow when the hardware also set INE, so treat INE as a
> candidate in that case, and treat a trap with no reported exception as a
> denormal operand trap, for which the hardware can fabricate INE and UNF
> as well.  Bits that software has already confirmed in ieee_state belong
> to this or an earlier instruction and are never cleared.
>
> The imprecise path passes no summary.  There the trap was taken somewhere
> in the trap shadow, so EXC_SUM is not attribution for the instruction
> being re-executed -- and only EV6, which traps precisely and so never
> takes that path, has fabricated bits to clear.  For the same reason the
> clearing is guarded by implver(), matching swcr_update_status().
>
> On an UP1500 (EV68) this takes the glibc math testsuite from 831 failures
> to 28, the remainder being unrelated to exception status.
>
> This belongs with the preceding fix to ieee_swcr_to_fpcr(), and should
> not be backported without it -- nor it without this.  That fix stops
> FPCR_DNOD being set unconditionally, so denormal operand traps start
> firing again.  Those traps very often find an exact result, which is
> precisely the case where the old code left the FPCR unwritten and the
> fabricated bits visible.  Applied alone it would make spurious exception
> flags more common, not less.
>
> One case cannot be resolved here: an inexact instruction without the
> software completion suffix never traps, so its INE reaches the FPCR
> without being recorded anywhere else.  Such a bit is indistinguishable
> from an INE the hardware fabricated for a trapping instruction, and is
> lost if an underflow or overflow trap with an exact result follows it.
> The FPCR is the only record of those instructions and it carries no
> attribution.
>
> The bug predates the git history, so there is no commit to reference in a
> Fixes tag.
>
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/traps.c  |  6 ++--
>  arch/alpha/math-emu/math.c | 88 ++++++++++++++++++++++++++++++++++++++++=
------
>  2 files changed, 80 insertions(+), 14 deletions(-)
>
Hi,

Passing EXC_SUM to the precise emulation path and always writing the
corrected FPCR state back looks correct to me.

I tested the complete series with CONFIG_MATHEMU=3Dy on the same machine
and using the same glibc build. The kernel boots normally, and the
glibc math testsuite improves from 48 to 28 failing test programs, with
no new failing tests. Tested on Alphaserver ES40.

Reviewed-by: Magnus Lindholm linmag7@gmail.com
Tested-by: Magnus Lindholm linmag7@gmail.com

