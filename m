Date: Mon, 4 Sep 2000 11:48:41 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: mlan@cpu.lu, paulus@linuxcare.com.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: improved processor config for G3s
In-Reply-To: <20000903134303.2744@192.168.1.10>
Message-ID: <Pine.HPX.4.10.10009041137010.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 3 Sep 2000, Benjamin Herrenschmidt wrote:

> There's a bit of history about ABE:
>
> Originally, it was not set. At that time, I tried to turn ON the "Store
> Gathering" option of the MPC 106 (grackle) host brigde. I left it a few
> weeks in my kernel and began getting reports of problems, mostly with
> Adaptec cards.
>
> At that time, some apple person told me enabling Store Gathering on the
> bridge was wrong, they had problems with it (various compatibility
> issues), probably due to grackle bugs, but without telling me exactly
> what was going on.
>
> Later on, a Moto person told me there was no known grackle bug about
> store gathering, but that the CPU ABE was needed for proper operations. I
> also suspect that store gathering increase the effect of PCI write
> posting, and older versions of the Adaptec drivers were not correctly
> taking this into account on sime timing critical accesses.

I'd rather take the Moto version. The problem is that store gathering
should be inhibited if there is an eieio instruction between two
successive stores which may be gathered. However, the eieio instruction
is not propagated to the bus by all processors, it is by the 604 and 7400
(and 601 IIRC), not by the 603/603e/750. I can't remember offhand if ABE
enables eieio broadcasts on the 750, but it seems so from what Motorola
claims.

A rule of thumb is the following: fully SMP capable processors broadcast
eieio (and tlbie for that matter), others do not at least by default. On
an UP 750 (SMP 750 are an aberration in any case because of TLB issues),
I'd bet that it is more efficient to let the processor perform store
gathering when it can (an eieio between both stores will prevent it) and
to disable both ABE in the processor and store gathering in the bridge.
This will result in lower processor bus utilization.

	Regards,
	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
