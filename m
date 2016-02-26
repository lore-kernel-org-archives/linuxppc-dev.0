Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EDB411A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 21:14:09 +1100 (AEDT)
Message-ID: <1456481641.25691.5.camel@ellerman.id.au>
Subject: Re: [PATCH 07/12] powerpc/ftrace: FTRACE_WITH_REGS implementation
 for ppc64le
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>, Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz,  linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  live-patching@vger.kernel.org, mbenes@suse.cz
Date: Fri, 26 Feb 2016 21:14:01 +1100
In-Reply-To: <20160225151113.GK21932@lst.de>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-7-git-send-email-mpe@ellerman.id.au>
 <56CE4F7B.7050704@gmail.com> <20160225151113.GK21932@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-25 at 16:11 +0100, Torsten Duwe wrote:
> On Thu, Feb 25, 2016 at 11:48:59AM +1100, Balbir Singh wrote:

> > > @@ -608,6 +621,9 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
> > >  					return -ENOENT;
> > >  				if (!restore_r2((u32 *)location + 1, me))
> > >  					return -ENOEXEC;
> > > +				/* Squash the TOC saver for profiler calls */
> > > +				if (!strcmp("_mcount", strtab+sym->st_name))
> > > +					SQUASH_TOC_SAVE_INSN(value);
> > I don't think we need this anymore, do we?
>
> I'm not sure. Once a module is loaded, are all the "bl _mcount"s NOPed out
> before any of its functions are run? If not, the _mcount trampoline will
> be used, and it must not save R2!

With dynamic ftrace, yes they are all nop'ed out before the module runs. See
ftrace_module_init() called from load_module().

But with static ftrace they are just left as-is.

As this series is currently written you can't enable mprofile-kernel with
static ftrace. But that's a bit fragile, someone could easily send a patch to
enable it for static ftrace and we'd probably merge it without thinking about
this code. So I'll leave this as is for now, and we will clean it up once the
series is in.

cheers
