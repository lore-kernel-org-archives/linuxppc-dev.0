Subject: Re: TASK_UNMAPPED_BASE
From: Peter Bergner <bergner@vnet.ibm.com>
To: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Cc: joakim.tjernlund@lumentis.se, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <6.0.2.0.2.20040203161335.035fde58@mail.lauterbach.com>
References: <000501c3ea56$60935060$0a01a8c0@LUMENTIS02>
	 <6.0.2.0.2.20040203161335.035fde58@mail.lauterbach.com>
Content-Type: text/plain
Message-Id: <1075905440.2895.23.camel@otta.rchland.ibm.com>
Mime-Version: 1.0
Date: Wed, 04 Feb 2004 08:37:21 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-02-03 at 09:22, Franz Sirl wrote:
> At 14:05 03.02.2004, Joakim Tjernlund wrote:
>> I changed TASK_UNMAPPED_BASE to well under 0x01fffffc and it worked as well.
>>
>> My question: Why is TASK_UNMAPPED_BASE=0x30000000 and would changing it to
>> something less, say 0x00100000 be a problem?
>
> Hmm, might work, but it can also break in subtle ways, cause the shared lib
> loading algorithm makes a few assumptions about the used address ranges
> IIRC. But I don't see any use for it if you consider what I said above.

I've seen problems with HPC apps/benchmarks with huge bss's that fail to
run because TASK_UNMAPED_BASE is set too low.  I'll admit they fail to
run due to a bug in the fs/binfmt_elf.c, but the fix has never been
accepted yet.  The bug is that we don't reserve the bss region for the
app (via a set_brk/do_brk call) until after we've loaded the loader so
they get mapped to overlapping memory locations.  The fix is to move the
update to current->mm.* and the set_brk/do_brk call to before the point
we call load_elf_interp().

Another bug is that the calls to set_brk/do_brk in fs/binfmt_elf.c fail to
check whether the set_brk/do_brk calls succeeded or not, so they implicitly
assume they do.  With an app with a huge bss, the set_brk/do_brk call actually
returns -ENOMEM which is then ignored.  The fix is to test for failure from
the set_brk/do_brk calls.

Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
