Date: Fri, 29 Sep 2000 13:28:14 +0200 (MEST)
From: Tobias Otto-Adamczak <tobias.otto-adamczak@e-technik.tu-chemnitz.de>
To: Gérard Guével <gguevel@interfaceconcept.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hdlc driver for SCC port
In-Reply-To: <000001c029ea$0682dee0$2901a8c0@none>
Message-ID: <Pine.LNX.4.21.0009291323090.13421-100000@odoaker.hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Now I have a linux2.2.14 kernel which runs on my MPC860P board.
> I would want to customize an hdlc driver on scc.
> Some help about what exists (structure, driver, howto, ...) would be
> welcome.

I need to handle HDLC for my ISDN project on an MBX board. Progress is
slowly, because I am no expert. At the moment I can give away this
addition to commproc.h:

--- snip --------------------------------------------------------------

/*********   SCC parameter RAM for HDLC mode   *********/
typedef struct scc_hdlc {
	sccp_t	scc_gen;	/* generic SCC parameters */
	uint	scc_res1;	/* reserved */
	uint	scc_cmask;	/* CRC mask */
	uint	scc_cpres;	/* CRC preset */
	ushort	scc_disfc;	/* discarded frame counter */
	ushort	scc_crcec;	/* CRC error counter */
	ushort	scc_abtsc;	/* abort sequence counter */
	ushort	scc_nmarc;	/* nonmatching address receive counter */
	ushort	scc_retrc;	/* frame retransmission counter */
	ushort	scc_mflr;	/* Max frame length register */
	ushort	scc_maxcnt;	/* internal */
	ushort	scc_rfthr;	/* received frames threshold */
	ushort	scc_rfcnt;	/* internal */
	ushort	scc_hmask;	/* HDLC address mask register */
	ushort	scc_haddr1;	/* HDLC address register 1 */
	ushort	scc_haddr2;	/* HDLC address register 2 */
	ushort	scc_haddr3;	/* HDLC address register 3 */
	ushort	scc_haddr4;	/* HDLC address register 4 */
	ushort	scc_tmp;	/* internal */
	ushort	scc_tmp_mb;	/* internal */
} scc_hdlc_t;

--- snip --------------------------------------------------------------

Ciao - Tobias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
