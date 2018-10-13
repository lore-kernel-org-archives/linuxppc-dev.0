Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4394EC6787C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 02:58:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F54420895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 02:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mRAnllfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F54420895
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X8Xr4f2bzF3Rt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:58:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="mRAnllfV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com;
 envelope-from=dancol@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="mRAnllfV"; 
 dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42X6p35kmpzF0fg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 12:39:49 +1100 (AEDT)
Received: by mail-io1-xd43.google.com with SMTP id w11-v6so10536850iob.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 18:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Wde0HcwExXY831MfxZDBcHjXK7XvngyeZU1X9StNjyk=;
 b=mRAnllfVhCFMlnCIOcENVRpZ9fWtdthn5GIa/84lOa1zfYRyC7orxaopMW45sB8eGB
 ivJ95/M5otzqwf+a9a0kBxZZQSGJZfhDMo+nmJKVkyBRnP8qxtUI1xy15rJyzhFmnyt0
 8+wcDDhVwfzIxE7o4UdypM1uFOyBZO+dsZHL9V9EjcRk/t9uN1N8+jXX+FQbQNwLNM6+
 Yw/NuPi1khJ60fOVJAglTvakPu+RdegP9nyurUbv1ptWNwxhwQDL9ydwtFB3Y4wuPcbb
 mQP4MZorbCaZStz3SOglr9oedZvionoAiMgHFAr+d3BHihJaHkX9rSbjnDxfL9w+LOjP
 xsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Wde0HcwExXY831MfxZDBcHjXK7XvngyeZU1X9StNjyk=;
 b=kTvVMPmgYLBOL5EpGLs9bZjlpCLPWMnt3U4DEgvyyz0q7w0u4b4rYS4m/b0g/pUwn9
 6c3LnZc8Zl5y5STKxXzVBTq2+6zXA8Ts/GQes8xzKAoUo4P/KP+AvLZk2zL/VqUmkqob
 e36WQeU38d8YEM3gbEmF4tIDxyq0lq+zOhCwMgIJgNlCS1nCfACfgsZDQbtBzZLrqNuf
 H/FDLbez6gxy70H3TVmD5TRQxijVyACSPzPgpDydIMimIHfc5LcEGXYy4iq/P6/zP1jb
 fnOP5MLHZsEpTZtcGoPxAcvYbmpxNzHYCC3McTQGE5ZJNJ4qJTU79D5fdIU+gSxOEDx+
 ytkw==
X-Gm-Message-State: ABuFfogu/BLiCjSOGBu6xdHjcBpxCzRkVjkzlzDdxntmxcQyNlz49wME
 vD8vjTEvYaiZxgrmXABxKX9Fus0XPRoWqU+AA0mZdg==
X-Google-Smtp-Source: ACcGV63O+2oHow+MnmDFFN/fGr+ypIXJq0Jebw7vm8a3hwEac10cSSqcJGLdjRO5qFIM+0mJ+lFBqqSZgai2siyMk8M=
X-Received: by 2002:a6b:b249:: with SMTP id
 b70-v6mr5998814iof.252.1539394786418; 
 Fri, 12 Oct 2018 18:39:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:d604:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 18:39:45
 -0700 (PDT)
In-Reply-To: <20181013013540.GA207108@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
 <20181013013540.GA207108@joelaf.mtv.corp.google.com>
From: Daniel Colascione <dancol@google.com>
Date: Fri, 12 Oct 2018 18:39:45 -0700
Message-ID: <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
To: Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 13 Oct 2018 13:44:51 +1100
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
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>,
 Lokesh Gidra <lokeshgidra@google.com>, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, jonas@southpole.se, linux-s390@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, deller@gmx.de,
 hughd@google.com, jejb@parisc-linux.org, kasan-dev@googlegroups.com,
 kvmarm@lists.cs.columbia.edu, mingo@redhat.com, geert@linux-m68k.org,
 aryabinin@virtuozzo.com, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, fenghua.yu@intel.com, jdike@addtoit.com,
 linux-um@lists.infradead.org, Julia.Lawall@lip6.fr,
 linux-m68k@lists.linux-m68k.org, bp@alien8.de, luto@kernel.org,
 nios2-dev@lists.rocketboards.org, kirill@shutemov.name, gxt@pku.edu.cn,
 chris@zankel.net, richard@nod.at, linux-parisc@vger.kernel.org,
 Ramon Pantin <pantin@google.com>, jcmvbkbc@gmail.com,
 linux-kernel <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>,
 linux-alpha@vger.kernel.org, lftan@altera.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Not 32-bit ARM?

On Fri, Oct 12, 2018 at 6:35 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Oct 12, 2018 at 11:18:36AM -0700, David Miller wrote:
>> From: Joel Fernandes <joel@joelfernandes.org>
> [...]
>> > Also, do we not flush the caches from any path when we munmap
>> > address space?  We do call do_munmap on the old mapping from mremap
>> > after moving to the new one.
>>
>> Sparc makes sure that shared mapping have consistent colors.  Therefore
>> all that's left are private mappings and those will be initialized by
>> block stores to clear the page out or similar.
>>
>> Also, when creating new mappings, we flush the D-cache when necessary
>> in update_mmu_cache().
>>
>> We also maintain a bit in the page struct to track when a page which
>> was potentially written to on one cpu ends up mapped into another
>> address space and flush as necessary.
>>
>> The cache is write-through, which simplifies the preconditions we have
>> to maintain.
>
> Makes sense, thanks. For the moment I sent patches to enable this on arm64
> and x86. We can enable it on sparc as well at a later time as it sounds it
> could be a safe optimization to apply to that architecture as well.
>
> thanks,
>
>  - Joel
>
