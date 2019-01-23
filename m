Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357FBC282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:42:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DCD20870
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfGEG3A7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DCD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kzKx5QMZzDqMh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 19:41:57 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kzJ76vvYzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 19:40:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YfGEG3A7"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43kzJ75cP0z8wR7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 19:40:23 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43kzJ74fvpz9sBQ; Wed, 23 Jan 2019 19:40:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YfGEG3A7"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43kzJ66GFMz9s9h
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 19:40:22 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id 64so825354pfr.9
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2019 00:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=PsoXnlnEGk9FT0S49hUaAvoLPz4HNK7/MFI/09Klgvc=;
 b=YfGEG3A73ZnIG0B+jSN3BVLHY6tHhE8gQui+DH7FQrB08wfSucG+GqWFMty6pqH222
 +MIHAecbNd2iH1f1JWNrXy0n8vuAHR+iTo8K9560UKLSM72Yn9wAQ8itNSY3USC4Dg0D
 OuVnw19Pp09um6AN3BuCFrykOv+wtq+dKzZmlPGZvHundBNOuDADHbtmABqFOLNevUF1
 0VSjPgvmwVVQKzwsmahG5c+N/hdj5QaR2nJJkx5lRoW1DprzpizHGM9fFPj74foiYwM/
 2iLVGVwuMLveJ/0L4nxGjeqEvFi3pu4fiX3s+nSPuUfBLmzXpR+/2a6Dsrkz798iSoo6
 s2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=PsoXnlnEGk9FT0S49hUaAvoLPz4HNK7/MFI/09Klgvc=;
 b=EyFXkBGorgz8EvnuKcQBJr4czavaQOhzoXgk70IY+xIpE78jakMw7j42aqU1IAAWvo
 HWfV3HL3SfCBicdLANb9sfUeSr0uNQFK2x7WkUmfU9V6PAg2s2oZUyvA24bFmSICC+hr
 k0VgW4o3KOaRsEQCU5njDFmXPhPDvyTJ1q+JF3rTWtuqKchyYQnG7ClvVr9+mSw4fVjI
 +8A4oNoyJX1TgFnDvapFPUHEHtZisdB/F8VnNUuOc8NvOCVqjoN3vMkhThr/KzVizlzY
 ZNFgLLHslHXj9MRQe+QOn5gItLMR3sTh48bE0vgYIcNPfEY8CvRjb+a1o3o+sAL1UCGY
 1rmA==
X-Gm-Message-State: AJcUukescuSZqNTdMVbHtG5yNlslu8umVC46Y0f6UI/wT0N+xkfSGH2V
 8rsT4F/Dc6bOqm/M+ipBaTlVKSck2IU=
X-Google-Smtp-Source: ALg8bN4SAJiTK53f29PddPZRcGGOWOzCzXxKAHqBGgbpoJN1OsytFr+0lCGNGPbayUKrWiWX0Li1Ug==
X-Received: by 2002:a62:160d:: with SMTP id 13mr1246914pfw.203.1548232821097; 
 Wed, 23 Jan 2019 00:40:21 -0800 (PST)
Received: from localhost (193-116-78-72.tpgi.com.au. [193.116.78.72])
 by smtp.gmail.com with ESMTPSA id n68sm28482720pfb.62.2019.01.23.00.40.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 00:40:20 -0800 (PST)
Date: Wed, 23 Jan 2019 18:40:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/4] powerpc/64s: Support shrinking the SLB for debugging
To: Michael Ellerman <mpe@ellerman.id.au>, Michal =?iso-8859-1?q?Such=E1nek?=
 <msuchanek@suse.de>
References: <20190117121328.13395-1-mpe@ellerman.id.au>
 <20190117121328.13395-4-mpe@ellerman.id.au> <20190119011314.45cb9864@naga>
 <87won12b92.fsf@concordia.ellerman.id.au>
In-Reply-To: <87won12b92.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1548232654.t0vcx3nv0o.astroid@bobo.none>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman's on January 19, 2019 8:27 pm:
> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>=20
>> On Thu, 17 Jan 2019 23:13:28 +1100
>> Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>>> On machines with 1TB segments and a 32-entry SLB it's quite hard to
>>> cause sufficient SLB pressure to trigger bugs caused due to badly
>>> timed SLB faults.
>>>=20
>>> We have seen this in the past and a few years ago added the
>>> disable_1tb_segments command line option to force the use of 256MB
>>> segments. However even this allows some bugs to slip through testing
>>> if the SLB entry in question was recently accessed.
>>>=20
>>> So add a new command line parameter for debugging which shrinks the
>>> SLB to the minimum size we can support. Currently that size is 3, two
>>> bolted SLBs and 1 for dynamic use. This creates the maximal SLB
>>
>> Doesn't this violate the power of 2 requirement stated in 2/4?
>=20
> Yes. Good point. This was originally a hack patch in my tree, back when
> SLB_NUM_BOLTED was 3 and before Nick even added the slb_used_bitmap, so
> back then it was a power of 2 but it also didn't matter :)
>=20
> I think I'll rework the slb_full_bitmap patch anyway and remove the
> power of 2 requirement, so then this patch will be OK.

Thanks, good patch and really will help testing. Sometimes even if you=20
can get enough pressure with the 256MB segments, you actually want to=20
test 1TB segment code paths too.

Thanks,
Nick

=
