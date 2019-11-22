Return-Path: <SRS0=/SLd=ZO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2103C432C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Nov 2019 07:51:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA7D20659
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Nov 2019 07:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="OBHi6fWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA7D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47K7sz1fgnzDqD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Nov 2019 18:51:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47K6GG31t1zDr3F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2019 17:39:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="OBHi6fWU"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47K6GD59YRz9sRX;
 Fri, 22 Nov 2019 17:39:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1574404741;
 bh=G+AmjtFXhWfePPRBroJHra92tzfQkUR5z1klVZslTXI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=OBHi6fWUGgkscxnwYu3sN6qZEfYGLeISY44fRnyp9fQfgtwygzmI5pJNFi9DmBbRa
 TAAu9ao6Zdk6tZguYe4qLAlFyOJ98Cl6P6rmYd2EsUaarnuscoZoupMgyyx5UPyhVg
 /9Qvtp4hrEnSm+iLaJFe2QUplrOCy7Q/g9ygqhAnjcr7qedngrRoR0OltoFh1+XLcd
 BchX66YLkvr2etfENHQf5i4oT8O8yai7wap83o0iBk+kHq52GahIxq4iDauUOrskt1
 8c5fdMm/QWoDraDUGkAdsIq+YVD3gqcWiOjd2tDInkpMe/T4WnapviOlHY8LpoLk3S
 HOudl8UcoMRVQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 4/8] powerpc/vdso32: inline __get_datapage()
In-Reply-To: <874kywbrjv.fsf@mpe.ellerman.id.au>
References: <cover.1572342582.git.christophe.leroy@c-s.fr>
 <9c9fe32df8633e6ba8e670274dc3eef82a1b5a65.1572342582.git.christophe.leroy@c-s.fr>
 <874kywbrjv.fsf@mpe.ellerman.id.au>
Date: Fri, 22 Nov 2019 17:38:57 +1100
Message-ID: <871ru0beke.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> __get_datapage() is only a few instructions to retrieve the
>> address of the page where the kernel stores data to the VDSO.
>>
>> By inlining this function into its users, a bl/blr pair and
>> a mflr/mtlr pair is avoided, plus a few reg moves.
>>
>> The improvement is noticeable (about 55 nsec/call on an 8xx)
>>
>> vdsotest before the patch:
>> gettimeofday:    vdso: 731 nsec/call
>> clock-gettime-realtime-coarse:    vdso: 668 nsec/call
>> clock-gettime-monotonic-coarse:    vdso: 745 nsec/call
>>
>> vdsotest after the patch:
>> gettimeofday:    vdso: 677 nsec/call
>> clock-gettime-realtime-coarse:    vdso: 613 nsec/call
>> clock-gettime-monotonic-coarse:    vdso: 690 nsec/call
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> This doesn't build with gcc 4.6.3:
>
>   /linux/arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:
>   /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:41: Error: unsupported relocation against __kernel_datapage_offset
>   /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:86: Error: unsupported relocation against __kernel_datapage_offset
>   /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:213: Error: unsupported relocation against __kernel_datapage_offset
>   /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:247: Error: unsupported relocation against __kernel_datapage_offset
>   make[4]: *** [arch/powerpc/kernel/vdso32/gettimeofday.o] Error 1

Actually I guess it's binutils, which is v2.22 in this case.

Needed this:

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index 12785f72f17d..0048db347ddf 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -117,7 +117,7 @@ extern struct vdso_data *vdso_data;
 .macro get_datapage ptr, tmp
 	bcl	20, 31, .+4
 	mflr	\ptr
-	addi	\ptr, \ptr, __kernel_datapage_offset - (.-4)
+	addi	\ptr, \ptr, (__kernel_datapage_offset - (.-4))@l
 	lwz	\tmp, 0(\ptr)
 	add	\ptr, \tmp, \ptr
 .endm


cheers
