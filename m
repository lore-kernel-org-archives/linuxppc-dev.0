Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02F281A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 23:19:09 +1100 (AEDT)
Date: Wed, 27 Jan 2016 13:19:04 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v6 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
Message-ID: <20160127121904.GB32095@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160127215112.080eec56@cotter.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160127215112.080eec56@cotter.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 27, 2016 at 09:51:12PM +1100, Balbir Singh wrote:
> On Mon, 25 Jan 2016 16:38:48 +0100
> Torsten Duwe <duwe@lst.de> wrote:
> 
> > Changes since v5:
> >   * extra "std r0,LRSAVE(r1)" for gcc-6
> >     This makes the code compiler-agnostic.
> >   * Follow Petr Mladek's suggestion to avoid
> >     redefinition of HAVE_LIVEPATCH
> 
> I looked at the patches - well mostly patches 1 and 2, some quick questions
> 
> 1. I know -mprofile-kernel is a big optimization win, do we need it or can
> we incrementally add it?

There's a reason why these are first ;-)
The following ones assume -mprofile-kernel is used.
The disadvantage is all relevant registers need to be saved before calling
further C code in between functions. On the Pro side, no stack frame has been
created at that point. These are assumptions made all over the ftrace-with-regs
and live patching code here.

> 2. Some of the hardcoded checks for opcode are hard to review, I know they've
> been there in similar forms for a while. May be as an iterative step we should
> give the numbers some meaning and use proper helpers for it.

Yes, Michael has already criticised that. No further literal hex constants, I promise.

> I am going to give the patches a spin

Thanks! Make sure you use a compiler that can disable -mprofile-kernel with "notrace".

	Torsten
