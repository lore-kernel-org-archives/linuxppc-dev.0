Message-Id: <200006061136.NAA01541@piglet.grunz.lu>
Date: Tue, 6 Jun 2000 13:36:07 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2940UW & 2.4.0-test-ac7 PCI probs
To: toa@pop.agri.ch
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <393C9EAA.24AF8B28@pop.agri.ch>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On   6 Jun, this message from Andreas Tobler echoed through cyberspace:
>> Get either my PCI patches or Geert's patches posted here a few hours
>> ago. Then enable hotswap (still needed, right, Geert?), and the resource
>> code should fix any collisions it finds.
>
> Fine, I had to take yours, I wasn't able to apply Geerts one. (Too late/
> too tired ???)
> I applied the one for 2.3.99p9 to 2.4.0-test1-ac7, success, including
> your serial console patch and Takashi's mftb patch for 601 CPU's.
> Below the output. I think now I am in the same situation as other
> adaptec users on the linux front.

See below; I've spotted one thing that probably breaks.

> One Q, hotswap == hotswap PCI in 'General Setup'?

Yes, but it is not needed, I think.

>   for root[0:ffffffff] min[1000] size[100]
>   got res[1000:10ff] for resource 0

This must be the conflicting resource, but it gets an equally-wrong new
address :-(( In fact, the PCI resource code still misses a patch to make
the correct resources available to the resource allocation code (so that
IO regions can be taken out of the IO region of the correct PCI bus..)

I'm still working on that part ;-)

So if the SCSI driver actually uses the IO region, it will most
certainly not work....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
