Return-Path: <SRS0=cnDq=36=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9C1C35250
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Feb 2020 05:34:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CDF214DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Feb 2020 05:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpI8skXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CDF214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48GF3L1rTszDqRm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Feb 2020 16:34:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux-foundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=fpI8skXk; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48GD6b2zhTzDqMb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2020 15:52:37 +1100 (AEDT)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6A05D208C4;
 Mon, 10 Feb 2020 04:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581310354;
 bh=2W/dmgTJj6413Xr7wihmGcYdSzIEeuWsZRG1pj9rho0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fpI8skXkWSRkM2Z7t+IumpNpNlIyF35fF7t+yGEA67BDAAqSWhx6bv4mO/yn0SyDF
 TmUxgUc36bRm998D0NbvswNWlliaFKrJH88Mwv6jTUy1ILklfKpB9gT2jSQppuhH+2
 hH7M1ataalYtvJe9O809m6u56bYNF8WwzVrYPDcM=
Date: Sun, 9 Feb 2020 20:52:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V13] mm/debug: Add tests validating architecture page
 table helpers
Message-Id: <20200209205231.44d098f8749e88190b8ba10c@linux-foundation.org>
In-Reply-To: <78d3ce6b-e100-2561-6b09-124c29731d1a@arm.com>
References: <1580897674-16456-1-git-send-email-anshuman.khandual@arm.com>
 <202002060619.wEOdAZU1%lkp@intel.com>
 <78d3ce6b-e100-2561-6b09-124c29731d1a@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 10 Feb 2020 16:33:18 +1100
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
Cc: Mark Rutland <mark.rutland@arm.com>, uclinux-h8-devel@lists.sourceforge.jp,
 linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 James Hogan <jhogan@kernel.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
 Dan Williams <dan.j.williams@intel.com>, linux-s390@vger.kernel.org,
 kbuild test robot <lkp@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>, Mark Salter <msalter@redhat.com>,
 Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@kernel.org>,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, linux-alpha@vger.kernel.org,
 Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, linux-c6x-dev@linux-c6x.org,
 Mark Brown <broonie@kernel.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@pku.edu.cn>,
 Vlastimil Babka <vbabka@suse.cz>, Richard Henderson <rth@twiddle.net>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 kbuild-all@lists.01.org, Brian Cain <bcain@codeaurora.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Vineet Gupta <vgupta@synopsys.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Qian Cai <cai@lca.pw>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 6 Feb 2020 13:49:35 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> 
> On 02/06/2020 04:40 AM, kbuild test robot wrote:
> > Hi Anshuman,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on powerpc/next]
> > [also build test ERROR on s390/features linus/master arc/for-next v5.5]
> > [cannot apply to mmotm/master tip/x86/core arm64/for-next/core next-20200205]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-debug-Add-tests-validating-architecture-page-table-helpers/20200205-215507
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> > config: ia64-allmodconfig (attached as .config)
> > compiler: ia64-linux-gcc (GCC) 7.5.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.5.0 make.cross ARCH=ia64 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >    In file included from include/asm-generic/pgtable-nopud.h:8:0,
> >                     from arch/ia64/include/asm/pgtable.h:586,
> >                     from include/linux/mm.h:99,
> >                     from include/linux/highmem.h:8,
> >                     from mm/debug_vm_pgtable.c:14:
> >    mm/debug_vm_pgtable.c: In function 'pud_clear_tests':
> >>> include/asm-generic/pgtable-nop4d-hack.h:47:32: error: implicit declaration of function '__pgd'; did you mean '__p4d'? [-Werror=implicit-function-declaration]
> >     #define __pud(x)    ((pud_t) { __pgd(x) })
> >                                    ^
> >>> mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__pud'
> >      pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
> >            ^~~~~
> >>> include/asm-generic/pgtable-nop4d-hack.h:47:22: warning: missing braces around initializer [-Wmissing-braces]
> >     #define __pud(x)    ((pud_t) { __pgd(x) })
> >                          ^
> >>> mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__pud'
> >      pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
> >            ^~~~~
> >    cc1: some warnings being treated as errors
> 
> This build failure is expected now given that we have allowed DEBUG_VM_PGTABLE
> with EXPERT without platform requiring ARCH_HAS_DEBUG_VM_PGTABLE. This problem
> i.e build failure caused without a platform __pgd(), is known to exist both on
> ia64 and arm (32bit) platforms. Please refer https://lkml.org/lkml/2019/9/24/314
> for details where this was discussed earlier.
> 

I'd prefer not to merge a patch which is known to cause build
regressions.  Is there some temporary thing we can do to prevent these
errors until arch maintainers(?) get around to implementing the
long-term fixes?


