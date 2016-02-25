Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 977B91A0063
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 02:11:51 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ADB70140322
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 02:11:16 +1100 (AEDT)
Date: Thu, 25 Feb 2016 16:11:13 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 pmladek@suse.com, jeyu@redhat.com, jkosina@suse.cz,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 07/12] powerpc/ftrace: FTRACE_WITH_REGS implementation
 for ppc64le
Message-ID: <20160225151113.GK21932@lst.de>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-7-git-send-email-mpe@ellerman.id.au>
 <56CE4F7B.7050704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56CE4F7B.7050704@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2016 at 11:48:59AM +1100, Balbir Singh wrote:
> > @@ -608,6 +621,9 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
> >  					return -ENOENT;
> >  				if (!restore_r2((u32 *)location + 1, me))
> >  					return -ENOEXEC;
> > +				/* Squash the TOC saver for profiler calls */
> > +				if (!strcmp("_mcount", strtab+sym->st_name))
> > +					SQUASH_TOC_SAVE_INSN(value);
> I don't think we need this anymore, do we?

I'm not sure. Once a module is loaded, are all the "bl _mcount"s NOPed out
before any of its functions are run? If not, the _mcount trampoline will
be used, and it must not save R2!

	Torsten
