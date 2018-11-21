Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682F1C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 15:49:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B470521479
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 15:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OwVpQ43C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B470521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430RpL5XLPzF3Nh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 02:49:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="OwVpQ43C";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=sifive.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=palmer@sifive.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=sifive.com header.i=@sifive.com header.b="OwVpQ43C"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430Rlk2mvZzF3f6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 02:47:10 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id u6so6069277plm.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 07:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=U/lY5CfdHLl3xwIXaQIRba/GPl3Jxhihr4NwbiVFjPo=;
 b=OwVpQ43CSWic4u6uy8EiX4jKWC+6GbIh1hQ2uLHBOxn55J2QmK/J9y7M7VBuV57UnY
 K/Y6wWyqTxEs/+0mJvSl8oBTR6DdKAncImadulVokxekAe/3eCZLhsPDMsVBkEGmRTim
 VhMmMIQ9LawdPvEMc+/jfP0vfTT5sGMvpwgW7YjNSR91NsdRxsY5l6VfXtoiH6n1bQhs
 4YWv+W4y84c8A81ySRAZ1JpUgGb+HJc+cxmhCe3H5swS7n4mRu0Do2Lv9ndTy+WsWV05
 aZWRazf5kGQCMZ2XjKUVV87al9jhGC6U6i14pP/eWICsOqELVHsriFVZmXp6TenE+Gp4
 c6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=U/lY5CfdHLl3xwIXaQIRba/GPl3Jxhihr4NwbiVFjPo=;
 b=Ce0IZzBlm1Uun/LWmjV+VDy3fIRycWYkUv/sCcj4pZrd/ZumqwPe4IIxgi8+TFFq3L
 pHWUMOpDQhmf7hJWlpKzTxg1XkibXpXp8JP2KLPWc1ZK6fLyLYYeiDqcR2kULJsfSRh+
 7DsWte44eE1vuse/cVTvXu5dNoyrAoXCCLDe7+fDNnYCI+5EUfg24ZEtL0bnOPF1LMk6
 PS4YwyFMP91GkTjWMKZ91Erzjg0WjdUGc69nV/0zZCr6IHdrUOS7rqtRIHGmcPMdPFIJ
 5aIH0rfetNJtHzigOU27RF9wzleCGcCddDWZPx7OK6lZDQG29FwjCGY837rB/wW+hoCx
 fDWQ==
X-Gm-Message-State: AA+aEWZ7lQirrlqVGEwFzoOZdTL6kCiCHSEd9thLKRZvGyc3S/cdaszR
 Hlcba56FAfKMgp9WRPxBbLSF5g==
X-Google-Smtp-Source: AFSGD/UAi/NJ3PgiFeWjX4A041/WQ8nt8aNRCdGUah1xwxILNe5t4KPPa+Rg/oymu/oVkz81KUiVUQ==
X-Received: by 2002:a63:7f4f:: with SMTP id p15mr6498437pgn.296.1542815228599; 
 Wed, 21 Nov 2018 07:47:08 -0800 (PST)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id r6sm65610040pgk.91.2018.11.21.07.47.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Nov 2018 07:47:07 -0800 (PST)
Date: Wed, 21 Nov 2018 07:47:07 -0800 (PST)
X-Google-Original-Date: Wed, 21 Nov 2018 07:44:37 PST (-0800)
Subject: Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *"
 argument
In-Reply-To: <20181121004422.GA29053@altlinux.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: ldv@altlinux.org
Message-ID: <mhng-c75e14b8-b36c-46c2-8ffc-914312ed0cef@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, paul@paul-moore.com, linux-hexagon@vger.kernel.org,
 x86@kernel.org, esyr@redhat.com, lineprinter@altlinux.org,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 luto@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, oleg@redhat.com,
 eparis@redhat.com, linux-audit@redhat.com, linux-alpha@vger.kernel.org,
 nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 20 Nov 2018 16:44:22 PST (-0800), ldv@altlinux.org wrote:
> This argument is required to extend the generic ptrace API
> with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
>
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-audit@redhat.com
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: openrisc@lists.librecores.org
> Cc: sparclinux@vger.kernel.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: x86@kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
