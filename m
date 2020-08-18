Return-Path: <SRS0=LqqS=B4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEF9C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 22:20:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E930206DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIqydpEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E930206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BWQMm5JDFzDqdD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 08:20:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::143;
 helo=mail-lf1-x143.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=OIqydpEt; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BWQKP542TzDqr5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2020 08:18:15 +1000 (AEST)
Received: by mail-lf1-x143.google.com with SMTP id b30so11028492lfj.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2020 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nn5mkrGFBbPg90QSTX4ScoaPazdulb+v6hO8tmlQUhM=;
 b=OIqydpEtkNgTroF3lnVBbcPUKQ2ogcmEFiN7wEqPDoyKdbDTrVZZ+NzClaB1tmtiGg
 1q5dVw3gvA1HPNIt4f5Vr2bR4NBZwxXhiEUf3tzRwKt7NekpaA3/ibZvmA16+OG3grZ+
 Y0pgD14ByceFmFxwkAMy97PtaHPZGmMkTHmHfX1qI8cguewQrhSEyNet//D8uLt3URbX
 wtAIYHJxjbyMRdcrkRjXE+IjNA6JaY3Jp4v8SILylCVLQ416pwm5RG8VS/kkCIf9Vupf
 N2rIlz5ZIsghwkVWwHdlgrBINrap6VQaSjRwMPYFZcqiCFlD1Cw4CyHiSO7wqpA8NX8m
 GJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nn5mkrGFBbPg90QSTX4ScoaPazdulb+v6hO8tmlQUhM=;
 b=dd7CORY3q0RYb936HUaoLybFdM5sTp8nE0ge5mu6gnS7+r6eg1tVohpd12z8U1IqXi
 w3UxtRMcBgmhxz9jJgMPGU6D3Bjf1u3B6OQrpq/0/QWIPn4hLluHK1QXjY84rzfHopox
 pugobznBOJK4o0ZXzMTm+OTB8gixEDu00ro4HJ3u8NlsqP8C64SiFms8rJ8WlFEbHtB7
 cgb2etBSWpL+eraIrN0VD1Fstq/QXne2eAW8Pc9ixi38obtGc4JjFARCRF1tlKjPuE8w
 OAxnEvCPOGeE8JXo46OlxWtnjLEAoYGOpckbQj9g3lMIrRJmu6T/gxYva/LeuhEAm0OF
 uoaw==
X-Gm-Message-State: AOAM533LMLKRL0nCpZ0gxNwhxLIs5j2iyvG57W0dhb2S/hhAb/SktntA
 7i3BFU3rucr+KuZmcNtNugC94gkkjHKchtpOhcA=
X-Google-Smtp-Source: ABdhPJyYNUN3v5scOCVMaoKuHu78eqvAibUFuUkJdpzA5rqp/I7KCAgyGHrlcUN+z5qLySo7/N7W852szcke7k/pYlA=
X-Received: by 2002:a19:cb51:: with SMTP id b78mr10676996lfg.130.1597789091106; 
 Tue, 18 Aug 2020 15:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200818151634.14343-1-rppt@kernel.org>
 <20200818151634.14343-11-rppt@kernel.org>
In-Reply-To: <20200818151634.14343-11-rppt@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 19 Aug 2020 00:18:00 +0200
Message-ID: <CANiq72mnzTv7SphVxsYy++rAPdaKVVLGGHauxNLY5D4dzq3CPA@mail.gmail.com>
Subject: Re: [PATCH v3 10/17] memblock: reduce number of parameters in
 for_each_mem_range()
To: Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Ingo Molnar <mingo@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Stafford Horne <shorne@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-MM <linux-mm@kvack.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Aug 18, 2020 at 5:19 PM Mike Rapoport <rppt@kernel.org> wrote:
>
>  .clang-format                          |  2 ++

For the .clang-format bit:

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
