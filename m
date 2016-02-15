Return-Path: <jikos@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BB551A033E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 23:56:47 +1100 (AEDT)
Date: Mon, 15 Feb 2016 13:56:43 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Torsten Duwe <duwe@lst.de>, Balbir Singh <bsingharora@gmail.com>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Jessica Yu <jeyu@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
In-Reply-To: <1455532035.26205.5.camel@ellerman.id.au>
Message-ID: <alpine.LNX.2.00.1602151351590.22727@cbobk.fhfr.pm>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174450.9C065692C8@newverein.lst.de>
 <1455176897.2885.12.camel@gmail.com> <20160211084230.GB29683@lst.de>
 <1455532035.26205.5.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 15 Feb 2016, Michael Ellerman wrote:

> > > > +echo "int func() { return 0; }" | \
> > > > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > > > +    sed -n -e '/func:/,/bl _mcount/p' | grep -q TOC
> > > > +
> > > > +leaf_toc_result=$?
> > > 
> > > leaf_toc_result failed for me with gcc 5. I'll try and grab gcc-6
> > > and give the patches a spin
> > 
> > Don't bother. _All_ gccs are broken in that respect currently.
> 
> I'm not sure where we got our wires crossed on this one, but this is not a gcc
> bug. In fact it's a feature :)
> 
> There is explicit code in gcc to check whether the TOC setup is needed and only
> emit it when it's required. One case where it's *not* required is when the
> function does not TOC accesses. (See rs6000_global_entry_point_needed_p()).

As gcc actually implements a '-mprofile-kernel' option, it's pretty much 
aware of the fact that the inserted space will be used by the kernel for 
inserting a call (as that's the sole point of the whole thing).

Therefore it must not consider any traceable function to be leaf (even 
though it might "look" leaf from the source code); if it does, then the 
mprofile-kernel option is useless.

So I actually would dare to call it a bug.

Thanks,

-- 
Jiri Kosina
SUSE Labs
