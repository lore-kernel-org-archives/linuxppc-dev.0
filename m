Date: Wed, 13 Sep 2000 11:21:53 +0200 (MEST)
From: Tobias Otto-Adamczak <Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de>
To: Julia Elbert <jelbert@enerdyne.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: no scc_hdlc struct in commproc.h
In-Reply-To: <67505026E29DD311A9AA00508B7315F31956EC@EXCHANGE>
Message-ID: <Pine.LNX.4.21.0009131118150.24289-100000@odoaker.hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Julia,

> I did not find a scc_hdlc structure like scc_enet and scc_uart in
> commproc.h.

I wrote the following one for my project (which is about adding ISDN
functionality for MPC860):

/*********   SCC parameter RAM for HDLC mode   *********/
typedef struct scc_hdlc {
	ushort	scc_rbase;	// Rx Buffer descriptor base address
	ushort	scc_tbase;	// Tx Buffer descriptor base address
	u_char	scc_rfcr;	// Rx function code
	u_char	scc_tfcr;	// Tx function code
	ushort	scc_mrblr;	// Max receive buffer length
	uint	scc_rstate;	// internal
	uint	scc_idp;	// internal
	ushort	scc_rbptr;	// internal
	ushort	scc_ibc;	// internal
	uint	scc_rxtmp;	// internal
	uint	scc_tstate;	// internal
	uint	scc_tdp;	// internal
	ushort	scc_tbptr;	// internal
	ushort	scc_tbc;	// internal
	uint	scc_txtmp;	// internal
	uint	scc_rcrc;	// internal
	uint	scc_tcrc;	// internal
	// here begins HDLC specific part
	uint	scc_res1;	// reserved
	uint	scc_cmask;	// CRC mask
	uint	scc_cpres;	// CRC preset
	ushort	scc_disfc;	// discarded frame counter
	ushort	scc_crcec;	// CRC error counter
	ushort	scc_abtsc;	// abort sequence counter
	ushort	scc_nmarc;	// nonmatching address receive counter
	ushort	scc_retrc;	// frame retransmission counter
	ushort	scc_mflr;	// Max frame length register
	ushort	scc_maxcnt;	// internal
	ushort	scc_rfthr;	// recceived frames threshold
	ushort	scc_rfcnt;	// internal
	ushort	scc_hmask;	// HDLC address mask register
	ushort	scc_haddr1;	// HDLC address register 1
	ushort	scc_haddr2;	// HDLC address register 2
	ushort	scc_haddr3;	// HDLC address register 3
	ushort	scc_haddr4;	// HDLC address register 4
	ushort	scc_tmp;	// internal
	ushort	scc_tmp_mb;	// internal
} scc_hdlc_t;

Ciao - Tobias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
