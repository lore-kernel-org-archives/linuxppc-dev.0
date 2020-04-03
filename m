Return-Path: <SRS0=ATRk=5T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FB9C43331
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 10:39:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9676A20737
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 10:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR4m9yy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9676A20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48txHj57jgzDrCG
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 21:38:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=qR4m9yy6; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48txCX2j0yzDrFF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2020 21:35:20 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id h11so2535685plr.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2020 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=QEJZpmtGOLUIXKbwFVGJwPqnPf8yqJs4ed+S6FFnMI4=;
 b=qR4m9yy6EZ7wexeVeZwcXwga/aEy122OCibCdawIEWzS7T8nEFaQwDk8XvYDyqPL+F
 oiJdvJgl5zAQkRIOtS5mkq5y9bhJ+fIw2I3uIHWJ64OLXopmaGZ3gwKCYq+j1CmIb/1l
 RspPc+74xIibveIL5pY812fZ/ugaFZ5RhDQwiS0ISNCy7kLgpKK5jQ7XjKFokk0AeXZ0
 p/44Kse14im0CNWFD2TIOF9WJFliOkHDdIXLWB0Yl3vzMGRH70Q90PWXGwhk6DF4Mik2
 WihowWXTQ3B1o0uNz9hwdkAHFWYhLs2KM+7t9jvh/CQaDh5v0AHIeMC6XAEmG8/Yh742
 DBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=QEJZpmtGOLUIXKbwFVGJwPqnPf8yqJs4ed+S6FFnMI4=;
 b=IAAg/vJOSpj5U9XImRmmhF1+y0mSEEEYCbuzmQ1cYf6KxPqgPCgZGIIHwUlQ0Aq5EF
 4fNnPgmi/012xSAVHVmP01p5Ph8+saZFW68315v83TVBvMDbhj08saOd7Y6zfIoM8W6F
 /WSUjDxN1WMaOa6rSRbC98D4rmSvGZgiA+VgDAM5a/I0b31aqdlQB5NesPsLcvKsVefb
 CRwWoTCg6pszw8BVCXMnIqGbUocSQ/ewbYmT8Fwo82qVtK74YBCTYGPvC7u7vwFeLmax
 vojyaV1j6QtBAl6Jus+j1AgZI6EcEq6h1wxE9IEX/a2oeFT6bdpBNbk+UtOCPUfXWeNx
 E3RA==
X-Gm-Message-State: AGi0PuY0YEZmStR6fFdKDJu6PcmgeVJ5CV9oL84fm46PzsJ1ksoE7GJA
 ScZG1z3FUiuiNO7vO/z5UO9cEFsM
X-Google-Smtp-Source: APiQypLNXVnt2nWvA+PX2I90U6r13jRm2ZxTLx8ZUu891GwTxsuRQftYmFGGTLbLhvBFEufqUpyvIA==
X-Received: by 2002:a17:90b:46c9:: with SMTP id
 jx9mr9312668pjb.2.1585910116585; 
 Fri, 03 Apr 2020 03:35:16 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id v26sm5496105pfn.51.2020.04.03.03.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 03:35:16 -0700 (PDT)
Date: Fri, 03 Apr 2020 20:35:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] powerpc/uaccess: add more __builtin_expect
 annotations
To: linuxppc-dev@lists.ozlabs.org
References: <20200403093529.43587-1-npiggin@gmail.com>
 <20200403093529.43587-4-npiggin@gmail.com>
In-Reply-To: <20200403093529.43587-4-npiggin@gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585910037.xneqg6du7l.astroid@bobo.none>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin's on April 3, 2020 7:35 pm:
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Sorry that was a bad rebase, here's the fixed patch.

---
 arch/powerpc/include/asm/uaccess.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/=
uaccess.h
index 144d01645d68..8a0474682c9b 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -48,16 +48,16 @@ static inline void set_fs(mm_segment_t fs)
  * gap between user addresses and the kernel addresses
  */
 #define __access_ok(addr, size, segment)	\
-	(((addr) <=3D (segment).seg) && ((size) <=3D (segment).seg))
+	likely(((addr) <=3D (segment).seg) && ((size) <=3D (segment).seg))
=20
 #else
=20
 static inline int __access_ok(unsigned long addr, unsigned long size,
 			mm_segment_t seg)
 {
-	if (addr > seg.seg)
+	if (unlikely(addr > seg.seg))
 		return 0;
-	return (size =3D=3D 0 || size - 1 <=3D seg.seg - addr);
+	return likely(size =3D=3D 0 || size - 1 <=3D seg.seg - addr);
 }
=20
 #endif
@@ -177,7 +177,7 @@ do {								\
 	else									\
 		__put_user_size_allowed(__pu_val, __pu_addr, __pu_size, __pu_err); \
 								\
-	__pu_err;						\
+	__builtin_expect(__pu_err, 0);				\
 })
=20
 #define __put_user_check(x, ptr, size)					\
@@ -191,7 +191,7 @@ do {								\
 	if (access_ok(__pu_addr, __pu_size))				\
 		__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err); \
 									\
-	__pu_err;							\
+	__builtin_expect(__pu_err, 0);					\
 })
=20
 #define __put_user_nosleep(x, ptr, size)			\
@@ -204,7 +204,7 @@ do {								\
 	__chk_user_ptr(__pu_addr);				\
 	__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err); \
 								\
-	__pu_err;						\
+	__builtin_expect(__pu_err, 0);				\
 })
=20
=20
@@ -307,7 +307,7 @@ do {								\
 		__get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err); \
 	(x) =3D (__typeof__(*(ptr)))__gu_val;			\
 								\
-	__gu_err;						\
+	__builtin_expect(__gu_err, 0);				\
 })
=20
 #define __get_user_check(x, ptr, size)					\
@@ -324,7 +324,7 @@ do {								\
 	}								\
 	(x) =3D (__force __typeof__(*(ptr)))__gu_val;				\
 									\
-	__gu_err;							\
+	__builtin_expect(__gu_err, 0);					\
 })
=20
 #define __get_user_nosleep(x, ptr, size)			\
@@ -339,7 +339,7 @@ do {								\
 	__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err); \
 	(x) =3D (__force __typeof__(*(ptr)))__gu_val;			\
 								\
-	__gu_err;						\
+	__builtin_expect(__gu_err, 0);				\
 })
=20
=20
--=20
2.23.0

=
