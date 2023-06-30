Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CB6EB64D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jun 2023 09:50:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QsrD55HxLz3c8V
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jun 2023 19:50:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.219.173; helo=mail-yb1-f173.google.com; envelope-from=namhyung@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QskWy3RZ3z307V
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2023 15:34:05 +1000 (AEST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso1383541276.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2023 22:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688103243; x=1690695243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqe4oW6egP6ZYOUhmx0yHzT4spsp8DeajtOy9Dxl0N0=;
        b=MQbZgS8j45VdyGte9dz0HYhN+9keD/jlffYR3K71XzC1NHBBeyIGeDx+rZN9yAsiUd
         0U9UA0wR4qTu6ZrvwNJc4mjyeLJLzwOzEvCRIaMQzyij9VRfvh8DNhIMRQvz63LvmWIQ
         Ebn/hi5J84qzzzMta/pcbPPHFA8O063bdnLJgstQJXewa6nLwkWa/748WK5xs5Sy0eyz
         wO9ZaqWoVakMHCyi8GuiPMZeLXZus+AUv90AS8fin0mG9fgi78PT/kRECjbNDZjHEGHO
         z9wp8oqp/1WLMz7NZSnitA5I9cprfeRJ0rKrSyweiGx6XXLi07JztU8i5e3uJl/V9Q/g
         D6MA==
X-Gm-Message-State: ABy/qLZBdobgBf/u3B2a5sVwrCBy33YjV54UU3AmvETf/FDIqh2x0Z8X
	9zyc0cGMyuPUVlEqMaV4sEAG3xCRvVcdPrQRdqM=
X-Google-Smtp-Source: APBJJlGsOWkMaxD3Bj5EXOi0ZRM8KsFOEr8Lg1uNKczc+6HZPSKDsYy2QxFxSi6Et+JGvnEpCG0zVQlZ9J+DNPB54vc=
X-Received: by 2002:a25:3107:0:b0:c12:29ac:1d36 with SMTP id
 x7-20020a253107000000b00c1229ac1d36mr1697430ybx.7.1688103242894; Thu, 29 Jun
 2023 22:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230628230935.1196180-1-sohil.mehta@intel.com> <08e273fc-49c5-dd09-1c9e-d85a080767f9@infradead.org>
In-Reply-To: <08e273fc-49c5-dd09-1c9e-d85a080767f9@infradead.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 29 Jun 2023 22:33:51 -0700
Message-ID: <CAM9d7ch0GtTUjhtbph5rmCDvRBAKjLCN+25mukn_QPv4bDsjGQ@mail.gmail.com>
Subject: Re: [PATCH] syscalls: Cleanup references to sys_lookup_dcookie()
To: Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 30 Jun 2023 19:48:38 +1000
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>, "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "Eric W . Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Lukas Bulw
 ahn <lukas.bulwahn@gmail.com>, Matt Turner <mattst88@gmail.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sergei Trofimovich <slyich@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>, Brian Gerst <brgerst@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, linux-mips@vger.kernel.org, Rohan McLure <rmclure@linux.ibm.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Arnaldo Carvalho de Melo <acme@kernel.org>, Andy Lutomirski <luto@kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-api@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Sven Schnel
 le <svens@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, linux-alpha@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

On Wed, Jun 28, 2023 at 4:44=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 6/28/23 16:09, Sohil Mehta wrote:
> > commit 'be65de6b03aa ("fs: Remove dcookies support")' removed the
> > syscall definition for lookup_dcookie.  However, syscall tables still
> > point to the old sys_lookup_dcookie() definition. Update syscall tables
> > of all architectures to directly point to sys_ni_syscall() instead.
> >
> > Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

I was about to say that it'd be nice if you split the tools/perf part
since it can support old kernels.  But if the syscall is only used for
oprofile then probably perf doesn't need to care about it. :)

For the perf part,
Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
