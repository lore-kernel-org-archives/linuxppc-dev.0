Date: Thu, 5 Feb 2004 01:47:07 +1100
From: Anton Blanchard <anton@samba.org>
To: Peter Bergner <bergner@vnet.ibm.com>
Cc: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	joakim.tjernlund@lumentis.se, linuxppc-dev@lists.linuxppc.org
Subject: Re: TASK_UNMAPPED_BASE
Message-ID: <20040204144707.GK19011@krispykreme>
References: <000501c3ea56$60935060$0a01a8c0@LUMENTIS02> <6.0.2.0.2.20040203161335.035fde58@mail.lauterbach.com> <1075905440.2895.23.camel@otta.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075905440.2895.23.camel@otta.rchland.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> I've seen problems with HPC apps/benchmarks with huge bss's that fail to
> run because TASK_UNMAPED_BASE is set too low.  I'll admit they fail to
> run due to a bug in the fs/binfmt_elf.c, but the fix has never been
> accepted yet.  The bug is that we don't reserve the bss region for the
> app (via a set_brk/do_brk call) until after we've loaded the loader so
> they get mapped to overlapping memory locations.  The fix is to move the
> update to current->mm.* and the set_brk/do_brk call to before the point
> we call load_elf_interp().
>
> Another bug is that the calls to set_brk/do_brk in fs/binfmt_elf.c fail to
> check whether the set_brk/do_brk calls succeeded or not, so they implicitly
> assume they do.  With an app with a huge bss, the set_brk/do_brk call actually
> returns -ENOMEM which is then ignored.  The fix is to test for failure from
> the set_brk/do_brk calls.

A patch went into 2.6 that should fix both of these problems. Give all
those nasty test cases another run :)

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
