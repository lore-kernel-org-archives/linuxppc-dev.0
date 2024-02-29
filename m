Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364A4C48BF6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Feb 2024 22:19:19 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=TdZdV25G;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tm5H96DdVz3vYm
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2024 09:19:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=TdZdV25G;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tm5GD3DL2z3bpt
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2024 09:18:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709245106;
	bh=ZyKv++aJiuu8o2meINckWe/fNHNwmW9QZnQAcfucrtA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TdZdV25GOGIxNvmPRgEgVd1/hFZPHZTbM9fynaVKxpY15kAXgMlX25tiZ6g2rwlRm
	 9VZ8zYFiIxHc11oIvW2I0cJLN5RbOA7Zu5K3RCm/lnKtow2mWzX3TB+LwdeyVyjnSE
	 eF1/67guak1yDp2mEgbJcJyfW73iUW2leTkku5PNdv1O/IjXQ7MhM+190bnlvrrHzP
	 TA/cqJibOmeagz3kB/2cwZptOSLHbj6UZJWYDFjoLwPncPxHiarS4ksuxikyZup+ae
	 TjbZ6+0c8DgyYuZPdXsGEzwfV9LgL+EU4qLz9D0olJEknmRodIv0eZZKdcrkWAqedc
	 BDZcIt9zu+xOg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tm5GB3z7kz4wc6;
	Fri,  1 Mar 2024 09:18:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sachin Sant <sachinp@linux.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [kselftests/powerpc] Primitives test build failure with linux-next
In-Reply-To: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
References: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
Date: Fri, 01 Mar 2024 09:18:22 +1100
Message-ID: <87o7bygbip.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: tanzhasanwork@gmail.com, andy.shevchenko@gmail.com, linux-kselftest@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sachin Sant <sachinp@linux.ibm.com> writes:
> Powerpc specific selftests (specifically powerpc/primitives) included in linux-next
> tree fails to build with following error
>
> gcc -std=gnu99 -O2 -Wall -Werror -DGIT_VERSION='"next-20240229-0-gf303a3e2bcfb-dirty"' -I/home/sachin/linux-next/tools/testing/selftests/powerpc/include  -I/home/sachin/linux-next/tools/testing/selftests/powerpc/primitives    load_unaligned_zeropad.c ../harness.c  -o /home/sachin/linux-next/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad
> In file included from load_unaligned_zeropad.c:26:
> word-at-a-time.h:7:10: fatal error: linux/bitops.h: No such file or directory
>     7 | #include <linux/bitops.h>
>       |          ^~~~~~~~~~~~~~~~
> compilation terminated.
>
> The header file in question was last changed by following commit
>
> commit 66a5c40f60f5d88ad8d47ba6a4ba05892853fa1f
>     kernel.h: removed REPEAT_BYTE from kernel.h

Patch below should fix it, can you please confirm?

cheers


From f165de102de33704a54b892b689630bfa9a79132 Mon Sep 17 00:00:00 2001
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 1 Mar 2024 09:16:31 +1100
Subject: [PATCH] Fix word-at-a-time test failure

---
 tools/testing/selftests/powerpc/primitives/linux/bitops.h   | 0
 tools/testing/selftests/powerpc/primitives/linux/wordpart.h | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/powerpc/primitives/linux/bitops.h
 create mode 120000 tools/testing/selftests/powerpc/primitives/linux/wordpart.h

diff --git a/tools/testing/selftests/powerpc/primitives/linux/bitops.h b/tools/testing/selftests/powerpc/primitives/linux/bitops.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/selftests/powerpc/primitives/linux/wordpart.h b/tools/testing/selftests/powerpc/primitives/linux/wordpart.h
new file mode 120000
index 000000000000..4a74d2cbbc9b
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/linux/wordpart.h
@@ -0,0 +1 @@
+../../../../../../include/linux/wordpart.h
\ No newline at end of file
-- 
2.43.0

