Message-ID: <3A64C78E.90633885@mvista.com>
Date: Tue, 16 Jan 2001 17:13:34 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: frowand@mvista.com
CC: Ralph Blach <rcblach@raleigh.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel mapping
References: <3A63840E.4C724E03@mvista.com> <3A63BAFB.80E3980C@mvista.com> <3A643283.A20200E8@raleigh.ibm.com> <3A647BC7.15F669F3@mvista.com> <3A64A751.8AA527CF@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank Rowand wrote:

> At the moment, the 405 processors _require_ kernel memory to be
> pinned because the tlb miss handlers use virtual addresses.

I changed that, too.  It works like the other processors, in
particular, the 8xx.

> .........  Then when I started seeing info
> about the 440 I backed away from that plan because the 440 always
> runs with the MMU enabled.  I'm still thinking about the 440...


No way....Dammit can't you IBM guys follow your own rules :-).

> I pinned some IO ranges as a convenience when I was first porting
> to the 405gp but plan to remove those pins.

Those are actually performace advantages, and I am doing that
on some 8xx applications.  The difference now is we don't have
to actually allocate specific "pinned" entries, the large mapping
will just happen as part of the TLB reload.

> I think that's a good idea.  If you do so, please provide a way to
> force an entry to be locked in the tlb.

Nope.  I don't want to do that.  Then you have to make processor
specific trade offs, or incur high management overhead like the
405 does now.  For example, some of the processors allow a fixed
number of locked entries, but you have to trade off what you will
put there against losing TLB entries.  Or, you do like the 405
does and create a "software" locking, losing the use of some
very functional TLB management instructions.

By not locking entries and using large page table entries you don't
need to have processor unique configurations that are cumbersome
or unworkable on lesser featured processors.  You also let the
system operation find the best distribution of TLB entries.  Yes,
there is a clearly visible latency concern with loading TLBs, but
considering the amount of context we are switching these days a
single large page TLB miss is insignificant.

> I've toyed with the variable pages sizes idea too, and it just hasn't
> moved up high enough on my priority list.  I'm not sure I'm quite as
> pessimistic as you about whether it will ever happen


It's going to happen with the 405 merge.  It has to because I have
already screwed up and coded myself into a corner, and I want the
same features on the 8xx already as well.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
