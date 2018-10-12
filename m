Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5573C6787C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:32:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D352098A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D352098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X2dH0p7mzDqdw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 09:32:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: lists.ozlabs.org; spf=pass (mailfrom)
 smtp.mailfrom=users.sourceforge.net (client-ip=212.227.17.11; helo=mout.web.de;
 envelope-from=elfring@users.sourceforge.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=users.sourceforge.net
X-Greylist: delayed 607 seconds by postgrey-1.36 at bilbo;
 Sat, 13 Oct 2018 06:11:56 AEDT
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WyBN0X7FzF3M7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 06:11:54 +1100 (AEDT)
Received: from [192.168.1.2] ([77.182.238.221]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6V1T-1fRTIY0mGx-00yNhT; Fri, 12
 Oct 2018 20:52:01 +0200
Received: from [192.168.1.2] ([77.182.238.221]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6V1T-1fRTIY0mGx-00yNhT; Fri, 12
 Oct 2018 20:52:01 +0200
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
To: Joel Fernandes <joel@joelfernandes.org>, kernel-janitors@vger.kernel.org
References: <20181012013756.11285-1-joel@joelfernandes.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
Date: Fri, 12 Oct 2018 20:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181012013756.11285-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kL1jfGghCfX5IqF0iVRDf8mQoouSapQgO45dI9woF05xgJDfw/d
 AA5sy1osx5PoQoz8e05NX77GNXJPHw9DPR0si3tMAft3cP3Og/UHQyAFEv44VXROloUsniB
 Y8tHxhnCqGSXk3sDOvyIeh0eyIwAL0z+iO5ZuRU8MJFacaGuv/K0/oO3MnIdqboq2zbaeLx
 atswja9Z0HU2X9bmK8r2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Bmprhxpdt4=:Bxy18Bonkv4GGZtZHkRtdh
 RznFT050WPU5ac/yiDhi4GvzmHK2nKJPe0JU8W43EQUAwghOUFdXYoDPhXbQxo1+rkWi3inGc
 IxG8jn0JdUHfPGS7Wj8g7yPD2N3YK5D26FejpxHRejZUwfVp3V1s0BqC2Du3n5WN/sK8hH43g
 A873o3xo3ve9JvROgL2IM2NiVSMZkWz8XRMK9IL1Is86VxCbNcQ3aIqFTo3ZHQ7utxos5xAKp
 wY5LLH5CUg+vgPWpHwg6QmUUjK9wxjKkxhI59xavlHW7KBjYc1n9ANMb86FxF0jEq97FpJFab
 lv61bWDVOQpzKslNrWhEoFQ4BxLky9gQZMAO5zbRFusGjl0yN82bbY3FzOeE9P7aR7L9s0tCT
 XyoLz5u6VnnTwRxBdAObGYCTLjUGXe5cMprAw76qDkIyiYkF94Mn54a2AGKix9t9Rw2sNvcwh
 l1VTTGY1wDfM73caOBdesxcdRLWLzT9T3KEzYju5kJQqxWmnCauzdTB/hJsNlVGObw1iErWmJ
 e1WVeKKMK1tnIJN0+v2OuWFpIE0rY+swV5DZIqA2IYcUD8J1fn7Jtb4PqwBfCTqpRphExliy/
 ixAeu4ydfdfVH9u8q3srgmS+M2zMoNBx3zt4oEp2JPST2bBiSTj8zTtV/lWohtRJIb9HI7SNm
 dt1nYOdFizxVtn9/nWKMdWruLoUnyQ8bNwC4TUkGssMT9S4Ct+nBAxXR5IGmDIMV1xVDm1CRL
 GyTOIhSFtiSqioti/yQeNXGNHeGaLcQXyX4FcN6WgklzhBpay81VK1RBixXopJioQuSE+vtrd
 kz8PnbOsMLdcvFf5l9kygJAjqAx31Pp1MeaRZfgHNi3SB1gNkg=
X-Mailman-Approved-At: Sat, 13 Oct 2018 08:58:21 +1100
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
 Fenghua Yu <fenghua.yu@intel.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org,
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

> The changes were obtained by applying the following Coccinelle script.

A bit of clarification happened for its implementation details.
https://systeme.lip6.fr/pipermail/cocci/2018-October/005374.html

I have taken also another look at the following SmPL code.


> identifier fn =~
> "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";

I suggest to adjust the regular expression for this constraint
and in subsequent SmPL rules.

"^(?:pte_alloc(?:_one(?:_kernel)?)?|__pte_alloc(?:_kernel)?)$";


> (
> - T3 fn(T1 E1, T2 E2);
> + T3 fn(T1 E1);
> |
> - T3 fn(T1 E1, T2 E2, T4 E4);
> + T3 fn(T1 E1, T2 E2);
> )

I propose to take an other SmPL disjunction into account here.

 T3 fn(T1 E1,
(
-      T2 E2
|      T2 E2,
-      T4 E4
)      );


> (
> - #define fn(a, b, c)@p e
> + #define fn(a, b) e
> |
> - #define fn(a, b)@p e
> + #define fn(a) e
> )

How do you think about to omit the metavariable “position p” here?

Regards,
Markus
