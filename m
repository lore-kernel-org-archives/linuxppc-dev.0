Return-Path: <linuxppc-dev+bounces-27780-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02E5C982CC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 05:31:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmylf6NBrz30MZ;
	Sat, 19 Sep 2026 15:31:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789795886;
	cv=none; b=UaCrpx/wsR9flKdhA1gCMmRvV16S803d9cqnuFcmqYOdGjhGeOSaPpbBMgqcvRiIy/gkzeasfw2p+Iut2KVEvm+mgxywhYQ659H0TLRRrkeFJKvNYbYCUkJ9R6TmF5htAaDEuMmwhNiXTP8WsfvXGJoAdf1lqGLNYzqEKtG7CCZQls/zMD8mjHqySCQspHwRyqq8OX0/nNI/pW8bfjFe3G5jeTPPFVvI4+BynblotrqaNKRI6pPILHc2HU99wsOKD4bvvPmUsF3dnVlv0F6ifxLLBn4m0xPmLQhMVWN1EcH+g7goL6ososCZaBD+MQw2ZwuVLasMAUU+03i9xlg+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789795886; c=relaxed/relaxed;
	bh=5DogGEaqmhYD22fTJ2ycLzK1jSJrSXPn3ttiHz5f6RU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aatvG/I6qiBA3r0hmPQpp8KlInTbpt8uk+tBZUb1xqgTMYXc/vk9RYax5M2oijnWSvylsiJ6ZKbj5udyVqODiQkVZxzc209TGdb/g36Ym8RwIdzfuzo0CuvGaCNmnC4lqnr50iOOtS4QB/JRopgITlV3l5r3BvCMfH20bZxGDxKfPNh/EQuZ6SO6sB1rDSBXFRtSXmfHTpvkwbpVhYz+/5j5uDfk0b5iQWj3jj+egFwPQJ06tZg481/i7Mqm7JrxQ036r2hgAAVBLAPFCshE4UqDC0qfOBUoGXHF9BnxyKK67oFT+2BAwRLHRb0KJk5pLJNYJyFbtOY1RjofrKoQ6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L5+kOxay; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L5+kOxay;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com [IPv6:2a00:1450:4864:30::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmyld0dTtz30M6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 15:31:24 +1000 (AEST)
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-485ac898fa4so1194760f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 22:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789795880; x=1790400680; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5DogGEaqmhYD22fTJ2ycLzK1jSJrSXPn3ttiHz5f6RU=;
        b=L5+kOxayIWE0AjE8W0mhB/HWZAX4jTyLPNRPhMcY8sxAHPpfoB9bH6uf45PaFa6PYX
         syfvEpiDJypyC901gF6X4m8bU2KxAqAlpHofN2hL/+LO6PEfF0CN3g7xtWm0D0hsRnxb
         cmzTDSAl0FLL+H75s5M6CEnSBlnhc+N0knnF0jzQApdC8asEoqykwN/zEbhX7TQOC/4R
         17Sk6AiRa1++IS7YYtCtNHSysFa/5d94nIkSUU+knmma03pun71SaHeHgEQK48wMJzVI
         fKleD7vJlsZRWwSeDVTc0eEpUGkPbiqMUklLcuwIbmnRgLCSQfpsMJYCjAlry6FAsSUC
         wTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789795880; x=1790400680;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5DogGEaqmhYD22fTJ2ycLzK1jSJrSXPn3ttiHz5f6RU=;
        b=QDavJFKG7T16h5OknMygm7TO7vMzu69JAHGLQ4OObNIcLnr9fpuARdD0HayBUhLTpu
         cOOP3UOog0Wp19u+ACWHyJ2drM8f59Yxx40aXyTVqd5NHXjmDQk8cgnAwl9zastV5Ihh
         cUowcAU4SHMyK4Hj14M4Ww2zTd6i4Dx9/tUx34ivMerxGhP0QqKqxdaq2n4JovbVmJ0u
         5gz/i7b6HcsGJbVXSW3BFGS5ygNH5PN8JZ6ygpBscwN3OQwfXJODR3ClOdMcnsUdaxVu
         gKZt7hv620W4/w6GpN1WKTd/fA2Ca05bt1F495+7w2u4gi6k4zgTZQi/f5tjQJIQHBNi
         m6RQ==
X-Forwarded-Encrypted: i=1; AKwUvBybfsZLF97hWYAXd5SoIdEOREKD7ebcCQfaglB0Ph1cvGWjbg2mdRPRulejHUw/acsX940Zn4tO4rIBV7I=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nfbk3UoSs4qdlDOrYimR3xaXrDZKxEu75qld7+HpYzcHjMIahd
	qB5VtvfmlfWepRfkqnSZ9iDqcMM1Na+pskQL4b1I2RZfkowsRz2W7hZt
X-Gm-Gg: AYBFou3aWEQ3XBA+ZstPv58SZkOtQpRf3WvwKDRotythWAYXBVrqQ+n9dM2W8MBDxeh
	XrqUXvE8OseNKgOHdVeyaPRPeiSbgAV/Npcz/MHX9LSiyGu2csAosI5TuEFWsNzwWi2ENsKs5og
	yXbRmcO8uR211a8qQ+DiSQKHKCvo3urVE7M09zNz4T9cTcisc6ORpHrwdTM2v1VWkfPcjWre7NR
	nN/PVtPuhQfIQLjg0aJm6dHXEw2A+mwzwcFsX4PQbT0LWrEAwfqjwAfsypcKZrc+k0j/D13C/wC
	4q7oYOC4MwzSKob89P3XYLvGEINWnIjYwiuW8OT295uv5w+EAQU38WjQ2Lvv7hLgFJOCtKsrPO/
	QCV015jabdRUJCZzvM1yO+fWfrS6+xYJ279EUzFjwSlBE25dq3m05Qu6eVQ/i1bTEFiWe1gZTtB
	dJ0rzsgqIgh82dyeaSsRMZ1FI0tLiKwYHD4j/0M9/9O/GVQdEzm41gcJutFmfNEYCXLxPag6Quk
	dorRONCdHspvw4FLP3NKZ0KGZ1vDFrFSOj7HJMh4leJtPL+u5uH6KwepZvL3pE2y9WBW6yk8gqd
	+LTQp3XWlmmQAbNlJgZ0e90BwWFP7oFVJIy4uXj/OUqO1MlzlVMGKnPG3lyao6iOVVK8SmkvaIH
	JAw13IgMUAX9dTocLKehRfZ3SCu0=
X-Received: by 2002:a05:6000:186d:b0:485:c240:20f7 with SMTP id ffacd0b85a97d-4871e379cccmr6707033f8f.53.1789795880116;
        Fri, 18 Sep 2026 22:31:20 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872442263fsm4056075f8f.1.2026.09.18.22.31.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Sep 2026 22:31:19 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Rashmica Gupta <rashmica.g@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ABI: Fix powerpc memtrace Kconfig symbol
Date: Sat, 19 Sep 2026 07:31:17 +0200
Message-Id: <20260919053117.26219-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260822081253.86256-1-kmehltretter@gmail.com>
References: <20260822081253.86256-1-kmehltretter@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 22 Aug 2026 10:12:53 +0200, I wrote:
> The memtrace interface is controlled by CONFIG_PPC_MEMTRACE. The
> documented CONFIG_PPC64_HARDWARE_TRACING symbol does not exist.

Friendly ping on this documentation fix. Could you take a look when
you have a chance?

Thanks,
Karl

