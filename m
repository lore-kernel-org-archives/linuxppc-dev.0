Subject: Re: 2.4.19 on dual 1gig G4 funny slow down to kernel death
	experience
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <200302071629.28657.kevin.hendricks@sympatico.ca>
References: <200302071629.28657.kevin.hendricks@sympatico.ca>
Content-Type: text/plain
Message-Id: <1044710873.9705.106.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 08 Feb 2003 14:27:54 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-02-07 at 22:29, Kevin B. Hendricks wrote:

> I just experienced the funny slow down until kernel death experience again
> that I reported many months ago on my dual 1gig G4 machine (smp with 768
> meg of memory)
>
> The dmesg log is full of a long stream of the following
>
> wait_on_irq, CPU 0:
> irq:  -1 [0 0]
> bh:   0 [0 0]

Argh !

The global irq count should never _ever_ get to -1, that's very bad...

Either some weird codepath I haven't manage to figure out, or,
and that's what I'm afraid of, for some reasons, atomic operations
between CPUs failed, which should obviously never happen !

Remind me which rev of the CPU it is ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
