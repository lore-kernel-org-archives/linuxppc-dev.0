Date: Wed, 29 Dec 1999 10:04:32 -0500 (EST)
From: "Mark S. Mathews" <mark@absoval.com>
To: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: pcmcia-cs for 8xx
In-Reply-To: <3869B35C.33986836@switchboard.ericsson.se>
Message-ID: <Pine.LNX.3.96.991229095842.12905A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I'm not aware of pcmcia-cs for 8xx, we just have some kernel routines that
we wrote to initialize the 8xx pcmcia registers.  They're not as generic
as I'd like yet, but you're welcome to them.

One thing to beware: We had a problem w/ bus errors (machine check) when
accessing (read and write) the common memory and I/O space on our card.
Dan believes this may have to do with TLB misses.  He thought pinning the
TLB entries for the pcmcia space might fix it.  Unfortunately, we haven't
had the time to try it yet.  Our temporary workaround was to ignore
machine checks generated from pcmcia addresses.

-Mark

On Wed, 29 Dec 1999, Magnus Damm wrote:

> 
> Hello all,
> 
> What's the status about the 8xx pcmcia controller?
> 
> I've played around with my FADS board and boot software.
> The pcmcia stuff works pretty fine. 
> 
> I did a small hack half a year ago to use my pcmcia-ata
> disk as root filesystem using the ide code in Linux.
> That wasn't such a generic solution...
> 
> Wouldn't it be nice to use the pcmcia-cs package?
> Anyone done that already?
> 
> I saw some messages floating around about RPXLite 823.
> Is there anything I should know before I start digging?
> 
> TIA /
> 
> Magnus
> 


Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
