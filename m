Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxh0V6hkGzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 10:47:22 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id i130so724717pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 17:47:22 -0700 (PDT)
Date: Wed, 20 Sep 2017 09:47:15 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 "Luck, Tony" <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "James E . J . Bottomley" <jejb@parisc-linux.org>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] [RFC] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
Message-ID: <20170920004715.GA6298@jagdpanzerIV.localdomain>
References: <20170916035347.19705-1-sergey.senozhatsky@gmail.com>
 <20170918174432.4fksyzco2g6gczwe@intel.com>
 <20170918183902.GA30752@p100.box>
 <20170919020537.GA16991@jagdpanzerIV.localdomain>
 <f1e7c2b0-8c52-7e21-b311-d886f5c4c20e@gmx.de>
 <20170919200357.GA15803@p100.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170919200357.GA15803@p100.box>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (09/19/17 22:03), Helge Deller wrote:
[..]
> Your implementation of dereference_module_function_descriptor() in
> arch/parisc/kernel/module.c is faulty.
> mod->arch.fdesc_offset is relative to the base address of the module,
> so you need to add to mod->core_layout.base.

aha, got it. I should have figured that out.
many thanks!


> Here is the relevant patch to fix this issue (against mainline).
> Additionally I compare against mod->arch.fdesc_count instead of
> mod->arch.fdesc_max.

hmm, .fdesc_max looked relevant to me. it's count_fdescs() - the
number of R_PARISC_FPTR64 relocation entries.

but ok, will use .fdesc_count.


> Can you please fold it into your patch
> [PATCH 4/5] parisc64: Add .opd based function descriptor dereference
> for the next round?

sure, will fold. + SoB.

I think I'll try to re-spin the series today (or tomorrow, I'm slightly
overloaded with another stuff right now). I've received enough bug reports
no need to wait for another week ;)

	-ss
