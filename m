Date: Tue, 5 Feb 2002 11:56:18 -0700
From: Val Henson <val@nmt.edu>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Highmem on PPC?
Message-ID: <20020205115618.D6834@boardwalk>
References: <20020204183236.J3277@boardwalk> <20020205125256.16831@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020205125256.16831@mailhost.mipsys.com>; from benh@kernel.crashing.org on Tue, Feb 05, 2002 at 01:52:56PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 05, 2002 at 01:52:56PM +0100, benh@kernel.crashing.org wrote:
>
> >What's the current state of highmem on the G4?  Does it work, not
> >work, kinda work, only work on UP... ?
> >
> >I hope to have a dual 7450 G4 with 1 GB RAM within a week, at which
> >point I'll be able to work on highmem seriously.
>
> It's supposed to work. However, I'm having reports of dual 7450 with
> 1G or 1.5G of RAM locking up, I haven't been able to track those down.
>
> Is this an Apple machine ? The 7450 has a bug that prevents use on
> SMP with HW hash table walk. Apple is supposed to implement a HW
> workaround for this on their machines, but if it's not an Apple machine,
> then you may have to implement software TLB load.

The dual 7450 is an apple machine.  I also have one of our beta
boards, a dual 7410 with 1 GB RAM, and we're planning on having a dual
7450 with 1 GB RAM just as soon as we get the chips.

What's your philosophy about highmem?  We map all lowmem with BATs on
SMP in order to avoid trashing SRR0/SRR1 according to your new comment
in entry.S, but it also mentions "other cpus" without saying which cpu
you're talking about. :) How are you avoiding recursive TLB faults on
the highmem pages themselves?  What cpus did you have in mind when you
wrote the SMP stuff?

I'm currently getting hard crashes on the dual 7410 with highmem.  Not
even the SMI starts xmon.  I'm not sure that it's a software bug,
which is why I'm getting the dual 7450.

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
