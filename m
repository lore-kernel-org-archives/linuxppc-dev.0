Return-Path: <linuxppc-dev+bounces-22970-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCF7CDB47F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 08:43:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmC4h5SW8z2yVd;
	Thu, 25 Jun 2026 18:43:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782376996;
	cv=none; b=Ms7SIKch2W9Cp65fE75I1Ot/1nCS4j14SKwybb0t/Z1Se9bQFc69RRCcKdsZlmeqInZlZQ86uOWOKq3b1uUx7NnYBgJh2QYbApShwVbKMJxiZVBLt7T7vp6W3mqxOPdblGzL1JvyppbwerqE1jVPQYEBXWLlmO79bRp5JK4N8Thiewi91BKVoY9jji3VSig7rasoQYVRQm+IPefZ/IY0w0AFZaiSclON8OeRaXMVbKNPG73icdgrSsqkkBv1YBHj9YbKR0TYRBkaplwsXGyoBrwIOQEnyOiqnmbutM1i08y2AUrAoN7bMZyiLI5hH8vtzhuWgZktahAAoWtx45aaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782376996; c=relaxed/relaxed;
	bh=zi6eBDm5sANG53Lk4H1dKRXyOtd8pYTyT3lnbd6gLw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlVluvzgj1URuX+EPuXe0vDkJuMGRkuF0PEFTOdKiMCJV+2+cPxHF+shqAf+22h9myJiVgcSIyB0qX00wdaP2O8Ji+Ah56kto0R+sJ1hnhmTFcsFC7r4t6b9d0c0uwHwSMQZFGz+hH0jVu9qeq79wBkwrcPno7tar9+dIJAgFpffjuo9ynTJ3SqCLIxEjTd9evob/SzMaS0hgMb6yMaiNbWBi0BUyQAksxcUKvqvdKQkHZGvXMGPlphqHymg5WSiHyswKNMjC19Ap8Vi7SW2xhU+P/CTUcfI0n6HNEiVSLnM7lNgdDgj6EGBfFmDxrw5c3l/qKp60ZHMXYV6js5puw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iYMzqmEu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iYMzqmEu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmC4g31DZz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 18:43:14 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c89636920a3so808467a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376991; x=1782981791; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zi6eBDm5sANG53Lk4H1dKRXyOtd8pYTyT3lnbd6gLw8=;
        b=iYMzqmEuxi4+lWj8QKREgIUNTQfC6svVqZmav8gfpOy2e9jt1i7DuodcoiSgRnx4HN
         EsWasGaPlWMEesd1DwoqBnyEu52+EVqutbUCCzKzrM2z2zJ68iSCEjnF4vWX+ZZX7hAy
         hbcFqLOCUpg0dVE0P3BUYB+RzJjnr/aRsSJEphoJ3+8OlCmfEQ3FLvrGS0mtQm12DCNn
         IQOZmfbtq3/d5nTCBBLoxLbM87m8gNqbxlN4N8e660v2Gzg/DoYV6pVZqHyh30r9aYis
         BPYvYDi5IXpWNEIn5YnWsSn0OPeOXgN7amSiK79dl0E9uFadkFOzW9oDNVx/OOyeKu+n
         BYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376991; x=1782981791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zi6eBDm5sANG53Lk4H1dKRXyOtd8pYTyT3lnbd6gLw8=;
        b=XAHC+It4LvlbmLYZl63VyELX57IBwWo5r3x2l719c6hAx0rS/ydglDFMi0K4lmUGcf
         nAIpZdPNewDn4MZkg5o15OslmkLAVHHdrCrQgumA9dDITF33mBmjlyMu/mfc9Yq5xWWl
         mEBKBOEkFJAX/RJ3mlyeZUlqYjruCUuAyAvXkXFtpHrSVHlvKO4+vXiLpcaYjxKyn1Y8
         xdT3ABHFOqE/uLbttuo3olqBBa5vvCmhmsVQKZPJONomHvvhA1c9O3FntII/xqUDLIBv
         /5Ye8ABdShMEAHUddSWh6TIAxn6ZGJjhOMxQb0zXutuHLRiMyiLzD+YFisjUfoJZ3fwf
         MDKA==
X-Forwarded-Encrypted: i=1; AHgh+RpSuPIKzk80S9uymIQ0iZ9YxLCLF1hyL8XJ6hY489M4quAlOB1J4TWkUGjYp5U2OeZNpjroI8UWCnSvgdY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwkL04dhUdK1ePaPWl97UImx0jxRg9bw6vj/0MTsRUqU2DunvLM
	PlKSibUmHHbdBTUfUiFEfkoEty9mqqG0791pye01vax8LbnPXJzhH+9j
X-Gm-Gg: AfdE7ckmLDywJqhma42fTnMKnczdFXLd4EnmRYomiDmQVtHcmvO8IEfNEuNVdP+xhsK
	MP2Uhrgpgahu0BcFtSNWPeB1aavg0mxNkMSluWbCyoWRTLbGPnGnz2BB1N/KoNip5B6yLpfrAfJ
	bVFHIypyZPpnD8K7QXGKYoZCE/978gyi838t3s+e9dbciHa/i8nlqzx9syrEQ5Bi9TDv5rmRcHe
	3mo2t4phBTTf1CYBukIbu1fcyy/URGR09LTvPoFIiXVJBv18z5sFcnecFb4DjZTD0vT2E2pEvv8
	f9UPk5wKatTKVwkfrFOXGSC2YJeKMIaZrQh/lG3rqMMpzKbdHhZlp3WmuFO+WavjUOsbs/qP6VV
	qsPGMKPyWJKvt7pnuy4SG0sK+8URJtr4srX3NAhxlZLpQ8efDEjGEjN34E7BFgqdE/sU3gcqwc0
	TxRwwdIy2sdwDUit7i4XiP64SqBAyk7aaDEQ9CK+BnFhI++yE8RB8/+MgH
X-Received: by 2002:a17:902:d489:b0:2c1:ee75:56bb with SMTP id d9443c01a7336-2c7fc9c0ce5mr17433845ad.20.1782376991304;
        Thu, 25 Jun 2026 01:43:11 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac862bsm15598035ad.16.2026.06.25.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:43:11 -0700 (PDT)
Date: Thu, 25 Jun 2026 14:13:06 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/serial: Fix include guard comment
Message-ID: <ajzp3B115iZLOaht@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260623153825.403819-2-thorsten.blum@linux.dev>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623153825.403819-2-thorsten.blum@linux.dev>

On Tue, Jun 23, 2026 at 05:38:25PM +0200, Thorsten Blum wrote:
> Replace _PPC64_SERIAL_H with _ASM_POWERPC_SERIAL_H to match the actual
> macro name. Remove an empty comment while at it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/include/asm/serial.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/serial.h b/arch/powerpc/include/asm/serial.h
> index cd6c18d0e66e..c3eb4a64b3f5 100644
> --- a/arch/powerpc/include/asm/serial.h
> +++ b/arch/powerpc/include/asm/serial.h
> @@ -1,6 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - */
>  #ifndef _ASM_POWERPC_SERIAL_H
>  #define _ASM_POWERPC_SERIAL_H
>  
> @@ -18,4 +16,4 @@ extern void find_legacy_serial_ports(void);
>  #define find_legacy_serial_ports()	do { } while (0)
>  #endif
>  
> -#endif /* _PPC64_SERIAL_H */
> +#endif /* _ASM_POWERPC_SERIAL_H */

LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

