Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9997FC10F03
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 08:23:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C95214AE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 08:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGBxc+Yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C95214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qVYd5T24zDqY6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 18:23:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com;
 envelope-from=kernelfans@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tGBxc+Yz"; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qVWZ22ZxzDqY6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 18:21:13 +1000 (AEST)
Received: by mail-io1-xd42.google.com with SMTP id i21so17697856iol.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rnJZSZFnULCRsZrHYmQhLyhrB7ogDN8kv1Uyzro7gws=;
 b=tGBxc+YzDWpHYkIvmCSgRz956C16OLgKkbIcmhzC+1xXoGO6zp3loSiQ7dXl+7dO+q
 9StlZmvfbiUnPNYQCH6g6kNLO/fcc9I9e6HlaKBYOH4O0skD4iSsKeo0vtbuRwZitAhS
 sx3eh3uobQKJ9ACBEilhlzVsxOJK2STZm67gzsaxAdNGfexgEMp+EEh/Gjpsgrzc3FBJ
 EBzN73jWiZOYyCgq4sejX8cT1j0yr8PLJZbUjiwQReQQgjGWuq4qkSNdY9hdmMlxGQaB
 xS6VTR8IHc7sS24lufmtVw2KfS2/pkns3U9hws2n8C14h18FNCMJkWO26IVJOUOfll6v
 BY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rnJZSZFnULCRsZrHYmQhLyhrB7ogDN8kv1Uyzro7gws=;
 b=VHCtZ7rjhiez8g9o8WdFBzkQ8Nqzy8YgYfEnkiuq7E48oKc1rTWmel212+nIp9fVb0
 FxksRu0/78umcukWP3C/rbk59inG4nILeV0+dK7afhWR0sHQi4OkL5ZLnypVYPx4wUfB
 M3z+aJ6tRJACbae4JVKjtfilAOlncQ/OCAxhR00AYaqtWoxs3IAyzerN4VEFLBVjO3kS
 lYKyHTTcQYPeospH4i6zXlCXZbRuWfwenerpK+Ride2w/IZRkx4xyvV21Z3Y1UhLcbC4
 scWcrErrk03M6LhM9a8MBc1QeN968ZtFmTsd61t9IUYeyFwrXc3QYPfVRAvjfj0rpR2s
 ON9A==
X-Gm-Message-State: APjAAAXO7b3zYACn/YU4+CeyRak5XdRrS1nVIYInklTmV1GFda0nnT29
 kz0aENUrhJgBmppSdI1B/m1A88sE9AgeXUgybA==
X-Google-Smtp-Source: APXvYqyZF0VJ6H/W0KkhLLQMHoR91SLrqlZTBjABevwCr1pHSQAf6ZYLvaN8f4DDJv+zIohe3tXE9+56Cg1iuZAtgHk=
X-Received: by 2002:a6b:b54b:: with SMTP id e72mr645706iof.106.1556180468500; 
 Thu, 25 Apr 2019 01:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <1556087581-14513-1-git-send-email-kernelfans@gmail.com>
 <10dc5468-6cd9-85c7-ba66-1dfa5aa922b7@suse.com>
In-Reply-To: <10dc5468-6cd9-85c7-ba66-1dfa5aa922b7@suse.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Thu, 25 Apr 2019 16:20:57 +0800
Message-ID: <CAFgQCTstd667wP6g+maxYekz4u3iBR2R=FHUiS1V=XxTs6MKUw@mail.gmail.com>
Subject: Re: [PATCHv2] kernel/crash: make parse_crashkernel()'s return value
 more indicant
To: Matthias Brugger <mbrugger@suse.com>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Julien Thierry <julien.thierry@arm.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Palmer Dabbelt <palmer@sifive.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Stefan Agner <stefan@agner.ch>, linux-mips@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Logan Gunthorpe <logang@deltatee.com>,
 linux-s390@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Dave Young <dyoung@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 Tony Luck <tony.luck@intel.com>, Baoquan He <bhe@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 Paul Burton <paul.burton@mips.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Greg Hackmann <ghackmann@android.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 24, 2019 at 4:31 PM Matthias Brugger <mbrugger@suse.com> wrote:
>
>
[...]
> > @@ -139,6 +141,8 @@ static int __init parse_crashkernel_simple(char *cmdline,
> >               pr_warn("crashkernel: unrecognized char: %c\n", *cur);
> >               return -EINVAL;
> >       }
> > +     if (*crash_size == 0)
> > +             return -EINVAL;
>
> This covers the case where I pass an argument like "crashkernel=0M" ?
> Can't we fix that by using kstrtoull() in memparse and check if the return value
> is < 0? In that case we could return without updating the retptr and we will be
> fine.
>
It seems that kstrtoull() treats 0M as invalid parameter, while
simple_strtoull() does not.

If changed like your suggestion, then all the callers of memparse()
will treats 0M as invalid parameter. This affects many components
besides kexec.  Not sure this can be done or not.

Regards,
Pingfan

> >
> >       return 0;
> >  }
> > @@ -181,6 +185,8 @@ static int __init parse_crashkernel_suffix(char *cmdline,
> >               pr_warn("crashkernel: unrecognized char: %c\n", *cur);
> >               return -EINVAL;
> >       }
> > +     if (*crash_size == 0)
> > +             return -EINVAL;
>
> Same here.
>
> >
> >       return 0;
> >  }
> > @@ -266,6 +272,8 @@ static int __init __parse_crashkernel(char *cmdline,
> >  /*
> >   * That function is the entry point for command line parsing and should be
> >   * called from the arch-specific code.
> > + * On success 0. On error for either syntax error or crash_size=0, -EINVAL is
> > + * returned.
> >   */
> >  int __init parse_crashkernel(char *cmdline,
> >                            unsigned long long system_ram,
> >
