Return-Path: <SRS0=BXao=BG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F061C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 22:38:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019E7206D7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 22:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCZYQOjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019E7206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BFvpH2060zDrV2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 08:37:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gustavoars@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=SCZYQOjG; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BFvmC1GhHzDqr6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2020 08:36:10 +1000 (AEST)
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 18524206D7;
 Mon, 27 Jul 2020 22:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595889368;
 bh=xH/2W2HYXueBgpFbXH6T7J94Jk224b7or73aw7CZnI4=;
 h=Date:From:To:Cc:Subject:From;
 b=SCZYQOjGindndaZIZWJs98kb88zQD1ytiM857gDvGLH9QRFHwhq846rviv9r9kZCZ
 Lckp54IMoHX+H2tKnZzKjToZ32Utb2LCeaikAMurD44D5NhtoGPXApox7MPWg28INK
 2ZM1A/pZZwljFOVbRmnnm37CbU/RacAMw0hEVq6E=
Date: Mon, 27 Jul 2020 17:42:01 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH][next] powerpc: Use fallthrough pseudo-keyword
Message-ID: <20200727224201.GA10133@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/powerpc/kernel/align.c                 | 8 ++++----
 arch/powerpc/platforms/powermac/feature.c   | 2 +-
 arch/powerpc/platforms/powernv/opal-async.c | 2 +-
 arch/powerpc/platforms/pseries/hvcserver.c  | 2 +-
 arch/powerpc/xmon/xmon.c                    | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 1f1ce8b86d5b..c7797eb958c7 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -178,11 +178,11 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 			ret |= __get_user_inatomic(temp.v[1], p++);
 			ret |= __get_user_inatomic(temp.v[2], p++);
 			ret |= __get_user_inatomic(temp.v[3], p++);
-			/* fall through */
+			fallthrough;
 		case 4:
 			ret |= __get_user_inatomic(temp.v[4], p++);
 			ret |= __get_user_inatomic(temp.v[5], p++);
-			/* fall through */
+			fallthrough;
 		case 2:
 			ret |= __get_user_inatomic(temp.v[6], p++);
 			ret |= __get_user_inatomic(temp.v[7], p++);
@@ -263,11 +263,11 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 			ret |= __put_user_inatomic(data.v[1], p++);
 			ret |= __put_user_inatomic(data.v[2], p++);
 			ret |= __put_user_inatomic(data.v[3], p++);
-			/* fall through */
+			fallthrough;
 		case 4:
 			ret |= __put_user_inatomic(data.v[4], p++);
 			ret |= __put_user_inatomic(data.v[5], p++);
-			/* fall through */
+			fallthrough;
 		case 2:
 			ret |= __put_user_inatomic(data.v[6], p++);
 			ret |= __put_user_inatomic(data.v[7], p++);
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 181caa3f6717..5c77b9a24c0e 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1465,7 +1465,7 @@ static long g5_i2s_enable(struct device_node *node, long param, long value)
 	case 2:
 		if (macio->type == macio_shasta)
 			break;
-		/* fall through */
+		fallthrough;
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index 1656e8965d6b..c094fdf5825c 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -104,7 +104,7 @@ static int __opal_async_release_token(int token)
 	 */
 	case ASYNC_TOKEN_DISPATCHED:
 		opal_async_tokens[token].state = ASYNC_TOKEN_ABANDONED;
-		/* Fall through */
+		fallthrough;
 	default:
 		rc = 1;
 	}
diff --git a/arch/powerpc/platforms/pseries/hvcserver.c b/arch/powerpc/platforms/pseries/hvcserver.c
index 267139b13530..96e18d3b2fcf 100644
--- a/arch/powerpc/platforms/pseries/hvcserver.c
+++ b/arch/powerpc/platforms/pseries/hvcserver.c
@@ -45,7 +45,7 @@ static int hvcs_convert(long to_convert)
 		case H_LONG_BUSY_ORDER_10_SEC:
 		case H_LONG_BUSY_ORDER_100_SEC:
 			return -EBUSY;
-		case H_FUNCTION: /* fall through */
+		case H_FUNCTION:
 		default:
 			return -EPERM;
 	}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 8fb1f857c11c..ed1a9f43709d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -4278,7 +4278,7 @@ static int do_spu_cmd(void)
 		subcmd = inchar();
 		if (isxdigit(subcmd) || subcmd == '\n')
 			termch = subcmd;
-		/* fall through */
+		fallthrough;
 	case 'f':
 		scanhex(&num);
 		if (num >= XMON_NUM_SPUS || !spu_info[num].spu) {
-- 
2.27.0

