Return-Path: <SRS0=CtgL=JD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3ACC43460
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 15:10:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3A261246
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 15:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3A261246
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FF9vJ5dykz30Gm
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 01:10:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.134; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FF9tw4Ww9z2yq6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Apr 2021 01:10:14 +1000 (AEST)
Received: from mail-ot1-f48.google.com ([209.85.210.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0nzR-1lp1S148ij-00wmlX for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Apr
 2021 17:10:09 +0200
Received: by mail-ot1-f48.google.com with SMTP id
 g8-20020a9d6c480000b02901b65ca2432cso14952224otq.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Apr 2021 08:10:08 -0700 (PDT)
X-Gm-Message-State: AOAM533bTk038xmghH/o/YIbotVZ5LGS40gqvbypHRUvAKQr7iPNdMbQ
 HMppzROAjnRv7KI6oW7rF9rhmtiHlQTOHsJZels=
X-Google-Smtp-Source: ABdhPJymivlM3E85H8Q+0NCLICsUYllvqqVKgV6xTox+xVrAvu7QQQ8spiRatNW1320IbQIk/CTiHARLx2Yc4o/NYxk=
X-Received: by 2002:a05:6830:148c:: with SMTP id
 s12mr28037074otq.251.1617721807123; 
 Tue, 06 Apr 2021 08:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Apr 2021 17:09:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3PBvj_JEgxqSD6fg_J8kZzUz_KthZ66RdA5tF4CPPbdg@mail.gmail.com>
Message-ID: <CAK8P3a3PBvj_JEgxqSD6fg_J8kZzUz_KthZ66RdA5tF4CPPbdg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:G79GJaMM0rCW6TjlLvX5rohYwYSRx27oahoXEuJ/9Z2gMfC/RLy
 Z0Qp6Fy+6K9mYwBWAq9yiRCsncEi528VqlojwSu6O3wYlOJAg19A5RgPWZPs/sfm17m2vwV
 7KIun0Lz6HzzVj0MSBQQ+6mX1Jp337mT+wo6h8G7I919R7F11mctZnVt7U1k6/1ySZlQcHP
 j3oVLZZ68r3Xgz6L2U3Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G55YZ9lU5GI=:pq0Znux1Dvj8OK9U0PEiRc
 yB3t3bgfGO5IzS8yEXv6QHZqXYhO2UqSZi5Ml9C/zvwqlxnl9+dsA4K8Z0RkAINF5xJF1ZvlW
 8p0FVI7tploRrE4bPWHrJOruxCL2CtdbJuXTq5n2KUIFn1lDUTdvtjGJyY3CtWmzgOeP66ngE
 bOxLgwD2vQS0dKGsCLxNBzC8b4D7JKiKDhf1sicPN1t0/z1Enfw7+KKIpX6PYiIMTsDB/TdHd
 mVuUDE4Q+8swzBmLWU1o84nVCsNLfnY0U3XKkRbvvD57+HKQvbxzu//vplXUCWpmAWiAzqpYf
 cz/D5Oe2iS/Cztxe3mYaCYlwOBJRCFpgU/KN4pVBRwGcJmQOslwClpRMhq2Po93KdDmZUj/xK
 Lh0GlRavr3rh2FBk99LhY+NcPZ+YvSv1QyEw07J7QQe3xdpw9TXGWPX95FKx4Lh3CeYvkN5hd
 jW+YuDxXbsMz7+5asDtOaf18kXW5O17T3c407/tA9iUJ5aKlqvdxr9XmaD1n0chnL/QD3J1OH
 GsIf0XCbiyDBSzFBS/A4Ulo9GUFSQdjyVGXpY+mMquC4tWg5aYdqCLzReQMH+jbzPqG4rR4/H
 P27+CA4ni5rizWDkwb6AjjcmPgWCnSgw0v
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-remoteproc@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arch <linux-arch@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Corey Minyard <minyard@acm.org>,
 the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Iurii Zaikin <yzaikin@google.com>, Ohad Ben-Cohen <ohad@wizery.com>,
 Joerg Roedel <jroedel@suse.de>, Kees Cook <keescook@chromium.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Josh Triplett <josh@joshtriplett.org>,
 "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>, rcu@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, openipmi-developer@lists.sourceforge.net,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, kexec@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 6, 2021 at 3:31 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.
>
> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>
