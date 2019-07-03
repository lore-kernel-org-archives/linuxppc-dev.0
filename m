Return-Path: <SRS0=8MEZ=VA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1EAC5B578
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 07:57:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EC62187F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 07:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u44syaUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EC62187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45dtkd0XywzDqQB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 17:57:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="u44syaUO"; 
 dkim-atps=neutral
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45dthG03bKzDqNZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2019 17:55:41 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id t16so816452pfe.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jul 2019 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ul09Xz0PvEslS31XaHwkqPs/q07h4+4TOFh9kvfSRXg=;
 b=u44syaUOiu34twBYR3c8ZaXHPTb/eDhGobwX3pNRko+0QR79owHHQ/z7gaxTYIb/3v
 cj19e27coGLoZi0NgcGQiH6Rns9/FlbvNV/CQswdL0unv2Y46qOij9T2/z/NXpvKSDDy
 88BmqAHPdoEOpl/E25FMAgqmBgVYAuHd9DYhKS88+gJDJhzcL5sBYX2yA/gqaZhKbDoC
 hjwlRPw0mqjc/dWl3XUhbjkoRFYPZkFMy8OPaF9PGrS4H2pf/VYcy6iaCxI67J+LsJOI
 Dn3u3JYJefUm1xVXqe+trTeqWghNaV6ZWhthdXql6lFVRkYFdjvT/lbDUJEXhywqPKxQ
 uIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ul09Xz0PvEslS31XaHwkqPs/q07h4+4TOFh9kvfSRXg=;
 b=WcDUDtEs/KdQKt2TtDdwe67e/s4seTsGG3N8UYondg2qSe3yp1dw8nAhinggG5dns8
 B9kwRWLYxEzPrp2FeUhzqgKac22YP+QFPSRAIbW46oJnsfKvXXTL/cTPFEw7H4wNykt7
 EvDtajpLQPDXaH2zBx7D9FXlLWQJiFaSpbMqc0r/6slYGsiS3lJkeEV577p3QKoHKCfz
 FBDf/Sw4ZOKC1UVS4yV7a0kHfRmoivyBfsbZxp45J/++lVb5j0CDyVmQmKYSyELgEHve
 CFYn5ED4aD9OoNzk4b+3PyGgaQeOCwuSOg/ylIIY4X5wM8TiLJHu6gqkBRR32sKI0SfO
 bzqg==
X-Gm-Message-State: APjAAAUtzQr+POgkhrFensZn7LvcbGYJxmvv2mxsWQuPwDbchiFsvKDN
 y+9LL4NSk13c+TfsKQENOJ5JJKc+
X-Google-Smtp-Source: APXvYqzHDF/VZ5llzJX+YkhTnNcNOdOOiheOIKq3xspiFHq8BMeEqSMT9VqwKWJfqibzFvgeuKs6Hw==
X-Received: by 2002:a63:1046:: with SMTP id 6mr16724866pgq.111.1562140539375; 
 Wed, 03 Jul 2019 00:55:39 -0700 (PDT)
Received: from bobo.local0.net (193-116-88-34.tpgi.com.au. [193.116.88.34])
 by smtp.gmail.com with ESMTPSA id p68sm2955849pfb.80.2019.07.03.00.55.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 00:55:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/14] powerpc/64s/exception: machine check cleanup series
Date: Wed,  3 Jul 2019 17:54:30 +1000
Message-Id: <20190703075444.19005-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This ended up blowing out a bit because of some fixes and changes
to the way pseries works, and machine check is the trickiest and most
custom handler.

After this series it's almost understandable, and uses more of the
standard interrupt handler macros, which will make it more amenable
to consolidation in the next round of changes (which won't be in this
merge window).

Thanks,
Nick

Nicholas Piggin (14):
  powerpc/64s/exception: machine check fwnmi remove HV case
  powerpc/64s/exception: machine check remove bitrotted comment
  powerpc/64s/exception: machine check fix KVM guest test
  powerpc/64s/exception: machine check adjust RFI target
  powerpc/64s/exception: machine check pseries should always run the
    early handler
  powerpc/64s/exception: machine check remove machine_check_pSeries_0
    branch
  powerpc/64s/exception: machine check use correct cfar for late handler
  powerpc/64s/exception: machine check pseries should skip the late
    handler for host kernel MCEs
  powerpc/64s/exception: machine check restructure to reuse common
    macros
  powerpc/64s/exception: machine check move tramp code
  powerpc/64s/exception: simplify machine check early path
  powerpc/64s/exception: machine check move unrecoverable handling out
    of line
  powerpc/64s/exception: untangle early machine check handler branch
  powerpc/64s/exception: machine check improve labels and comments

 arch/powerpc/kernel/exceptions-64s.S | 367 +++++++++++++--------------
 1 file changed, 172 insertions(+), 195 deletions(-)

-- 
2.20.1

