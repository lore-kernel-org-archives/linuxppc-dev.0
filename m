Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C5CC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 18:34:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47562082C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 18:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbrbM0GL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47562082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WnLk0vSczDqTp
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 05:34:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SbrbM0GL"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WnJx6JlXzDqRj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 05:32:31 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id t21so2562896pfe.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=skRULYaGnsGuwSHl3Pkf/Hf5xkfTXbuPlqJJkGetkNc=;
 b=SbrbM0GLYp/F+ZBvfWoyKbOsXHYwHFbj5+D8dSX5WiPjaqvJbrWMdWGOtVC0nZ0cCM
 34XAm1WHSf8vUiMr1ZtZgEQO7SvwWCwfk1MeVUxq1TrXvKk7fe8FzsWKzhpPHp/+0Z2g
 uc28baaOEOjkJMcbAAXKG1LFXfoKNj92/UpRq43JCg5sgBjdM6KoR8I/g4wkrS3rms4v
 7I/A+HWrp3o2RebOzudNA1LsZSOq6joZmjfCHeSlqCAOgA9TUkdboSrT/re8SPqjToYP
 1vwA4ioGG4YElOCU79wV3RW7wUOs63Df36uho5xpVlksBayuz9wGNPIgOrZXID3U8ep+
 9+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=skRULYaGnsGuwSHl3Pkf/Hf5xkfTXbuPlqJJkGetkNc=;
 b=Fn3u9iHfysJfG9DUXksyLIRpO4cNrCG5LBbrJRhBQ4+4J9oQDwDtPBsE1s0y22uJu1
 DdRlcg129n6Z0NOe66qnG18MjmCgYUaSCYHvPoX6QL7ObMYSC1oFBSC4Avkl32GILwmJ
 wN0LCiCI0dFJYrwmX7zvf+QZF8wgg4Y84rxLRaVH/DlztH0wDlB0HYOdB4EoQdzo/5v2
 8ItaFdf7Reew8avjbrYX1iaSUO4yKcXye38JUV3UHxYe7xwKNzqIpkJo+k7PBotrcnqX
 P1RR6B4ZSMME2lFmrTfGWMl/3um8BwMNFk67Ezux7Q9XGtNaMw1scwUBaeigDynAUui1
 Ct8Q==
X-Gm-Message-State: APjAAAXY9W6GC2qW3a28ev3GoIStDSJZAqslrK+1lWy1KqeVtuCYDldG
 p6cLj/UO3CORta6CqzDv5VJNIYu54vK7SmU79Uc=
X-Google-Smtp-Source: APXvYqyTKQEWb+KljeDpmX6txVxxjSyvRqHNpFatGgpulkMBtEc+jB8NBCEvU4P4BABz9MuYIQuLQ33fU0m/OswGmNM=
X-Received: by 2002:a65:5acc:: with SMTP id d12mr52875695pgt.337.1553970748130; 
 Sat, 30 Mar 2019 11:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
In-Reply-To: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Mar 2019 20:32:16 +0200
Message-ID: <CAHp75Ve-VUkMA4NUfN3QxR=whfoatOuPMKddz2Gb1e9acF3vMw@mail.gmail.com>
Subject: Re: [PATCH 0/5] simple sort swap function usage improvements
To: Andrey Abramov <st5pub@yandex.ru>
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
Cc: Michal Hocko <mhocko@suse.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Dave Chinner <dchinner@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, piaojun@huawei.com,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 jiang.biao2@zte.com.cn, Jiri Slaby <jslaby@suse.cz>,
 Stephen Rothwell <sfr@canb.auug.org.au>, darrick.wong@oracle.com,
 Richard Weinberger <richard@nod.at>, mark@fasheh.com,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 YueHaibing <yuehaibing@huawei.com>, lchen@suse.com, rppt@linux.ibm.com,
 ge.changwei@h3c.com, Ingo Molnar <mingo@redhat.com>,
 naveen.n.rao@linux.vnet.ibm.com, linux-snps-arc@lists.infradead.org,
 kamalesh@linux.vnet.ibm.com, amir73il@gmail.com,
 Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
 ashish.samant@oracle.com, Nicholas Piggin <npiggin@gmail.com>,
 jiangyiwen@huawei.com, Borislav Petkov <bp@alien8.de>,
 Joel Becker <jlbec@evilplan.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 George Spelvin <lkml@sdf.org>, Artem Bityutskiy <dedekind1@gmail.com>,
 Mathieu Malaterre <malat@debian.org>, Vineet Gupta <vgupta@synopsys.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
 Morton Andrew <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, ocfs2-devel@oss.oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 30, 2019 at 6:39 PM Andrey Abramov <st5pub@yandex.ru> wrote:
>
> This is the logical continuation of sort improvements by George Spelvin
> "lib/sort & lib/list_sort: faster and smaller" series
> (added to the linux-next really recently).
>
> Patches from 1 to 4 replace simple swap functions with the built-in
> (which is now much faster) and grouped by subsystem (after that only
> 3 files implement custom swap - arch/x86/kernel/unwind_orc.c,
> kernel/jump_label.c and lib/extable.c).
>
> Patch #5 replaces the int type with the size_t type of the size argument
> in the swap function.

> Andrey Abramov (5):
>   arch/arc: unwind.c: replace swap function with built-in one
>   powerpc: module_[32|64].c: replace swap function with built-in one
>   ocfs2: dir,refcounttree,xattr: replace swap functions with built-in
>     one
>   ubifs: find.c: replace swap function with built-in one
>   Lib: sort.h: replace int size with size_t size in the swap function

You have to do something about Cc list.
50 people is complete overkill. Seems as your series is a set of
independent fixes. Why not to split and Cc based on individual case?

-- 
With Best Regards,
Andy Shevchenko
