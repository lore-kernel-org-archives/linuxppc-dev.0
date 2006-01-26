Return-Path: <David.Hunter@ipc.com>
Received: from stsnycon1.corp.root.ipc.com (ipcny.ipc.com [65.244.37.61])
	by ozlabs.org (Postfix) with ESMTP id 4566968A9E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jan 2006 08:10:34 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: mpc8260 fcc enet transmit time out
Date: Thu, 26 Jan 2006 15:58:25 -0500
Message-ID: <9A63F321BC93984690A3CA6A1652C2ED0BC64500@exnanycmbx1.corp.root.ipc.com>
From: "Hunter, David" <David.Hunter@ipc.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

One day, hubert.loewenguth at thales-bm.com wrote:
> Everything works fine, but, if I do successive plugs/unplugs during=20
> important data transfert, The driver enter into an infinite loop:
> ...
> Is there anybody having encounter the same problem?
> Is there anybody having done some test of  numerous plug/unplug
during=20
> important data transfert with a half-duplex connection on mpc8260?
> Is there anybody having an idea to help me ?

I have seen many symptoms involving the "NETDEV WATCHDOG: eth0: transmit
timed out" message, but so far I do not have a code fix for any of them.
:(

We (my employer) use an MPC8270 (mask 2K49M) and LXT971A PHY, with Linux
2.4.18.  In our case we do have MII PHY interrupt.  Like you, when I get
the transmit timeout, it repeats forever.  But I do not see the problem
when doing successive plugs/unplugs of the Ethernet cable.  Instead, I
get timeout during normal board operation, without human interaction.

In one customer site where our MPC8270 board is used, the customer uses
100 Mb half duplex Ethernet.  During many weeks of normal operation,
several times the board did experience transmit timeout.  One of the
times, this was output:

<-------- DUMP STARTS HERE ---------->
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx c01aa380 (full) cur_rx c01aa220.
 Tx @base c01aa308 :
9c00 0051 070f79a2
1c00 0056 070f7da2
1c00 0056 070f7ea2
1c00 0051 070f7ba2
1c80 003f 070f51c2
9c00 0056 070f50c2
9c00 0051 070f52c2
9c00 0056 070f53c2
9c00 0056 070f55c2
9c00 0051 070f54c2
dc00 0038 070f56c2
9c00 0056 070f57c2
9c00 0051 070f58c2
9c00 0056 070f59c2
9c00 0056 070f5ac2
bc00 0056 070f7ca2
 Rx @base c01aa208 :
9c00 0040 0046f000
<--- snip: BD status are all 9c00 -->
9c00 0040 00461000
9c00 0040 00461800
9c00 0040 00460000
bc00 0040 00460800
<---------- DUMP ENDS HERE ---------->

Note that one TxBD has the status 0x1c80, indicating late collision
(BD_ENET_TX_LC).  This is an unusual condition in Ethernet, but recovery
should still be possible.  Like you, I suspect errata CPM 119, but I
have not tried the patch yet.  (Development schedules and all that
jazz.)

As a workaround, we placed a 10/100 Mb hub between the board and the
customer's network, which negotiated the PHY up to 100 Mb full duplex.
The transmit timeout problem has not been seen since (to the best of my
knowledge.)

Back in the lab I have been able to reproduce the transmit timeout on a
100 Mb full duplex network.  Like you, I added printk output where
fcc_enet_interrupt tests each BD_ENET_TX_* flag.  In one case, I saw
this:

<-------- DUMP STARTS HERE ---------->
eth0: BDP=3Dc01aa370: Carrier lost
eth0: BDP=3Dc01aa370: Carrier lost
eth0: BDP=3Dc01aa330: Carrier lost
eth0: BDP=3Dc01aa360: Carrier lost
eth0: BDP=3Dc01aa348: Carrier lost
eth0: BDP=3Dc01aa310: Carrier lost
eth0: BDP=3Dc01aa318: Carrier lost
<---- Carrier lost repeats 61 more times, random BDP ---->
eth0: BDP=3Dc01aa348: Underrun
eth0: Restarting transmitter!!!

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
<-------- DUMP ENDS HERE ---------->

The Underrun message means TxBD status bit BD_ENET_TX_UN (0x0002) was
set.  The last Tx ring data dump in your post shows the same thing.
That scares me, mainly because I don't know what it means.  Does it mean
the SDMA transfer didn't end on time?  I dunno.  And what the heck is
carrier lost during TX in full duplex mode?  It makes sense for half
duplex mode like your situation, but I can't make sense of it for full
duplex.  Further, the underrun case has only happened once; in most
other cases, I get a transmit timeout wih absolutely no TxBD error bits
whatsoever, and no indication that a TX restart was even attempted.
That's even scarier.  I also did try repeated plug/unplug of Ethernet
during peak normal operation (probably 5-10 Mb traffic) on the 100 Mb
full duplex network, but after 11 successive plugs I did not see any
timeouts.

I'm starting to wonder if I have a cache coherency problem.  The buffer
descriptors are in main RAM and the data cache is turned on...  Its just
a thought I picked up reading some prior posts that I can't rightly
recall.

I noted that the MPC8280 manual (online from Freescale) does now detail
the transmitter recovery procedure (section 30.10.1 FCC Transmit
Errors), and it's not nearly as simple as what fcc_enet.c implements in
any kernel version.  Despite CPM37, they don't toggle GFMR[ENT] in
combination with the RESTART_TX command.  Also, in 30.12.1 FCC
Transmitter Full Sequence, a command (either RESTART_TX or INIT_TRX)
must be issued after GFMR[ENT] is cleared but _before_ it is set.  You
might try changing fcc_enet_interrupt to do this:

	    if (must_restart) {
		volatile cpm8260_t *cp;

		cep->fccp->fcc_gfmr &=3D ~FCC_GFMR_ENT;

		cp =3D cpmp;
		cp->cp_cpcr =3D
		    mk_cr_cmd(cep->fip->fc_cpmpage,
cep->fip->fc_cpmblock,
		    		0x0c, CPM_CR_RESTART_TX) | CPM_CR_FLG;
		while (cp->cp_cpcr & CPM_CR_FLG);

		cep->fccp->fcc_gfmr |=3D  FCC_GFMR_ENT;
	    }

I've not been able to work on the problem for some time (development
schedules and all that jazz), but I'll post my solution if I find one.

-Dave


DISCLAIMER:
Important Notice *************************************************
This e-mail may contain information that is confidential, privileged or =
otherwise protected from disclosure. If you are not an intended =
recipient of this e-mail, do not duplicate or redistribute it by any =
means. Please delete it and any attachments and notify the sender that =
you have received it in error. Unintended recipients are prohibited from =
taking action on the basis of information in this e-mail.E-mail messages =
may contain computer viruses or other defects, may not be accurately =
replicated on other systems, or may be intercepted, deleted or =
interfered with without the knowledge of the sender or the intended =
recipient. If you are not comfortable with the risks associated with =
e-mail messages, you may decide not to use e-mail to communicate with =
IPC. IPC reserves the right, to the extent and under circumstances =
permitted by applicable law, to retain, monitor and intercept e-mail =
messages to and from its systems.
