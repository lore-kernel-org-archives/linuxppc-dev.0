Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yL8tV70gLzDqYv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 19:38:10 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id u138so7903621wmu.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 01:38:10 -0700 (PDT)
Date: Mon, 23 Oct 2017 17:38:04 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 6/7] symbol lookup: use new kernel and module
 dereference functions
Message-ID: <20171023083804.GA32339@tigerII.localdomain>
References: <20170930025319.987-1-sergey.senozhatsky@gmail.com>
 <20170930025319.987-7-sergey.senozhatsky@gmail.com>
 <20171004115306.GH20084@pathway.suse.cz>
 <20171019064235.GB449@jagdpanzerIV>
 <20171020130848.GC22070@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171020130848.GC22070@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (10/20/17 15:08), Petr Mladek wrote:
> On Thu 2017-10-19 15:42:35, Sergey Senozhatsky wrote:
> > Sorry for the delay and thanks for taking a look.
> > 
> > I'll try to re-spin the patch set by the end of this week/early next
> > week.
> > 
> > 
> > On (10/04/17 13:53), Petr Mladek wrote:
> > [..]
> > > Note that kallsyms_lookup() and module_address_lookup() is used
> > > in many other situations.
> > 
> > we dereference only things that can be dereferenced.
> > so calling it on already dereferenced address, or address
> > that does need to be dereferenced is OK.
> 
> My concern is that it changes the behavior. It will suddenly return
> another information for addresses that were not dereference before.

OK. I'd be really-really surprised to find out that anyone did
kallsyms_lookup()/module_address_lookup() on func descriptors,
but I understand your concerns. I'll try to keep everything
within vsprintf().

	-ss
