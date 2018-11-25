Return-Path: <SRS0=BtxG=OE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA543C43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Nov 2018 21:30:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BB22082F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Nov 2018 21:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BB22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43339Y2X9XzDqn1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 08:30:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stevens-zone.net
 (client-ip=212.227.17.13; helo=mout.kundenserver.de;
 envelope-from=darren@stevens-zone.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stevens-zone.net
X-Greylist: delayed 786 seconds by postgrey-1.36 at bilbo;
 Mon, 26 Nov 2018 08:28:13 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43337K67CxzDqmK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 08:28:12 +1100 (AEDT)
Received: from mintppc.lan ([80.189.87.228]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.179]) with ESMTPA (Nemesis) id 1Mv2tK-1faR5Q0bk8-00r2fO
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2018 22:14:52 +0100
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
Date: Sun, 25 Nov 2018 21:14:49 +0000 (GMT)
Message-ID: <4ceed1989a9.364d3263@auth.smtp.1and1.co.uk>
User-Agent: YAM/2.9p1 (AmigaOS4; PPC; rv:20140418r7798)
Subject: [PATCH] powerpc/kernel: Remove gcc 4 workaround from include/asm/io.h
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:jjVxogdmgu0vT3c3rD/Bb5WgThmKHhqWX2Ck30PpewrewLr2U+y
 /49Cxpy4ZwYgOmB0Ce2afPFDIRbgjLH/xNFbjkNr7b9W4/dRnK/Zcj1QSokhiBeuZ4PrEkX
 9IeiK9d+kNDmJEXmiWBo6MWlUh1Igo7Tyr0p+5syr20iidpi9MNWieDOIWXXshae2PYbOWB
 UzIsw8vIl0cTg2cvT1x/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oK9gXavKzLE=:KrlxLrfifTj/Iy1q8cDUQF
 dX+T0zPI/u9iJ6Hy71wKpjxmkyHVJSulplWkME8jwkvqB9kiDOXdWAusIIWyBYLiDfHdvzPYt
 AWvXdSDzwM5i9s6DpL4WMjJwxLCNjo5DbA3tRnEdZP8G60X3Yatar9sf1qy1G2HoBzXp6U2eV
 Jmha92LOtDCG+gyajGelbJVAbI2KG+u8eFXr4Q1XPkPNiOfdfLIPpeQxw4P4g9Jqq9HeodgOS
 4arAA8PgeXjE/kJlK59lMkwfCBPm6OEdJ57wxTJ5+CGo67nJCxKB6bffCiWIUjRvlMoi8VVZ7
 Z/K8Y18myXOmJ4XMIAptvk8tMYjoGsCQabsnibFPXnVDyd8hYFqhCIY/1ibluLV2KSH+mW33m
 Md7DFWR0cwz4jU0ur6oHjigRquUBW13wLlmBKmGA51WDgJ1ZaCNLuTzIDesT60vfymIqhebGD
 pah1A4JusjZzh5Sse/3R9UncAl9jxmh5R5ag7QfnZx0uFOG1+qrRZHzNQxdp3X87HSqrWDNva
 osWnPLOVbzifH6b/E+v70l6A3GD9zR9uU4P7r1POwz0xTN/Qd8Z2nAyMB0YDmubHdA33vaIj8
 k2sNY4TuJJ+Woexg2F+4lrlITlNsg2DoSQe1Vul+iA81MQokKGcUaBKyM2CNbbO3J0IQJn+TJ
 qCdX6jCVTx5xc+AET05CtScKWDtQsSLtgBwDO0EZrx3FqWkk0eh3nWAECZAtBo+GxY0JKZfjH
 v4rFeA46xiMLqjXMJz+XLFUDryrwmrUs29FVornO0CWaUkUhW2d2QbRoUZUdUmXzyNIUdRGpK
 nxblAt7ylrMd/AVMQcp6pJknOgqgw==
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

There are verions of DEF_MMIO_IN_X and DEF_MMIO_OUT_X in asm/io.h
that contain a workaround for a limitation in gcc <=4.0, but the
minimum supported version of gcc is now 4.6, so these can be safely
removed.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index e0331e7..4433477 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -108,25 +108,6 @@
 #define IO_SET_SYNC_FLAG()
 #endif
 
-/* gcc 4.0 and older doesn't have 'Z' constraint */
-#if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ == 0)
-#define DEF_MMIO_IN_X(name, size, insn)                \
-static inline u##size name(const volatile u##size __iomem *addr)   \
-{                                  \
-   u##size ret;                            \
-   __asm__ __volatile__("sync;"#insn" %0,0,%1;twi 0,%0,0;isync"    \
-       : "=r" (ret) : "r" (addr), "m" (*addr) : "memory"); \
-   return ret;                         \
-}
-
-#define DEF_MMIO_OUT_X(name, size, insn)               \
-static inline void name(volatile u##size __iomem *addr, u##size val)   \
-{                                  \
-   __asm__ __volatile__("sync;"#insn" %1,0,%2"         \
-       : "=m" (*addr) : "r" (val), "r" (addr) : "memory"); \
-   IO_SET_SYNC_FLAG();                     \
-}
-#else /* newer gcc */
 #define DEF_MMIO_IN_X(name, size, insn)                \
 static inline u##size name(const volatile u##size __iomem *addr)   \
 {                                  \
@@ -143,7 +124,6 @@ static inline void name(volatile u##size __iomem *addr, u##size val)    \
        : "=Z" (*addr) : "r" (val) : "memory");         \
    IO_SET_SYNC_FLAG();                     \
 }
-#endif
 
 #define DEF_MMIO_IN_D(name, size, insn)                \
 static inline u##size name(const volatile u##size __iomem *addr)   \



