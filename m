Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C453C1A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 23:48:58 +1100 (AEDT)
Date: Tue, 26 Jan 2016 13:48:53 +0100
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Torsten Duwe <duwe@lst.de>, Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 8/9] Implement kernel live patching for ppc64le (ABIv2)
Message-ID: <20160126124853.GL3305@pathway.suse.cz>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170804.A11DB692DD@newverein.lst.de>
 <alpine.LNX.2.00.1601261142190.24510@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1601261142190.24510@pobox.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 2016-01-26 11:50:25, Miroslav Benes wrote:
> 
> [ added Petr to CC list ]
> 
> On Mon, 25 Jan 2016, Torsten Duwe wrote:
> 
> >   * create the appropriate files+functions
> >     arch/powerpc/include/asm/livepatch.h
> >         klp_check_compiler_support,
> >         klp_arch_set_pc
> >     arch/powerpc/kernel/livepatch.c with a stub for
> >         klp_write_module_reloc
> >     This is architecture-independent work in progress.
> >   * introduce a fixup in arch/powerpc/kernel/entry_64.S
> >     for local calls that are becoming global due to live patching.
> >     And of course do the main KLP thing: return to a maybe different
> >     address, possibly altered by the live patching ftrace op.
> > 
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> Hi,
> 
> I have a few questions...
> 
> We still need Petr's patch from [1] to make livepatch work, right? Could 
> you, please, add it to this patch set to make it self-sufficient?
> 
> Second, what is the situation with mcount prologue between gcc < 6 and 
> gcc-6? Are there only 12 bytes in gcc-6 prologue? If yes, we need to 
> change Petr's patch to make it more general and to be able to cope with 
> different prologues. This is unfortunate. Either way, please mention it 
> somewhere in a changelog.

I am going to update the extra patch. There is an idea to detect the
offset during build by scrips/recordmcount. This tool looks for the
ftrace locations. The offset should always be a constant that depends
on the used architecture, compiler, and compiler flags.

The tool is called post build. We might need to pass the constant
as a symbol added to the binary. The tool already adds some symbols.


Best Regards,
Petr
