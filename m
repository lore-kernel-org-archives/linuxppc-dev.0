Subject: Re: aic7xxx revisited...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alec Wood <alecwood@cs.uchicago.edu>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031219092217.GA20303@uchicago.edu>
References: <20031219092217.GA20303@uchicago.edu>
Content-Type: text/plain
Message-Id: <1071830540.753.3684.camel@gaston>
Mime-Version: 1.0
Date: Fri, 19 Dec 2003 21:42:21 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-12-19 at 20:22, Alec Wood wrote:
> I'm attempting to compile a stock 2.4.23 on my PowerMac G4/667, and
> appear to be hitting the same bug that Ethan Weinstein reported a while
> back.  Have there been any insights into the source of the problem?
>
> I haven't been able to get any good diagnostic information yet (other
> than the SRR1=149030 bit), and Ben's advice on getting xmon to print to
> the screen doesn't appear to be germaine to the newer kernel.
>
> I actually first hit the problem whilst installing YDL 3.0.1 -- the
> installer crashed at every boot until I pulled the SCSI card out
> (Adaptec AHA-7850 (rev 3)).
>
> I've also found that the same crash occurs with both the new and old
> aic7xxx drivers, and also as a compiled-in driver or at insmod time. My
> old 2.4.18 works great (new aic7xxx), but I'd like to get up-to-date...

Try to find all occurences of

#define MMAPIO

in drivers/aic7xxx/* and replace them with

#undef MMAPIO

Then let me know.

Justin Gibbs claim there is a HW bug in the PCI bridge of those machines
causing write coalescing while that shouldn't happen, and he has code
that triggers that crash (a machine check caused by a PCI target abort)
on bridges that have this problem.

While I agree that an early crash is better than silent malfunction, I
still think something weird is going on here, maybe we are misconfiguring
something in the CPU (not broadcasting eieo to the bus) or the apple
nortbridge isn't doing things right... Unfortunately, I haven't had
direct access to HW showing the problem and thus couldn't investigate
more.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
