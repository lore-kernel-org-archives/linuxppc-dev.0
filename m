Date: Wed, 9 Aug 2000 19:58:31 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Backlight control on Lombard PB
In-Reply-To: <Pine.SOL.3.95.1000809191056.5966B-100000@juliet>
Message-ID: <Pine.LNX.4.10.10008091940260.23221-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Should be fixed in BenH's current tree, he said he was going to do it this
> > past weekend. The pmu backlight controller didn't get registered on the
> > Lombard (and possibly Wallstreet) because the backlight-control property
> > is missing on these machines.
> >
> So we were just lucky that it used to work before?

Nope, it broke because BenH added code to have either the PMU driver or
the atyfb driver register a backlight control callback (depending on where
the power control logic actually resides).

> It should be in the linux-pmac-benh branch then, yeah? I rsynced again
> from linuxcare.com.au yesterday (or rather 2:00 UT this morning), and the
> problem still remains. Is there anything else to do, upgrade to a newer
> BootX perhaps, or whatever?

Compile you own kernel, and add a || machine_is_compatible("PowerBook1,1")
right after the || machine_is_compatible("AAPL,PowerBook1999") in
arch/ppc/kernel/pmac_support.c:register_backlight_controller(). That fixed
it for me. I'll resync and see what BenH did there later today.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
