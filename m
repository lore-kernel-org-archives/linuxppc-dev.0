From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15287.46303.790901.552531@cargo.ozlabs.ibm.com>
Date: Mon, 1 Oct 2001 10:12:15 +1000 (EST)
To: "KOBAYASHI R. Taizo" <tkoba@ike-dyn.ritsumei.ac.jp>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem serial.c on module
In-Reply-To: <20010928.143301.74755222.tkoba@ike-dyn.ritsumei.ac.jp>
References: <20010928.143301.74755222.tkoba@ike-dyn.ritsumei.ac.jp>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


KOBAYASHI R. Taizo writes:

> I examined this problem and had a question.
> Dose it need following branch?
> ================L5375==
> #ifdef CONFIG_ALL_PPC
>         /* early PowerMacs would machine check */
>         if (_machine == _MACH_Pmac) {
>                 printk(KERN_INFO "serial.c: nothing to do on PowerMacs.\n");
>                 return 0;
>         }
> #endif
> =======================

That code has been on my hit-list for quite a while now.  It's been
one of those situations where someone thinks that someone else had a
problem that was fixed by that code.  Unless someone can email me
specifically with a situation where that code fixes a real problem,
that code will get deleted shortly.  And if there is a real problem I
will try to find a better way to solve it that that code.

The only valid concern I have heard so far is Ben's comment that OF
might have put some other PCI device at the I/O port addresses that
are probed by the serial driver.  If this has actually been a problem
for anyone I would like to hear the details.

Ultimately we should move to a scheme where each platform registers
its serial ports early on in the initialization.

> -static int __devinit
> +static int
> +#ifndef MODULE
> +__devinit
> +#endif
>  pci_plx9050_fn(struct pci_dev *dev, struct pci_board *board, int enable)

This change is ugly and should be unnecessary.  What was this trying
to achieve?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
