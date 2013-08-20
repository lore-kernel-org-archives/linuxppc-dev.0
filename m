Return-Path: <anton@samba.org>
Date: Tue, 20 Aug 2013 20:55:48 +1000
From: Anton Blanchard <anton@samba.org>
To: "David Laight" <David.Laight@ACULAB.COM>
Subject: Re: BUG_ON and gcc don't mix
Message-ID: <20130820205548.1aea966b@kryten>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B72FF@saturn3.aculab.com>
References: <20130820123750.7353f2f1@kryten>
 <20130820043211.GC3430@bubble.grove.modra.org>
 <20130820044534.GD3430@bubble.grove.modra.org>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72FF@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, wschmidt@us.ibm.com,
 Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi David,

> I was thinking that you could add the label after the trap and
> then use '.long 1b-4'. But you'd have to put the asm outside the
> conditional - so that wouldn't work if the condition was more
> complicated and the trap had to be out of line.
> 
> If the trap is out of line, then it could be a long way from
> the surrounding code block - so a label 'nearby' in the C isn't
> any use.
> 
> With fix sized instructions the .text segment of the object files
> could be scanned for trap instructions.

I tried something similar a while ago and the 1b-4 trick worked for
95%+ of cases but we did end up with out of line traps. I hacked
something up to look for an example, tagging the start and the end of a
BUG_ON, and seeing if the trap was in fact out of line:

               asm volatile("1:\n");
               if (x)
                       __builtin_trap();
               asm volatile("2:\n");

And this one popped in arch/powerpc/platforms/powernv/pci-ioda.c:

        1:

        ld 9,0(29)
        rlwinm. 8,9,0,29,30 
        beq- 0,.L287

        2:

...

.L287:
        trap

You could follow branches and look for the trap, but I'm sure you could
construct things that would be very hard to automatically parse, eg
multiple back to back BUG_ON()'s. At that point I figured some gcc help
would be nice :)

Anton
