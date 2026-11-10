Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37A606A321
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r7vZV54P
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNqVG4lpmz2xf8;
	Tue, 10 Nov 2026 12:55:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::232" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794275718;
	cv=pass; b=a0QTRrQfDmDHYrM7ZgrwWT23Egd7ze0QuowFeJDVB16wP3eVx82to+/JkZUenttqki7oyn0rlnwGS9KsXbSDzV3z+RPj92M107sBNZWE1Ht4ib3nWDagu7kwky5e/XAG6Akq2iLnixD7wgIQZ9W6VU50J7aD/nfCyp3N7b+5Aqs4BpQcW5V2omMjPcxrJ2Ff3rWS4D5DqQ+NO5DgO5MBSAidfOOK1GbyXm+AJ9nQxsBEP4I3UjVk5fvDW1U02NELDp01P5aPAbhE9A4aflk8XRet4gQNtTf72uS/hmYsjNHvpbMxEJ54OQj7ghmJtVhkkgPkqRtiNmnHatcj12mk0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794275718; c=relaxed/relaxed;
	bh=G5v/GahrKojuLMd/w2vG8qQQPrMEg6DWG54+887I7N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mL8FHKXQXIPrtIn8tY1UQdg0DBd2PKvb1p8rTtjiqL0C3/e9JM12tb07fA0hOmvHdj+ZG25tAvK2Osj3v+kvZTGYzDqypLFY1E27MEHi4m+tevCqVpipAZop3kO6H2R7Ee6Ua1J7DeyuLkoEdtMvkCGFtISEY3Mnn2FZfdCTq2V2XVUjs5JxmgB8B2x18rle4jA6HP1eN1MDKLB0Di0RgtYDOMKc9QkBulkMby4VzMH4y5xxQYGqsr1859d6MZ/I5/HKpcfwkG5b6P5UjUAYr3GlXPDg4O4KAgcgr5rUqhDlkIOw5/GrpTDRmWJuxO/bJQNUSworUrcQjhN5f60tcg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r7vZV54P; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::232; helo=mail-lj1-x232.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r7vZV54P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::232; helo=mail-lj1-x232.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNqVF1cLpz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 12:55:16 +1100 (AEDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-3ad5529ae64so12473091fa.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:55:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794275712; cv=none;
        d=google.com; s=arc-20260327;
        b=j75GH+3lLprcgoddLkkmHai4HrfxfpyNCBTxGrpRhqSP7TL4dgWDAeN9tBlLPwEd2Y
         iAP3+8O8Vth+91/ZIkjFtyv4GprAlKKX9uLde9Aq8XhSCJIiBrhy8E/LAx1z9HbNQgqr
         oh+XWaWuBjOkpRJMFX/JlJHOLFzBE88p065F4JTuruTNYNKuIwdO0JRABQ7p9nCJ+8WG
         4GJiKFaMLZgjGxtz8B1DGt0gfKlYghmD0ytooY+oSnZUjgpiQbYGAvjcgQpI4UZQCEs1
         lflgPmFuRAncQwaHSd1cgURhJ8Q91WAXAcj0HY293zIyGgsp/9CQG7sYyQbZelZpqmRk
         YofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G5v/GahrKojuLMd/w2vG8qQQPrMEg6DWG54+887I7N8=;
        fh=ZtLm5ALfMt5s18t+VqId4QpOhAT5+hZzxxeI8eFD+yA=;
        b=Yd9UByDryp83rE6wWePR+lsfzVR7YYEBim54OvkQiJkxpzhgLF6ixJQGEspU4/sObN
         vNVZHTuS5Xm9zQa9U6tzNqHoyPj7hfgIF8WhQjxvpv5gJiHDzWW4jZTYhfx5xpRI2c6N
         ZjonVHUL5knfRGRUloNFfMv/MlbymS9wMVi0HG6H2iKiuDL8YFUPXwaBNzxNXaMJEZpS
         EbJJjNHwozxTW3jc3rroa++PIdQkGhoHbn0ZtM46vklSwwmkmwszSN4UHfI5yprIGyrQ
         DPRBCBeAypvlWwp7qOCg8gDSFyCk+uXL/8KnH1Tz6uKoQQCIukVzEFZUX/56lI9BYxGj
         r8HQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275712; x=1794880512; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G5v/GahrKojuLMd/w2vG8qQQPrMEg6DWG54+887I7N8=;
        b=r7vZV54PNlRoZ9VNIxE1sqpg7JhkuaFNzU/z+oSlhd6athvnuE2bCnGMpTD2IPGKsk
         PMMeHB07u7PYCZE8Pj1jB/T41O9H0D/zJWVikdcwbAV96HZQhkuzDkE7EsYT8JnwlmYl
         W5NniT7aAJKXg+QLGnboOk5as1Px4+L0tKREWVHGaftULi7K9KEmb/UgT35k6meVm/sH
         Ise7+WK4Co8HTuItissmAeSvcifhz5/5XJcDj7UBzH9wCfevgmupmqssEykfEBzvvyQ6
         Q0z3x165FFPfzYCAfTI8UZHxIYZd7Ot6tCb+uccnVOmNo0Gz2p4XSau+gCwOtzUoRP+u
         tT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275712; x=1794880512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G5v/GahrKojuLMd/w2vG8qQQPrMEg6DWG54+887I7N8=;
        b=Z7jKmhB39jmxGy1F2oATJRclFLzRUbnDRPUtmIGkGeul7ppk/RCJkrq+pEasF2lAZ/
         Kb8LMB8DIJ9lXvhtUI5P0SmgI3lZMLp2GXOhtzqRpvWFiP77jjT/or9vBASYk3GJkPvc
         Oo8M5QOqaGT2829w90hsqWY26wRumYWRX852XC0TQD9q/Q0Vh5B72o1QDdlPEkXBLZ0E
         IIZ68JbvKSPTd5Xb/+VHqO5qwnSO+hrTrgWquM6zoal/yAEfRCDrf888buCXYbIeaP9u
         9aBjPpc0K7hQ4wl/SMfJ9KgrUNlDq3LtZwnYlxoXLrEzwfU6TE+CPWS3VzcnBUcWZcZl
         EIEw==
X-Gm-Message-State: APuU4Z/aQHnRqDFJL6y79ON0fPrZkACh6EdcY3YZZanfRzWAB4jbl4OD
	cgZghoaW9tgOjHGAi/4LCkNmH3Hiv1l2myuK4DYNRTKvEzJNkWkO5rXtFCKBWb0iFr5HTyc2drC
	7xt9YZkM+Rz0jArr+Cxev7pmS8Dgx2Jg=
X-Gm-Gg: AYBFou1Zrz4ABsgyHtVx6P+8yybPvN3rYUXqxe1cP1u2RhyOFHQu6Fw+b5zYofi/RKU
	xEOkHfmM+PMmldeCne6bSQh66jvYqxaonOBKH4P8/difIUUJeAXjE68WCDfycZ6k1WFxzH35zNs
	ly0E1qtD5QY3gSVV0TdOaRoOZyaqC+5fq7akvUyAqjMUakCjOlMcon4AzdBcJxBgiCygttKfWD6
	S8UnyAQpUwLZvtfH/QzdZBKfsZ+4YCysNK5HgHE/IlusIaqIrKi9fxd/SA7vGAjgaqdsKLJNExn
	dMPfQ5nJRtJG8cD1FfWO9wXFZJGgZwXu1V10iTtYeL/zTw0T1ARllYiUpB4y3Cs/Bhyxf0L9J9Z
	a59SEuOA9KAi5ftwV2mfnSY1vdIkjX512Jqcwz76HcwEyotckQvsCxMFN2EJ0CT/js/TaXSMJQ8
	WZavv8C85/G3b8VkrHi7paOBhT0VLk0UjYC08SY8eq0hBoZfXuxe2YZ1PXiez/lhJq0lfhfpbEG
	g==
X-Received: by 2002:a2e:b8c2:0:b0:3ac:4254:fcb1 with SMTP id
 38308e7fff4ca-3ae09633214mr1864321fa.19.1794275712122; Mon, 09 Nov 2026
 17:55:12 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
In-Reply-To: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 9 Nov 2026 20:55:00 -0500
X-Gm-Features: AclHuK9XZ_iCium8ga9JJqtZmOHBmRJQJF3JqmfXysKknLs9C_kzNDlkn5w123A
Message-ID: <CAEdQ38F7kRjLJE_yZe2r+6U8W5PAs0xB+0-AkXAGdy4LHWyGwA@mail.gmail.com>
Subject: Re: [PATCH 0/8] powerpc/perf: mpc7450: Event fixes, SIAR sampling and
 sysfs event names
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 8:47=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
> Tested on an iMac G4 (MPC7448).  The 7448 has no L3, so patch 5 and the
> L3 half of patch 8 are untested.

I should probably mention that it's an iMac G4 with an upgraded CPU:
https://mattst88.com/computers/imacg4/

