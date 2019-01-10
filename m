Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EB8C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:57:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BA320685
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BA320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bBxR0SQNzDqpk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:57:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bBRs6258zDqrW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 03:35:05 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N3bfB-1hOpxi10ex-010gXM; Thu, 10 Jan 2019 17:25:21 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] sparc64: fix sparc_ipc type conversion
Date: Thu, 10 Jan 2019 17:24:32 +0100
Message-Id: <20190110162435.309262-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8LjwLF71onD7Un3igtIcMvlIPZOlhlWUzQRoDccuK5lL0rN5NIV
 3nd9PCzb2nQdqQGzIkmdHxgElT6H3c8JzOETRrNb/eN8Z8I6WwBRWsQELv4pGUHfxbWt0fM
 GzgRAOsetyOd9IeatPWWGPu/dnvSY6mChK/iYK7FaIyDgWu+fwsSDLwxUJrfQ/jg0vOF2D0
 ftdh9RqhNUIobjsFwQMQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0BWmXoijGEY=:mXNccY1RGCVRMbSFRhQ+6x
 E4ZBAUUnFiV4gXwLDQLiQXmf4NXTwcJ0njKyf6/9RKQzx3gASMGb382l3tq/sKmqcU8gnWI3L
 C2hBos8gwdWPihh5uiW/+dcXkrMweKm5539JrJtnQ9ePODr+q+nHhi+Wv57lrjIHmB7I0FTyX
 20zyJeMWeEVBDo8C3LPbFsYhkxkALf+Z60kNRW3N+jbwgwqH+8PYvfT1bOPXWqLttIdZAKGSp
 WQ7QPWHih03FrKolgHmxnKwdOnW/odw+HN5Jcp1gJfCi1dM8RD79Arri+fLxBrArV1YnQZD9t
 jEPgLSvYYp55MxtOaWObJ2hBGYms8iN30QEAXsSl4/Un5eJzcXFfol4t1oN4SuZM2OVAPrAsH
 HoqMgjNfSLAW+IGzI2fDY+UtFM6XbuY5qllQLPmHneoTbPkiMoHf4lYdIPY/cg4NR1vQriqix
 AvKJB02TCY5iSmuq/upSSqWBjuSdjvSHkT4L+qTRLrxqepISxhVJ0Vc3RODKuzMhAuouEfH3a
 cP+IuHhtI5pswkIR9MLTR30lLdzkvArScCESVlfNXu0YYVBArrgCNcFUUPRpJjM0ymsmMWg0N
 ZCiKh/XmP47hv4dWr4u1y0e8PLNn8i4mNbeWw63FUQ+ekQWMbR7Kew5E5CDxOLFSCnV1F1MbC
 sYmeo+cw0VGW2iI9f3u4+J7WJI7Av5sfck99J1/spFIIEZHQniODy0Ir0kCFJ+AwVjcKQCVTE
 yUBkeZDcMisd1eHR1HD9hjLFDq6PJ/QMKbpjKg==
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux@dominikbrodowski.net,
 jcmvbkbc@gmail.com, deepa.kernel@gmail.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, dave@stgolabs.net,
 deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 geert@linux-m68k.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru, luto@kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tony.luck@intel.com, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 paul.burton@mips.com, ebiederm@xmission.com, linux-alpha@vger.kernel.org,
 schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

__kernel_timespec and timespec are currently the same type, but once
they are different, the type cast has to be changed here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/sys_sparc_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 274ed0b9b3e0..1c079e7bab09 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -344,7 +344,7 @@ SYSCALL_DEFINE6(sparc_ipc, unsigned int, call, int, first, unsigned long, second
 			goto out;
 		case SEMTIMEDOP:
 			err = sys_semtimedop(first, ptr, (unsigned int)second,
-				(const struct timespec __user *)
+				(const struct __kernel_timespec __user *)
 					     (unsigned long) fifth);
 			goto out;
 		case SEMGET:
-- 
2.20.0

