From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>
Cc: <paulus@linuxcare.com.au>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PATCH: improved processor config for G3s
Date: Sun, 3 Sep 2000 15:43:03 +0200
Message-Id: <20000903134303.2744@192.168.1.10>
In-Reply-To: <200009031303.PAA00901@piglet.grunz.lu>
References: <200009031303.PAA00901@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> * Branch History Table (BHTE), Branch Target ICache (BTIC), Dynamic
>   Power Management (DPM) and Store Gathering (SGE) all on,
> * Instruction Cache Throttling Control (ICTC) off.
>
>These were not touched before, but might be worth a discussion:
>
> * Speculative Cache Access Disable (SPD) cleared, Address Brodcast
>   (ABE) enabled
>
>Clearing SPD makes sense since some processor upgrade cards come with an
>OF patch that sets this bit (due to ROM problems... we don't care once
>Linux is up).

There's a bit of history about ABE:

Originally, it was not set. At that time, I tried to turn ON the "Store
Gathering" option of the MPC 106 (grackle) host brigde. I left it a few
weeks in my kernel and began getting reports of problems, mostly with
Adaptec cards.

At that time, some apple person told me enabling Store Gathering on the
bridge was wrong, they had problems with it (various compatibility
issues), probably due to grackle bugs, but without telling me exactly
what was going on.

Later on, a Moto person told me there was no known grackle bug about
store gathering, but that the CPU ABE was needed for proper operations. I
also suspect that store gathering increase the effect of PCI write
posting, and older versions of the Adaptec drivers were not correctly
taking this into account on sime timing critical accesses.

I finally ended up setting ABE in head.S (along with a few others), but
never uncommented the call to grackle_set_stg() in pmac_pci.c. If someone
want to test if it behaves properly now (the problems reported at that
time were mostly with Adaptec cards in B&W G3s not initializing
properly), I don't have a Grackle-based machine here any more.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
