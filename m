Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2806BC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 23:46:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C14F208E3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 23:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C14F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bN1R63BQzDqxG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 10:46:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=orcon.net.nz
 (client-ip=60.234.4.34; helo=smtp-1.orcon.net.nz;
 envelope-from=mcree@orcon.net.nz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=orcon.net.nz
X-Greylist: delayed 1729 seconds by postgrey-1.36 at bilbo;
 Fri, 11 Jan 2019 10:44:45 AEDT
Received: from smtp-1.orcon.net.nz (smtp-1.orcon.net.nz [60.234.4.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bMzd3x8FzDqwB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 10:44:45 +1100 (AEDT)
Received: from [121.99.228.40] (port=24388 helo=tower)
 by smtp-1.orcon.net.nz with esmtpa (Exim 4.86_2)
 (envelope-from <mcree@orcon.net.nz>)
 id 1ghjX2-0006MW-NK; Fri, 11 Jan 2019 12:14:37 +1300
Date: Fri, 11 Jan 2019 12:14:31 +1300
From: Michael Cree <mcree@orcon.net.nz>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation
 for y2038
Message-ID: <20190110231431.ho6mjhjkj4p47hww@tower>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
 Arnd Bergmann <arnd@arndb.de>,
 Joseph Myers <joseph@codesourcery.com>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>,
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Rich Felker <dalias@libc.org>, David Miller <davem@davemloft.net>,
 Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Firoz Khan <firoz.khan@linaro.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 alpha <linux-alpha@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-ia64@vger.kernel.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linux-mips@vger.kernel.org,
 Parisc List <linux-parisc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>
References: <20190110162435.309262-1-arnd@arndb.de>
 <alpine.DEB.2.21.1901101808220.31458@digraph.polyomino.org.uk>
 <CAK8P3a2f4SCJXrm6HWO9UKY-akSW+ONNpOvQOtYbia_fRo9ciQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2f4SCJXrm6HWO9UKY-akSW+ONNpOvQOtYbia_fRo9ciQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
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
 Linux-sh list <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 Joseph Myers <joseph@codesourcery.com>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 11:42:32PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 10, 2019 at 7:10 PM Joseph Myers <joseph@codesourcery.com> wrote:
> >
> > On Thu, 10 Jan 2019, Arnd Bergmann wrote:
> >
> > > - Add system calls that have not yet been integrated into all
> > >   architectures but that we definitely want there.
> >
> > glibc has a note that alpha lacks statfs64, any plans for that?
> 
> Good catch, I missed that because all other 64-bit architectures
> have a statfs() call with 64-bit fields. I see that it also has an
> osf_statfs64 structure and system call with lots of padding and some
> oddly sized fields: f_type, f_flags and f_namemax are only 16 bits
> wide, the rest is all 64-bit.
> 
> Adding the regular statfs64() should be easy enough, we just need to
> decide which layout to use:
> 
> a) use the currently unused 'struct statfs64' as provided by the
>     alpha uapi headers, which has a 32-bit __statfs_word but
>     64-bit f_blocks, f_bfree, f_bavail, f_files, and f_ffree.
> 
> b) copy asm-generic/statfs.h to the alpha asm/statfs.h and
>     change statfs64 to have the regular layout that we use
>     on all other 64-bit architectures, using all 64-bit fields.
> 
> The other open question for alpha (as mentioned in one of the
> patches I sent) would be whether to add get{eg,eu,g,p,pp,u}id()
> with the regular calling conventions.

I would be interested in seeing those provided on Alpha.  There are
a handful of projects choosing to sidestep glibc for these syscalls
and they break on Alpha.  Such projects are never keen to include
special assembler code (because the extant syscalls on Alpha are not
C ABI compliant) to support a legacy arch.

Cheers
Michael.
