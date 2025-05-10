Return-Path: <linuxppc-dev+bounces-8481-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E198C3ABBC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 May 2025 01:36:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZvT3M185gz2yhY;
	Sat, 10 May 2025 11:35:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2404:9400:2221:ea00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746840959;
	cv=none; b=lrjAREIbFoIY7iQMrU6zqlITu/MNl/DyYv6ZBA320yf+i+qKlOkFeOtStrNvMw4xH9fDDFzhSlfuoUWv1K1Nb5V7diFzjtqTuoivSo0rsfp3cjdwSt4v4kA2sv7aSIlpComDq3jphErl5I1uaMclwtlooTkzXZdQjNlx6J6W62RYZe4/G7WaINtkvuftC9XiOHclaWGu0I6nZ3wpk9xJSlWmbGsg2NukxRmKG0rN4Bdcu59mJ7txiRC2Zm18IzqiW/w40kdVlJrEspg6l1jpkZOciqahTAELnnt+/uWzZCgKHG/zwJw57GWZ4roBSW3rEgolmM3Md938kdk1Ice+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746840959; c=relaxed/relaxed;
	bh=eJ1ZNQSjtvUFKdm1fzLNpt8h4ms7L+G7yKBS49vAS6Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bB5HrI7Y7sGorFwrSaV5znpkPhnRjWrYKuMyFDVEw1WtrLLf0h41t4QZimdbKTKHb+oMLhaAK7mOSDjdOjR8QZUUneJEK/0XlMLQPG2eVwK0mw+gxgzdaBIoVowyYTkUufo4362/KR42fgKBPnQXPxHli0KUXQJoULxRGbz5SsdmsMAMdOuibG/jKxrHhTAl/AZAqPAiDrk7KSGDOI/QiBKvpUMcFVX5j9Uru7CdVEIjsGZUwY1at5LsJIZoUC35yioiQcKLzxOIhSlFOKPrJFTdn+1mO8icPIrp/FnHw3+9fZAb5ItQW82Flt2ip5VRGFzZpM10w9U3K7YWvhwXAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=njfbh0ol; dkim-atps=neutral; spf=pass (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=paulus@gandalf.ozlabs.org; receiver=lists.ozlabs.org) smtp.mailfrom=gandalf.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=njfbh0ol;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gandalf.ozlabs.org (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=paulus@gandalf.ozlabs.org; receiver=lists.ozlabs.org)
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZvT3K3HbZz2yGM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2025 11:35:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1746840956;
	bh=eJ1ZNQSjtvUFKdm1fzLNpt8h4ms7L+G7yKBS49vAS6Y=;
	h=Date:From:To:Subject:From;
	b=njfbh0olTIRi23XpkQO8SHOBKqBrb2DGT7SXPZ7erSTPidQBUtv6A7RnvdmPpBtNl
	 Z8yEkyJ/cxp2uAPbxQCV1QEWNAjEH1WD2NnHVBdO3dBZ5Ng6Ql/Q3ZmHDnmquRP9EL
	 LWb9QE7j+B71qYOB3PKFnrm2u/LOBn/x9BpvNWKSnJqSQQmw73E9lXdhMovS3wjuZd
	 9iRzHBSBj9sN02lKkO2/Q/ETNdOCpphqoZyfEnTdSJ4bAYnTf6s3JN3fHt4pDSk1/A
	 bdUzA8QjdGtDLNZueCrh2ot1IVacChp8/Wn1oUPejouT40/N3AIXlin0HUmq7mRClA
	 hKXKZ54puXLhw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
	id 4ZvT3J5gQQz4x3q; Sat, 10 May 2025 11:35:56 +1000 (AEST)
Date: Sat, 10 May 2025 11:35:36 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/microwatt: Correct ISA version number in device tree
Message-ID: <aB6taMDWvJwOl9xj@bruin>
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

The kernel uses 3100 to indicate ISA version 3.1, not 3010, so
fix the Microwatt device tree to use 3100.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/boot/dts/microwatt.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/microwatt.dts b/arch/powerpc/boot/dts/microwatt.dts
index c4e4d2a9b460..725d518cd808 100644
--- a/arch/powerpc/boot/dts/microwatt.dts
+++ b/arch/powerpc/boot/dts/microwatt.dts
@@ -37,7 +37,7 @@ cpus {
 
 		ibm,powerpc-cpu-features {
 			display-name = "Microwatt";
-			isa = <3010>;
+			isa = <3100>;
 			device_type = "cpu-features";
 			compatible = "ibm,powerpc-cpu-features";
 
-- 
2.49.0


