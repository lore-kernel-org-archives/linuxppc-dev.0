Return-Path: <SRS0=RfJf=5E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAD8C4332D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 14:19:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A3E2070A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 14:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh5NyyG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A3E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48jptm2p2YzDqsR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 01:19:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=andy.shevchenko@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Bh5NyyG1; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48jnw34HHrzDrD1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2020 00:35:14 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id z5so1452494pfn.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2020 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ket5nG48OjRkSmjRLhm6o/GZWaiXnw2ieKQdmnyTlMc=;
 b=Bh5NyyG1M8gtKQIPrZf/5qLuu0ztHrg/ar6jVL2/WT1taChSOWg/KvzKJbbR0KSYtR
 XPtaZguXMqGkXBJ3gJyLO7wN+gVjLuV9q3Tz8TwQGSGAjkytzkvd45orPduurhypW4gD
 yJO04p/sjDB3DsSwi3caCRbP2G4wKsjv3RFhMMrqRyLk1I17Hd7iKJTiXBdaQKPXCmbG
 /NP1TWBrM/8HPRvMvfpqj8Jq2nmMrWRYtiIF3ldTvwMzZPlyYJxZwNVJiKpxUepjxUOW
 3Rs27tmyLu3uAw+5+1836CWrZplMOz3sKM7WD7zh+xZEVScIfOCeygBpVOiyZhii8JwD
 BWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ket5nG48OjRkSmjRLhm6o/GZWaiXnw2ieKQdmnyTlMc=;
 b=iWjeEnaJ8wyE1sDME+Jgof0MMMZimEdKAQnGsHKOoey53tuSbFtl8LCxlg/asdzLC1
 xryFQ8lwS2tu7oFHrnhzy9MiriUlvVCDjsjrHz2USPchyWmu6HpOO/oRfPnhBMywAeQ2
 xQdZMbDgDE5OJGLOkFcTeXfPNwlIEFFivnZsyPF1zQFPxvBpfGo5RgeW3mIwGiurk6Jm
 YfjipYPW1kpjAs88YpKBjKmf4dJp16Ws1k95nW8Z1mDJWM2g7kUWC4RMkIBLiAW4Gru2
 9Z5wsJOubSvAWRp0FtLNmebKdm3ogyXD+xZQjhFJrjjB/rOS7O3IAz9NgIzpkKkscwID
 z50A==
X-Gm-Message-State: ANhLgQ0/xUg9B95xzmk8hSSpMX5pPSmVBFJPhTFmW5ELJ98XyRzUhkGm
 0YKHoLeZp8JRMvUcPHLD+8JGFSa1en6oKGFpSEY=
X-Google-Smtp-Source: ADFU+vvo67RB7PN+1WI5QYtP3PGnTDjr7aFXa63C0L5Ako2i2oQmzaEBTO0AggKTr2A7JzPp7zlA8WyDdxJDa+KRnLs=
X-Received: by 2002:a63:1c4d:: with SMTP id c13mr3369187pgm.4.1584624911491;
 Thu, 19 Mar 2020 06:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584613649.git.msuchanek@suse.de>
 <1b612025371bb9f2bcce72c700c809ae29e57392.1584613649.git.msuchanek@suse.de>
In-Reply-To: <1b612025371bb9f2bcce72c700c809ae29e57392.1584613649.git.msuchanek@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 19 Mar 2020 15:35:03 +0200
Message-ID: <CAHp75VcMkPeJ6exroipnxvf-7g-C8QbVm0bAnp=rk505_nxySw@mail.gmail.com>
Subject: Re: [PATCH v11 4/8] powerpc/perf: consolidate valid_user_sp
To: Michal Suchanek <msuchanek@suse.de>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>,
 Rob Herring <robh@kernel.org>, Michael Neuling <mikey@neuling.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>,
 "linux-fsdevel @ vger . kernel . org --in-reply-to="
 <20200225173541.1549955-1-npiggin@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Allison Randal <allison@lohutok.net>,
 Jordan Niethe <jniethe5@gmail.com>,
 Valentin Schneider <valentin.schneider@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Eric Richter <erichte@linux.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 19, 2020 at 1:54 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> Merge the 32bit and 64bit version.
>
> Halve the check constants on 32bit.
>
> Use STACK_TOP since it is defined.
>
> Passing is_64 is now redundant since is_32bit_task() is used to
> determine which callchain variant should be used. Use STACK_TOP and
> is_32bit_task() directly.
>
> This removes a page from the valid 32bit area on 64bit:
>  #define TASK_SIZE_USER32 (0x0000000100000000UL - (1 * PAGE_SIZE))
>  #define STACK_TOP_USER32 TASK_SIZE_USER32

...

> +static inline int valid_user_sp(unsigned long sp)
> +{
> +       bool is_64 = !is_32bit_task();
> +
> +       if (!sp || (sp & (is_64 ? 7 : 3)) || sp > STACK_TOP - (is_64 ? 32 : 16))
> +               return 0;
> +       return 1;
> +}

Perhaps better to read

  if (!sp)
    return 0;

  if (is_32bit_task()) {
    if (sp & 0x03)
      return 0;
    if (sp > STACK_TOP - 16)
      return 0;
  } else {
    ...
  }

  return 1;

Other possibility:

  unsigned long align = is_32bit_task() ? 3 : 7;
  unsigned long top = STACK_TOP - (is_32bit_task() ? 16 : 32);

  return !(!sp || (sp & align) || sp > top);

-- 
With Best Regards,
Andy Shevchenko
