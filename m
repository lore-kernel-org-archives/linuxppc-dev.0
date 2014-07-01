Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mail9.hitachi.co.jp (mail9.hitachi.co.jp [133.145.228.44])
 by lists.ozlabs.org (Postfix) with ESMTP id 178F41A0006
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 12:21:11 +1000 (EST)
Message-ID: <53B21B0E.8010707@hitachi.com>
Date: Tue, 01 Jul 2014 11:21:02 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Re: [PATCH v4] [BUGFIX] kprobes: Fix "Failed to find blacklist"
 error on ia64 and ppc64
References: <20140620022307.23075.55858.stgit@kbuild-fedora.novalocal>
 <53B0D61B.9010104@hitachi.com> <1404128176.7888.1.camel@concordia>
In-Reply-To: <1404128176.7888.1.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 sparse@chrisli.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 akataria@vmware.com, linux-tip-commits@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, Ingo Molnar <mingo@kernel.org>,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>,
 Chris Wright <chrisw@sous-sol.org>, yrl.pp-manager.tt@hitachi.com,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 Kevin Hao <haokexin@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 rdunlap@infradead.org, Tony Luck <tony.luck@gmail.com>, dl9pf@gmx.de,
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

(2014/06/30 20:36), Michael Ellerman wrote:
> On Mon, 2014-06-30 at 12:14 +0900, Masami Hiramatsu wrote:
>> Ping? :)
> 
> Yeah sorry. I started looking at this and got dragged into another mess.
> 
> You seem to have duplicated the functionality of arch_deref_entry_point(),
> which was also added for kprobes, and for the same reason - ie. because some
> arches have strange function pointers. Is there some reason you can't use it?

Ah, right! Hmm, it seems some more work to update it. but basically, we can do.
BTW, is there any other users who need to access the actual function entry (for
kallsyms case)?

If so, I guess it'd better to merge this version and replace kprobe's local
arch_deref_entry_point() with generic function_entry() macro.

Thank you,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
