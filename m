Return-Path: <SRS0=yRDn=5M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB46C43331
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2020 16:10:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A97F20716
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2020 16:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an6bUaMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A97F20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48pmzK0fthzDqJS
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Mar 2020 03:10:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=afzal.mohd.ma@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=an6bUaMW; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48pmx67205zDqjT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2020 03:08:24 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id u12so4773932pgb.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2020 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=v3WW2gICCRcfa0oGxmZ+LfSQn5AikLIQ+ZRnRYdwUfA=;
 b=an6bUaMWa/gge8dt35mNz51d8Pj8Aa/qVvKR0POiYMe4zuNsTFMbWsDqtJpu8Vfgps
 HodQ817xNYHI9SLLHcYrsshSCnFQVPdRz5miPel3a6dQh30+182sG4GpKzSYGg0Moaql
 oICMZDkEloRd8GN1T9OAdis5YEzicvSdRi2cwTkeLqxIisdfp6u4WrF2upjoOm0b/Nqv
 xJs9hkC3swEZG36oeWhAa8kBkb2p598PAhHmrKt9TC86LDUy19H7w13AsSWaFeOMFBw1
 1kiJmtgBbfIhYEZfNNWHTKYdN5NFa73OW2vgKUh7ekKVHy/s1yLOWQQExWS6RBTI4i5f
 lubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=v3WW2gICCRcfa0oGxmZ+LfSQn5AikLIQ+ZRnRYdwUfA=;
 b=EQkFaWOSRkCpzEBoq4zlAchJhpbfd7JOe22o9xgSlRFkn4B7nry671UBJJpdR2/Rik
 dGPyDi/qtykM5ag88sVH+h03D9ffLQjttB4zzKXPIihyI3XyIfCMcwV+JFpt4tBUvbDW
 995JgVo+WQ1lXfy8aoig5TFX5gtjKm7WmHKt/qUokZgN0fGzkGbitmIqctOM7YtXXV5A
 VGnF0I2U5XoEPOxn5PUwG6t3uf+PhmTX7bEKSAjnvzYup52mgCgxZeCbouemSQ/vqNEw
 +mxJmxPcBx5RcSqqqxNqjDiJtPeQdEqh/ilMEJAZql/0pM1nRZaCB5ToXjM43rpoSNld
 eSVA==
X-Gm-Message-State: ANhLgQ2kMgYsUMKPtq/zqwMBvdZyt7ojQBi+XN2Sc/ylG7daAx931NGW
 1B7CaYn3fxNWO1UMxPEiXi4=
X-Google-Smtp-Source: ADFU+vs5xl4PN9llzz39JwJNhgmk9dgWBu5u30cb77PT2OtFyYrOeXBrJPUM82BlUm8kk65OLbcqNQ==
X-Received: by 2002:aa7:947d:: with SMTP id t29mr14654589pfq.184.1585325301244; 
 Fri, 27 Mar 2020 09:08:21 -0700 (PDT)
Received: from localhost ([49.207.55.57])
 by smtp.gmail.com with ESMTPSA id v185sm4391917pfv.32.2020.03.27.09.08.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 27 Mar 2020 09:08:20 -0700 (PDT)
Date: Fri, 27 Mar 2020 21:38:18 +0530
From: afzal mohammed <afzal.mohd.ma@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/6] Kill setup_irq()
Message-ID: <cover.1585320721.git.afzal.mohd.ma@gmail.com>
References: <20200321174303.GA7930@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321174303.GA7930@afzalpc>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
Cc: linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-alpha@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Thomas,

As compared to the situation mentioned earlier[1], now powerpc patch is
also in -next, and the pending ARM patches has been picked up by ARM SoC
maintainers today and is expected to show up in next -next. All other
subsytem patches has been picked by relevant maintainers & are already
in -next except alpha, c6x, hexagon, unicore32 & sh.

As it is the case, i am sending you patches for the above 5
architecture's plus the core removal patch.

Status of 5 arch's:
-------------------
alpha:		received ack from Matt Turner, build test success
c6x:		did receive ack from Mark Salter in v1, the final
		 version (v3) was with minor changes, hence removed his
		 ack & cc'ed him, build test success
hexagon:	build test success
unicore32:	couldn't get toolchain from kernel.org, 0day test robot
		 or Segher's buildall
sh:		To compile the relevant changes sh64 compiler is
		 required, couldn't get it from above mentioned 3
		 sources.

Note 1: sh toolchain is available, but that will not make the
 relevant changes compile as it has dependency of 64bit arch toolchain,
 did try a Kconfig hack to make it compile w/ 32bit sh toolchain, but it
 failed due to other reasons (unknown operands), so gave up on that.
Note 2: hexagon final image creation fails even w/o my patch, but it
 has been ensured that w/ my changes relevant object files are getting
 built  w/o warnings.

Regards
afzal

[1] https://lkml.kernel.org/r/20200321172626.GA6323@afzalpc

afzal mohammed (6):
  alpha: Replace setup_irq() by request_irq()
  c6x: replace setup_irq() by request_irq()
  hexagon: replace setup_irq() by request_irq()
  sh: replace setup_irq() by request_irq()
  unicore32: replace setup_irq() by request_irq()
  genirq: Remove setup_irq() and remove_irq()

 arch/alpha/kernel/irq_alpha.c     | 29 ++++----------------
 arch/alpha/kernel/irq_i8259.c     |  8 ++----
 arch/alpha/kernel/irq_impl.h      |  7 +----
 arch/alpha/kernel/irq_pyxis.c     |  3 ++-
 arch/alpha/kernel/sys_alcor.c     |  3 ++-
 arch/alpha/kernel/sys_cabriolet.c |  3 ++-
 arch/alpha/kernel/sys_eb64p.c     |  3 ++-
 arch/alpha/kernel/sys_marvel.c    |  2 +-
 arch/alpha/kernel/sys_miata.c     |  6 +++--
 arch/alpha/kernel/sys_ruffian.c   |  3 ++-
 arch/alpha/kernel/sys_rx164.c     |  3 ++-
 arch/alpha/kernel/sys_sx164.c     |  3 ++-
 arch/alpha/kernel/sys_wildfire.c  |  7 ++---
 arch/alpha/kernel/time.c          |  6 ++---
 arch/c6x/platforms/timer64.c      | 11 +++-----
 arch/hexagon/kernel/smp.c         | 22 ++++++++--------
 arch/hexagon/kernel/time.c        | 11 +++-----
 arch/sh/boards/mach-cayman/irq.c  | 18 +++++--------
 arch/sh/drivers/dma/dma-pvr2.c    |  9 +++----
 arch/unicore32/kernel/time.c      | 11 +++-----
 include/linux/irq.h               |  2 --
 kernel/irq/manage.c               | 44 -------------------------------
 22 files changed, 60 insertions(+), 154 deletions(-)

-- 
2.25.1

