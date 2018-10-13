Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD93C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 05:53:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B746920835
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 05:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B746920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XrMz6jhGzF3BP
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 16:53:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: lists.ozlabs.org; spf=pass (mailfrom)
 smtp.mailfrom=users.sourceforge.net (client-ip=212.227.15.14; helo=mout.web.de;
 envelope-from=elfring@users.sourceforge.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=users.sourceforge.net
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XK7S490NzF35X
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 20:25:38 +1100 (AEDT)
Received: from [192.168.1.2] ([77.182.109.121]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ljgd6-1fe7F90cKO-00bZio; Sat, 13
 Oct 2018 11:23:11 +0200
Received: from [192.168.1.2] ([77.182.109.121]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ljgd6-1fe7F90cKO-00bZio; Sat, 13
 Oct 2018 11:23:11 +0200
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
To: Joel Fernandes <joel@joelfernandes.org>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
 <20181012194210.GA27630@joelaf.mtv.corp.google.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <e1be1dda-90ab-052d-496b-3de01ffc80d1@users.sourceforge.net>
Date: Sat, 13 Oct 2018 11:22:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181012194210.GA27630@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:opVsTsdRSQYHnglK8xvkCUZUswSzgAiKoS+KIhCNIvHd3Yq3Ufx
 ceTjZIQMEq4s0BqtUDsQA+V/NSZ/iWF9ovz8l3V5T+EzWg7BbDd+DB1TsHw9ObirhajDCPf
 m94io4so/kUaQ+paPJXJjuENjQDWI0XLcPpR7a3huBeUNpGTXKQjSmr/JDL+b4gW6p57u4Z
 1BzRLcEsMoiZQwc663VQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v6MarwJQGgc=:Ymq3Px86/PQtPzMwB8SDWz
 2sVTW3LAMS2aIZ8Ekzl7/SDvldDrpm06rM73xwb0uYPMZ3GHwT//p8vaal6x17s8ay7WilQrz
 K1Bg967tVvkE9O+bHYv3RH85K5N3GlfnSnpVrzbF5FATwM77bmyW3MOdfKY7APM2E6r4svqKH
 MjIc6EhkL1944Pl4HVJszGwMBqx/ea3HMQWVGQE7Fd0Ebm1oh0deQfClHVkLGh8/eDgF8Djb6
 zhE9SKkfVZD6CWg7y9Zr8UuLknPaHhds4jQlAMO+YyPfNMHH3UXbXN3LViy8PQi9Sfu/wr8jr
 3+NabdySRdW+Eh9PkizWR+WbpiupacwKtItrKdb/mvDoVJACLixppwElNeEYZJCv3pD52wuiM
 eNEH08JILjZld6narndqV/zqIowHw7k2AsltgBKw0Mqlcd3QvKYQQZP0kzRbToXq5ZBasFKx6
 U+BMMQhDfw/6IIb5b051oCjD+wiruFio921rpsNCRU5y6aHnm+w7j8hRQukryGIa8LOrD4JCW
 yaRthF7hb06kDcJkklIkR9xn6uu3m37H3Ya+z/Dsj+VDmHFNkctUwe9XY3r0EKO0MJqy4riYs
 Lund5+9Dymq/dXSENAL9MmfFRdRSfOQ12yYUHLRKcOYrSNFpBluxLsiBkqcJq5jwuxdjSZhRe
 QzXp5jsYL6wwfiq9dly7RAYyGqQBu1TI8IMDHj5CyOWHrrPCt6S8e7162OjoHxsMqNTW8Aaoo
 z0PdDLyq3fVbSyAsDljIS3uoxrzwE7ryXbtER5vO5qv8MegP+wfnql8gFgSZR2DOoTwd1GhVk
 Nw4MxMBjGx6rPT068O9XO/l/2SyaNynS07fdGT4KUxwYM+p1nk=
X-Mailman-Approved-At: Sun, 14 Oct 2018 16:51:35 +1100
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
 Dave Hansen <dave.hansen@linux.intel.com>, kernel-janitors@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 Lokesh Gidra <lokeshgidra@google.com>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 Daniel Colascione <dancol@google.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Hugh Dickins <hughd@google.com>,
 "James E. J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, nios2-dev@lists.rocketboards.org,
 "Kirill A. Shutemov" <kirill@shutemov.name>, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 Richard Weinberger <richard@nod.at>, linux-parisc@vger.kernel.org,
 pantin@google.com, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>>> The changes were obtained by applying the following Coccinelle script.

How do you think about to adjust the order of provided information
in the commit description?
1. Update goals
2. Transformation implementation at the end


>> "^(?:pte_alloc(?:_one(?:_kernel)?)?|__pte_alloc(?:_kernel)?)$";
> 
> Sure it looks more clever, but why?

1. Usage of non-capturing parentheses
2. Clearer specification which parts can be treated as optional
   in the search pattern.


> Ugh that's harder to read and confusing.

* Do you care for coding style and execution speed of regular expressions?

* If you would prefer to list function names without placeholders,
  you can eventually specify them also within SmPL disjunctions directly.

* It can look simpler to use an identifier list as a constraint variant.
  http://coccinelle.lip6.fr/docs/main_grammar002.html


> Again this is confusing.

The view points can be different for such SmPL code.

 T3 fn(T1 E1
(
-           , T2 E2
|           , T2 E2
-           , T4 E4
)     );


> It makes one think that maybe the second argument can also be removed

You expressed this as the first transformation possibility, didn't you?

You would like to delete an argument from the end of a function
or macro parameter (or expression) list.
I suggest then again to avoid the SmPL specification of source code additions
(plus lines in the file difference format).


> and requires careful observation that the ");" follows.

Yes, of course.

Would you care more in the distinction which code parts should be kept unchanged?


> Right, I don't need it in this case.

Thanks for your understanding that the metavariable “position p”
can be deleted in the SmPL rule “pte_alloc_macro”.


> But the script works either way.

I imagine that you can become interested in a bit nicer run time characteristics.


> I like to take more of a problem solving approach that makes sense,

This is usual.


> than aiming for perfection,

If you will work more with scripts for the semantic patch language,
you might become used to additional coding variants.


> after all this is a useful script that we do not need to check
> in once we finish with it.

I am curious if there will evolve a need to add similar transformation approaches
to a known script collection.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle?id=79fc170b1f5c36f486d886bfbd59eb4e62321128

Would you eventually like to run such scripts once more?

Regards,
Markus
