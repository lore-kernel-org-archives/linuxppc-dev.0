Return-Path: <tony.luck@gmail.com>
Received: from mail-ve0-x230.google.com (mail-ve0-x230.google.com
 [IPv6:2607:f8b0:400c:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 811731A02C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 09:04:03 +1000 (EST)
Received: by mail-ve0-f176.google.com with SMTP id db12so37267veb.21
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:03:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <539161D6.7020508@hitachi.com>
References: <5387F150.5000307@hitachi.com>
 <20140530031838.17427.75896.stgit@ltc230.yrl.intra.hitachi.co.jp>
 <539161D6.7020508@hitachi.com>
Date: Tue, 17 Jun 2014 16:03:59 -0700
Message-ID: <CA+8MBbJ=piCBmiN_=ycN_kQ4LbZcjz7UXR2Bbohd6z67mghmZg@mail.gmail.com>
Subject: Re: [RFT PATCH -next v3] [BUGFIX] kprobes: Fix "Failed to find
 blacklist" error on ia64 and ppc64
From: Tony Luck <tony.luck@gmail.com>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Content-Type: text/plain; charset=UTF-8
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, sparse@chrisli.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-tip-commits@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, Ingo Molnar <mingo@kernel.org>,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>,
 Chris Wright <chrisw@sous-sol.org>, yrl.pp-manager.tt@hitachi.com,
 akataria@vmware.com, Kevin Hao <haokexin@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, rdunlap@infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl9pf@gmx.de,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 5, 2014 at 11:38 PM, Masami Hiramatsu
<masami.hiramatsu.pt@hitachi.com> wrote:
> Ping?
>
> I guess this should go to 3.16 branch, shouldn't it?
>
> (2014/05/30 12:18), Masami Hiramatsu wrote:
>> On ia64 and ppc64, the function pointer does not point the
>> entry address of the function, but the address of function
>> discriptor (which contains the entry address and misc
>> data.) Since the kprobes passes the function pointer stored
>> by NOKPROBE_SYMBOL() to kallsyms_lookup_size_offset() for
>> initalizing its blacklist, it fails and reports many errors
>> as below.
>>
>>   Failed to find blacklist 0001013168300000

Yes please ... just found this problem on ia64 in mainline
and was happy to see this fix for it.

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony
