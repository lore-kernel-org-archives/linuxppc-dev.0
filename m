Return-Path: <SRS0=UY8D=K3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325F6C4708F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jun 2021 08:48:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C396138C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jun 2021 08:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C396138C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FvQmz6QcHz3bVD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jun 2021 18:48:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.187; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FvQmZ2zlbz2xZW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jun 2021 18:48:28 +1000 (AEST)
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N1M4p-1lPqes3LRb-012lYR for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Jun
 2021 10:48:21 +0200
Received: by mail-wr1-f52.google.com with SMTP id q5so13376787wrs.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Jun 2021 01:48:20 -0700 (PDT)
X-Gm-Message-State: AOAM530WIoYCCucymz8C8Z1Lhklj29tZvYvWAlb8mvPRrl0qYCjL9OHI
 fEFO4JvsaTkubG7XEjDZhx3eVsDSShZD3TmkpCk=
X-Google-Smtp-Source: ABdhPJzkeMWVTFDfYkZdPFfoHdXkGgyRCZiuT7UP/tjIkH0Fwy39gQE+fV9ql/6Z7Y7PTcrvWjaIasjrJ8GLB4ttM1U=
X-Received: by 2002:adf:a28c:: with SMTP id s12mr27903812wra.105.1622537300583; 
 Tue, 01 Jun 2021 01:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210601085127.139598-1-libaokun1@huawei.com>
In-Reply-To: <20210601085127.139598-1-libaokun1@huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 1 Jun 2021 10:46:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2w3iHR8LM12MF9OtXeJiREtuQuALBEmUCyHgZxSXnczA@mail.gmail.com>
Message-ID: <CAK8P3a2w3iHR8LM12MF9OtXeJiREtuQuALBEmUCyHgZxSXnczA@mail.gmail.com>
Subject: Re: [PATCH -next] powerpc/spufs: disp: Remove set but not used
 variable 'dummy'
To: Baokun Li <libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uemRK19vxDyq2jQUAYJp1PGUGHWluduW4eUd6Kgdp8JGiCIb0yh
 BNX3OoAt+eYsPy18e0tqS5XAq+wfkUAJCthIQU1iY+opcXv/97tiF9TN/4PcgesZqCnrFxa
 n/c00WZ3H6j3VtjY8q3FygIGtrrcINwbCLxHzWznGc9aYE1ZyUPBzme5NJX7GodzAR1fNMC
 WOWRIy2/HZzbjSauHeZTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FYWIIf6EG+A=:vX2UmNs/nYH0NNoLl+dUKS
 iu4dx478wqBHA8bOGRNLwXAA4w/QTupGPAkXQ4MGvNVipn0GUL0wC579Y/aAKcnZCs6EJQCza
 ZybGPz9WbHBDD85au05/ZLJAMClYoaB9xdLw5CXGYORLpiLMTT1A19XKOy0Q6fzHdgDqEq/fx
 yl6hMmXrnirDLtgr51GbZUvfR6RNicOpc11kgKOq7/PRNa9qQ19GuiPmSpEScLkNuS+9HJgub
 /EvAJ72IsAnYS+hDcW4rk9lMTjrEPyEHEKQaew4NNN1jpzPXiRnuZwNCwi9Zlm6bA/KoSk/zn
 r4mLE4Ca+PiRQP9EF7jkIfChwkSD2c9oqzFPq0zN0mnWKaSQGHkGy/oc/csU1dcVI1kxYl8kS
 gtVf5p63K5LLKeOmw8orVCHjg3EcAJCDy3tPYBMEjaCxogMgSpi4e5ABg9VjVEWbgalfOq4kN
 xnnUaV8Xhtodoss4U7YMqZcvjuCgusnnkPMv/n24t6M1H9UiWRMaAf03JGaWXnM6E9EZxQPli
 jNW4PJWdUCRVv8XlyrpFlFIyKq0IlojWzpATQ3tkqFVBLAuYbr/jLOYyg31Bff4vB4THO1+Vl
 EhfahZFVoDqHiww8zcSvevwXMrkgeSN/hSJJ+HacTo1pk+Jw0jS0soqThiFgB/dB754gQd620
 3Zi8=
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
Cc: YueHaibing <yuehaibing@huawei.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 yangjihong1@huawei.com, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>, Wei Yongjun <weiyongjun1@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Yu Kuai <yukuai3@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 1, 2021 at 10:43 AM Baokun Li <libaokun1@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> arch/powerpc/platforms/cell/spufs/switch.c: In function 'check_ppu_mb_sta=
t':
> arch/powerpc/platforms/cell/spufs/switch.c:1660:6: warning:
> variable =E2=80=98dummy=E2=80=99 set but not used [-Wunused-but-set-varia=
ble]
>
> arch/powerpc/platforms/cell/spufs/switch.c: In function 'check_ppuint_mb_=
stat':
> arch/powerpc/platforms/cell/spufs/switch.c:1675:6: warning:
> variable =E2=80=98dummy=E2=80=99 set but not used [-Wunused-but-set-varia=
ble]
>
> It never used since introduction.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I think in_be64() used to cause a different warning if the result was
ignored, but this is no longer the case.

Acked-by: Arnd Bergmann <arnd@arndb.de>
