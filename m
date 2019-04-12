Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B2C282CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 03:37:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F66621850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 03:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJbXtjl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F66621850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gNrP0PxvzDqG9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 13:37:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WJbXtjl2"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gNpX0YlYzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 13:36:03 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id i2so4481295pgj.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 20:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=1CNl6nv+LYJu75Ky1I0+QQJDqQIqrPEuDkpznrkLBe8=;
 b=WJbXtjl2u0VJ1/VnfHKxpKz0L6195TGM8eQkwsU3Dk+8/Dv4Fbp/TiLgV6S3coo9Kk
 WehSEzwrTY2OUkopZALGw5dnKhXhgN6yh231XRDA87G9X+aphyN5MGAotYZH9TOx8EmW
 vejaQJqANreQOdueWxM4fjhoeRlb8HORU9rYeYtrA4V1XNvfgqTdv+TFTef3VTLWwA97
 gq5+RWrZdZ1m43Ze8j6hPM48vIAF3HEByyWdJeoGzuenvihQuY/5p6Yj0xV16gb4bzax
 tl4nElkFtKafo3hEGfuzQ8NOvI6DWxLDN7Z6CLUqt3x1XPHEFPlFyIFr7fE6/zS0VAoN
 0cKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=1CNl6nv+LYJu75Ky1I0+QQJDqQIqrPEuDkpznrkLBe8=;
 b=C3OCtqPRh5F+PVjoVE/F56E6osWksKQkEm+Y+nha9DYz//XNldb0h8SlxznLdZgnPX
 X+QAuLf8SnUZobt6u4obme4VaylzKcd9AUeNCIvdSt2txWpNQXyvaLtqNlOrcD79G+B6
 l1BX77Qh6qNR2HCsbm1tGuqn43CTyeAVgL2VwmeItErwr4HW5ey4vy38GG8AtoDFrOJr
 Y4+MsfUu8LUKlAuEFJRpn0xdh7gDn5KlotpDksWYuBLNWjOuwEEusg8L+fnh8IpmwpTI
 HP6mYgWirFWam4gy7kCbWMZxCIDvLA8cl5q37OAcXjyMjxbdS/lXq8NQ2ThNf3Td2XeK
 HyqA==
X-Gm-Message-State: APjAAAUyVBzRtrt77Yt6NZ2IAtAXLVKLBLIBWcSEDDr0xG2HzCyx3kSR
 kfBGna2YtqduX/lAc5ao9nMV3K/nxtY=
X-Google-Smtp-Source: APXvYqzijfXd78Ofg58oLewIlcrESwyPZzyzXXmt6VdaIaMB4PAX2OMGlcwmNRUN9Rx6URWkXTXp4w==
X-Received: by 2002:a65:6259:: with SMTP id q25mr51019342pgv.103.1555040161506; 
 Thu, 11 Apr 2019 20:36:01 -0700 (PDT)
Received: from localhost (115-64-237-195.tpgi.com.au. [115.64.237.195])
 by smtp.gmail.com with ESMTPSA id q75sm20798510pfi.102.2019.04.11.20.35.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 11 Apr 2019 20:36:00 -0700 (PDT)
Date: Fri, 12 Apr 2019 13:35:53 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s/radix: Fix radix segment exception handling
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman
 <patch-notifications@ellerman.id.au>
References: <44fRrx4BVsz9s70@ozlabs.org>
In-Reply-To: <44fRrx4BVsz9s70@ozlabs.org>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555040097.sqg9j51don.astroid@bobo.none>
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman's on April 11, 2019 12:49 am:
> On Fri, 2019-03-29 at 07:42:57 UTC, Nicholas Piggin wrote:
>> Commit 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
>> broke the radix-mode segment exception handler. In radix mode, this is
>> exception is not an SLB miss, rather it signals that the EA is outside
>> the range translated by any page table.
>>=20
>> The commit lost the radix feature alternate code patch, which can
>> cause faults to some EAs to kernel BUG at arch/powerpc/mm/slb.c:639!
>>=20
>> The original radix code would send faults to slb_miss_large_addr,
>> which would end up faulting due to slb_addr_limit being 0. This patch
>> sends radix directly to do_bad_slb_fault, which is a bit clearer.
>>=20
>> Fixes: 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Reported-by: Anton Blanchard <anton@samba.org>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>=20
> Applied to powerpc fixes, thanks.
>=20
> https://git.kernel.org/powerpc/c/7100e8704b61247649c50551b965e71d

I sent a v2 with a selftests that triggers the crash if you want it.
Code was unchanged to no big deal there.

Thanks,
Nick

=
