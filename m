Return-Path: <SRS0=9U3E=NO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02955C0044C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 13:03:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503A42081D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 13:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503A42081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42nJyy5tX0zF35R
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 00:03:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: lists.ozlabs.org; spf=pass (mailfrom)
 smtp.mailfrom=users.sourceforge.net (client-ip=212.227.17.11; helo=mout.web.de;
 envelope-from=elfring@users.sourceforge.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=users.sourceforge.net
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42nJwP3998zF1Ps
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Nov 2018 00:01:08 +1100 (AEDT)
Received: from [192.168.1.2] ([77.182.136.36]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWj6V-1g3sYm0dBr-00XxSy; Sat, 03
 Nov 2018 13:51:35 +0100
Received: from [192.168.1.2] ([77.182.136.36]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWj6V-1g3sYm0dBr-00XxSy; Sat, 03
 Nov 2018 13:51:35 +0100
Subject: Re: [PATCH -next v2 1/3] mm: treewide: remove unused address argument
 from pte_alloc functions
To: Joel Fernandes <joel@joelfernandes.org>, kernel-janitors@vger.kernel.org
References: <20181103040041.7085-1-joelaf@google.com>
 <20181103040041.7085-2-joelaf@google.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <fd939e7c-3d9e-760e-f20c-e7263f064153@users.sourceforge.net>
Date: Sat, 3 Nov 2018 13:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181103040041.7085-2-joelaf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VsFj7PZvXTuItJtMK3DaoKAJBuiK9mXpGGY5+klibNLoFdxoEfJ
 LMXp3e5QGQjzwTHhuzc7WT6CSt1cWmztVsZoA0YtitXFQxXGg/1sFxtK/3NTNTBkQAE/vLx
 yfH10rM+HaCfDwS1a7MSrlUZRz1cWjsl+WROQOVkuX2Uyl621tQOWWcYzEdwOCFSZeezRw6
 yD79guZzI267srJxDvn3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:00zZVmnm/e4=:zrgqulAdP3zhf6M0776Wxs
 gplketaQFN3qRaYpoEQCWrsr5iee1dxRky+/l8MzCrWFff/8JKF5p+nVjBglaJAgNPAQ5jVkF
 Tbr1yLDCru2LahhjOYS+lBZvZyCVi0AvH5MGaXK1fYOq+yJ40fZDDJEAvXDEgSjZ4hXePEzP+
 plO4vRBEIFOfLFJosRBpCuCLrZ4+ADDIIKHvAMa9Bh+DNenkyq8auOXbf4WhQ+3OtbLYOcVL4
 fghzW0al109UW4xTnePJ+nmDunuE/yjQDehnuFUpbgmW4zQaYHgYXbSxLe7F/Jf1dri4M4PRd
 IYQFPyVZeTmp8m+To1Gy8TS1t//cd2RKbKIMlFZRxI8a/JIGe/U0GnpaoHUCC8/41coNefkWx
 Ta71suJTlZ2F66zkKucfNZdp4p037HxqoN2NQAh3S7PqjHNY+D2UUu6cx7Yr0uY2uU4tEgMbu
 LlRC27omS4kpDDzfFGIIdNV5ZmASkVz+hTK+Qf+kJ3vok3EAX8wnPPDe1vMg/O9MKli+GQHhW
 KcRbcoUrHedfabK3nbC9cMb8wgPU91aEhr/4HbqIJZR/Yh2E+Mvn2nOEgzTWtxYYhz3Thk7F+
 6pseSCf+f4z5rf/A4PY231bTsLUgey/uWBGoT8y4JhMe4WjDyHt8eVbvklvgEZ+4lHQxOOeV7
 Da+PJ/quLMrABqFwCV3tdPiSDe8RlvHufGnfex1qcAYZ35oR7USEl/89RK20wvMgwowMi1M0h
 5tjo5iVbzMsTL0wyF28zYiAr2stQNOYW7wdT3FNbiE+Ceqmmuygxbf0CCIU8+AxaMAercdVjO
 9leb19WUWN7gxdKrKgOMoADfPJTCJdfzN8TJL5asJG6UJ6SqJQLu278VyOz7W5zMG9NbZm4TQ
 7X9eU/giTIdgnqTHJ5fSNmgzLYplFv/0w1zJmyFy6BWEWnmKbJmXe8eF882Gdoji8yN2Rg2qe
 C1Crof7CCMA==
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 Lokesh Gidra <lokeshgidra@google.com>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 Daniel Colascione <dancol@google.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Hugh Dickins <hughd@google.com>,
 "James E. J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com,
 kvmarm@lists.cs.columbia.edu, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 nios2-dev@lists.rocketboards.org, "Kirill A . Shutemov" <kirill@shutemov.name>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 Richard Weinberger <richard@nod.at>, linux-parisc@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, pantin@google.com,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Ley Foon Tan <lftan@altera.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> … There is concern that …

Does this wording need a small adjustment?


> The changes were obtained by applying the following Coccinelle script.

I would find it nicer if previous patch review comments will trigger
further useful effects here.
https://patchwork.kernel.org/patch/10637703/#22265203
https://lore.kernel.org/linuxppc-dev/03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net/
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg140009.html


If you have got difficulties with the usage of advanced regular expressions
for SmPL constraints, I suggest to use desired function names in SmPL lists
or disjunctions instead because of different run time characteristics
for such a source code transformation approach.


> // Note: I split the 'identifier fn' line, so if you are manually
> // running it, please unsplit it so it runs for you.

Please delete this questionable comment.

* The semantic patch language should handle the mentioned code formatting.
* You can use multi-line regular expressions (if it would be desired).


> @pte_alloc_func_def depends on patch exists@
> identifier E2;
> identifier fn =~

How do you think about to avoid the repetition of a SmPL key word at such places?

Regards,
Markus
