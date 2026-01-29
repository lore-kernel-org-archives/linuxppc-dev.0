Return-Path: <linuxppc-dev+bounces-16394-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C01D358F6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jan 2026 11:01:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1x5s15zzz2xnh;
	Thu, 29 Jan 2026 22:01:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769684481;
	cv=none; b=SjfEd4WA0udiyBo1VJUYCDtSBDAe6T5n7ySUtYVPQpwTAFIp+I9dNhlJoj49Wcm25xHrd3pVodvUVCPiVHciZ4JyciTFdo6ZLcxScBc+xSac2/MADG+U6nlauYzE78+Bf8hw+JMErLGQmO2fXd7+Bp0SOFrUtRrDxwtrtyuB/lMG3JvBSAD3XSdsvjBHRQp5BwjfzcTJSPuL6WAKOOH6eLHR2E1Y7RAbh0O8TyXn2Fu7nsNYg6L9G3xhKGSwDXuECvevY/LsKDhKopXe46JG9lT2j3awQK64hGg6gu2vH6ORxUTqoDrUH/StXIa/kxO4hfKMcgIkXr6o//9l1UGtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769684481; c=relaxed/relaxed;
	bh=NafyV8fynfzunEgj4qGmQ/oY79mBnXu2GJwXeQUE81E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FTAsmv6Oj7k1ywp4VhylennR+Pmj+MRbavL+wbCpjKEq61VYAWkqqwfn74ovpz0fw4XVuO5j46LR3UHMfgf4V0xlqpRfToEg0zifZM70MQhNWo8H4u+sbhXUxQ6AZYbx9yAnByqObtqChbElbIECQGbP5Bz7AC+46h5pf7fxxxrA4LfZ4wHLQxlZMMY9WOwb5SjnsHaxKHbGEMtaC5ZGe4k2cQiM4eDfg5tiRhwbWbxaUyLZi4obXBKOqf5mk8vOCjjYEX7q2rl2Kw+9bB0aM5UDIprK86DR8Fl8JFP/p8U30WYQdBMxQLe6qDu9owb2ySYBPfEYsZXsmUPaiFfmKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
X-Greylist: delayed 318 seconds by postgrey-1.37 at boromir; Thu, 29 Jan 2026 22:01:19 AEDT
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1x5q1c6xz2xlF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2026 22:01:19 +1100 (AEDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id F29F0F43B1A; Thu, 29 Jan 2026 11:55:46 +0100 (CET)
Date: Thu, 29 Jan 2026 11:55:46 +0100
From: Link Mauve <linkmauve@linkmauve.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Failure to build with LLVM for the Wii
Message-ID: <aXs8sgAcci9FKKpx@luna>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Jabber-ID: linkmauve@linkmauve.fr

Hi,

I’m trying to build the kernel for the Nintendo Wii, using LLVM instead
of gcc, in order to bring Rust support to this architecture (and also
because my distribution doesn’t ship a cross-compiling gcc), but I get
this build issue near the end:
```
% make O=wii LLVM=1 ARCH=powerpc -j1
make[1]: Entering directory '/home/linkmauve/dev/linux/wii'
  GEN     Makefile
  CALL    ../scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  WRAP    arch/powerpc/boot/dtbImage.wii
objcopy: Unable to recognise the format of the input file `vmlinux'
make[3]: *** [../arch/powerpc/boot/Makefile:394: arch/powerpc/boot/dtbImage.wii] Error 1
make[2]: *** [../arch/powerpc/Makefile:236: zImage] Error 2
make[1]: *** [/home/linkmauve/dev/linux/Makefile:248: __sub-make] Error 2
make[1]: Leaving directory '/home/linkmauve/dev/linux/wii'
make: *** [Makefile:248: __sub-make] Error 2
```

I believe it should use $(OBJCOPY) instead of objcopy, which is set to
llvm-objcopy, but couldn’t figure out where it is misconfigured.

Thanks for your help!

-- 
Link Mauve

