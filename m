Return-Path: <SRS0=xkpp=IG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500B5C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Mar 2021 08:27:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B472E650BB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Mar 2021 08:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B472E650BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DvBKQ079cz3cmv
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Mar 2021 19:27:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DvBK26ZFSz2ysx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Mar 2021 19:27:01 +1100 (AEDT)
Received: from mail-ot1-f45.google.com ([209.85.210.45]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mj8eB-1lvF490zEz-00fCx0 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Mar
 2021 09:26:56 +0100
Received: by mail-ot1-f45.google.com with SMTP id j22so2569008otp.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Mar 2021 00:26:54 -0800 (PST)
X-Gm-Message-State: AOAM5323cdFBobKV15nxr67wt1Co4StzABwLmjmXi9EaxFt3RM009fjI
 iT9TfiGawe4De4QLskBoQelibjp2XJsx/b/hj+M=
X-Google-Smtp-Source: ABdhPJz7WzRENGkqrJauNt4Eu43tE41OHtOy5Pi18b4rc5onlz+3B0QPZSg6kqLhqT6QwccMllOlz9JudYJqhcYI0w4=
X-Received: by 2002:a9d:2f24:: with SMTP id h33mr8386599otb.305.1615192013989; 
 Mon, 08 Mar 2021 00:26:53 -0800 (PST)
MIME-Version: 1.0
References: <1615185706-24342-1-git-send-email-anshuman.khandual@arm.com>
 <1615185706-24342-7-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1615185706-24342-7-git-send-email-anshuman.khandual@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 8 Mar 2021 09:26:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Jp6wgGWJ9UDoiN5joOYSONaoHoH=S--i=3SQpm_f4JQ@mail.gmail.com>
Message-ID: <CAK8P3a3Jp6wgGWJ9UDoiN5joOYSONaoHoH=S--i=3SQpm_f4JQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm: Drop redundant HAVE_ARCH_TRANSPARENT_HUGEPAGE
To: Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fEoDnL0cRwAzHc9bW6/Y4kVSG3RL9XmgDrAPCEmUIWVv+s6wcFw
 jJFBRVRZ1QzFTIkhTKH95MBlJXl2OPJDIZAoO4Q2Cp/RCCrPJMFT4yV20Tw1dsI7xzYmC1a
 jNJ7IwONAcDZ60fjyHdmHjV1TDfrG/EkoR5ockaVCbbD2wHCoKK75doPWicSFz9l5MM4RGk
 v1IoVSA4uKQGo8aSfnZZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h6nZQNUb6mE=:e8+e++2vHvJj+R83MTGk/C
 us2nXtbnIxwu4IP8I5z51wlhkafQHkaMhbDf/im4kEmXgR6wAzeXXmnIsc4jTTD0YN/tE60LZ
 DI27eHA3P4d6v2H//0QWQ02Rpn1j6C3uOJLV/CkWOlb6icHChXtlJDXZi2GT3ETsCMjVFpofV
 Var+nc1efxLMfOYMSUaEJJ8wXeTnk60JSy/DKcbjFtz47GvoA0yZ9aOnpv4FFKcvIxkPvYT7E
 zYIIFjDCziIZTRjnh8HyKwAnpB9YSEvIXGQBMpo0uaDbnLZFMHXP6X3vfOgY+eQSfXPF12KG3
 se+rbtDLcyQoM8f52GteK5Ujl7FNNmArqAAMrKSVSXwxeCCJ3WWQ7IOaAw/PCPYm/NiGRKslr
 l/s718PfZ6NSEN/fmvdQecq9fU4bo03WXlwJTf0nrEKSoOWoluUhebmRhL9wIMaZnA3S0Ua1y
 9izsQ4/3iS7QEbQ9nYRy3Xft1WRs9fDAw34nBxiSrwJ5hbC5zJSpLbKhcScEr0RVpjP+XPPAu
 /07YrNcUwLJCqcsAZS0vrhBr02Rp4RP5tFNr1FE78xMDp9FTpcQW0wQ0CZBReELfw==
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, linux-ia64@vger.kernel.org,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 8, 2021 at 7:41 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> HAVE_ARCH_TRANSPARENT_HUGEPAGE has duplicate definitions on platforms that
> subscribe it. Drop these reduntant definitions and instead just select it
> on applicable platforms.
>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
