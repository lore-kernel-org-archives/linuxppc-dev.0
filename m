From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>
Subject: Re: radeonfb.c flakiness
Date: Sun, 17 Feb 2002 22:51:21 +0100
Message-Id: <20020217215121.3523@smtp.wanadoo.fr>
In-Reply-To: <4BAF45B8-23D3-11D6-B713-0003938E434C@ivey.uwo.ca>
References: <4BAF45B8-23D3-11D6-B713-0003938E434C@ivey.uwo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Even with all of my changes, it seems the DFP screen will randomly stay
>blank under PPC Linux.
>
>Unfortunately, nothing I do can seem to bring it back to life (but all
>of the radeon debug info is absolutely fine).
>
>So some how we are not properly resetting the 7500 card or not properly
>initializing it.

Try removing the bit of code in my radeonfb.c that blast various
registers like MC_FB_LOCATION within a #ifdef CONFIG_ALL_PPC
in radeon_pci_register().

I suspect the sequence for changing those isn't good, the chip may
need some additional reset or delays.

>I can't understnad why the screen simply goes blank immediately after
>the kernel starts to boot.
>
>Ben, you mentioned something about playig with the memory mapping of the
>card.  I see code that does something along those lines in the
>radeonfb.c for screens that have dual heads.
>
>Do you have any ideas I should test to see if they impact the random
>startup blank screen issue (btw the kernel boots fine and I can blindly
>login and shutdown).  Changing VTs from 1 to 2 or 3 has no impact.
>
>Ideas welcome.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
