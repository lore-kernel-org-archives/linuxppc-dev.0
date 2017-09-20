Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xy4xk52DSzDqYP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 02:31:22 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id i23so1386497pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 09:31:22 -0700 (PDT)
Date: Thu, 21 Sep 2017 01:31:17 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Helge Deller <deller@gmx.de>, David Laight <David.Laight@ACULAB.COM>
Cc: 'Sergey Senozhatsky' <sergey.senozhatsky.work@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
 "James E . J . Bottomley" <jejb@parisc-linux.org>,
 Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] [RFC] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
Message-ID: <20170920163117.GA502@tigerII.localdomain>
References: <20170916035347.19705-1-sergey.senozhatsky@gmail.com>
 <20170918174432.4fksyzco2g6gczwe@intel.com>
 <20170918183902.GA30752@p100.box>
 <20170919020537.GA16991@jagdpanzerIV.localdomain>
 <063D6719AE5E284EB5DD2968C1650D6DD007A0D0@AcuExch.aculab.com>
 <a7a0f1f6-781b-eba3-9b81-69b979503990@gmx.de>
 <063D6719AE5E284EB5DD2968C1650D6DD007AF31@AcuExch.aculab.com>
 <b8b35299-cfce-c5dc-536d-b21a71187cc8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b8b35299-cfce-c5dc-536d-b21a71187cc8@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (09/20/17 12:20), Helge Deller wrote:
[..]
> > I've not looked at the specifics case...
> > 
> > Another option is using a struct with a single member and
> > passing it by value.
> 
> Actually, we do already have correct structs which could be referenced:
> parisc: struct Elf64_Fdesc
> ia64:	struct fdesc
> ppc64:	struct ppc64_opd_entry
> 
> One could "#define platform_opd_entry" to each of those depending on the platform and use it.
> It might be misleading though, because the pointer which is handed over to
> dereference_function_descriptor() can be such a pointer but isn't necessary.
> I'll leave it up to Sergey to decide.

Hello,

I think I'll keep 'unsigned long' for now.

	-ss
