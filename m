Message-ID: <39BFAAB3.E6993D3@mvista.com>
Date: Wed, 13 Sep 2000 12:26:27 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tobias Otto-Adamczak <Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de>
CC: Julia Elbert <jelbert@enerdyne.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: no scc_hdlc struct in commproc.h
References: <Pine.LNX.4.21.0009131118150.24289-100000@odoaker.hrz.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tobias Otto-Adamczak wrote:

> /*********   SCC parameter RAM for HDLC mode   *********/

Just a couple of minor comments......

> typedef struct scc_hdlc {

>         ushort  scc_rbase;      // Rx Buffer descriptor base address
>         ushort  scc_tbase;      // Tx Buffer descriptor base address
>         u_char  scc_rfcr;       // Rx function code
>         u_char  scc_tfcr;       // Tx function code
>         ushort  scc_mrblr;      // Max receive buffer length
>         uint    scc_rstate;     // internal
>         uint    scc_idp;        // internal
>         ushort  scc_rbptr;      // internal
>         ushort  scc_ibc;        // internal
>         uint    scc_rxtmp;      // internal
>         uint    scc_tstate;     // internal
>         uint    scc_tdp;        // internal
>         ushort  scc_tbptr;      // internal
>         ushort  scc_tbc;        // internal
>         uint    scc_txtmp;      // internal
>         uint    scc_rcrc;       // internal
>         uint    scc_tcrc;       // internal

This first part of the object is defined by 'scc_param', so the
convention would have been:

typedef struct scc_hdlc {
	sccp_t	scc_hdlc;

Followed by:
>         // here begins HDLC specific part
>         uint    scc_res1;       // reserved

The documentation describes the CPM devices in this way, and it is
a little more clear what is common to the SCC, and what is unique
to the HDLC feature.

....since we aren't writing C++, I also dislike the '//' comment......

I would have made these two changes if it was sent as a patch to
me for inclusion in the source code.....

In fact, I will keep this and include it in the future....Do you have
any code you want to submit along with it?



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
