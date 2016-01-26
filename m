Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBE751A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 00:56:25 +1100 (AEDT)
Date: Tue, 26 Jan 2016 14:56:21 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 8/9] Implement kernel live patching for ppc64le (ABIv2)
Message-ID: <20160126135621.GA28664@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170804.A11DB692DD@newverein.lst.de>
 <alpine.LNX.2.00.1601261142190.24510@pobox.suse.cz>
 <20160126124853.GL3305@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160126124853.GL3305@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 26, 2016 at 01:48:53PM +0100, Petr Mladek wrote:
> On Tue 2016-01-26 11:50:25, Miroslav Benes wrote:
> > 
> > We still need Petr's patch from [1] to make livepatch work, right? Could 
> > you, please, add it to this patch set to make it self-sufficient?

It's Petr's patch, I don't want to decide how to best tackle this, see below.
I think Michael is already aware that it is needed, too.

> > Second, what is the situation with mcount prologue between gcc < 6 and 
> > gcc-6? Are there only 12 bytes in gcc-6 prologue? If yes, we need to 

Precisely, it's commit e95d0248daced44 (in http://repo.or.cz/official-gcc.git)
or svn trunk change 222352 "No need for -mprofile-kernel to save LR to stack."
It's efficient, I like it.

> I am going to update the extra patch. There is an idea to detect the
> offset during build by scrips/recordmcount. This tool looks for the
> ftrace locations. The offset should always be a constant that depends
> on the used architecture, compiler, and compiler flags.

My first idea was to check for compiler version defines, but some vendors
are rumoured to patch their compilers ;-)

> The tool is called post build. We might need to pass the constant
> as a symbol added to the binary. The tool already adds some symbols.

That's even better.
Thanks!
	Torsten
