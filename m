Message-ID: <3BB33EBA.DF2DCA44@imc-berlin.de>
Date: Thu, 27 Sep 2001 16:59:06 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Dan Malek <dan@mvista.com>, John Francis <johnfrancsis@yahoo.com>,
	Greg Johnsong <johnson@research.canon.com.au>
Subject: structs and defs for IDMA on MPC8xx???
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

are threre any structs for IDMA in the recent kernel sources?

I think of something similar to

I am looking for a "IDMA Buffer Descriptor" similar to

/* Buffer descriptors used by many of the CPM protocols.
*/
typedef struct cpm_buf_desc {
	ushort	cbd_sc;		/* Status and Control */
	ushort	cbd_datlen;	/* Data length in buffer */
	uint	cbd_bufaddr;	/* Buffer address in host memory */
} cbd_t;

I need a way to access the IDMA's parameter RAM, which should be located
at IDMA1 base = IMMR+0x3cc0.
Is there a struct to access the "DMA Channel Mode Register (DCMR)" at
IDMA1 + 0x02?

I know Greg Johnson <gjohnson@research.canon.com.au> proposed some stuff
last year. But they never made it into the linuxppc_2_4_devel, did they?

I could think of something like

/* Buffer descriptors used by IDMA
*/
typedef struct idma_buf_desc {
	ushort	ibd_sc;		/* Status and Control */
	unchar	ibd_dfcr;	/* destination function code register, s.20.3.4.1*/
	unchar	ibd_sfcr;	/* source function code register */
	uint	ibd_buflen;	/* "number of bytes to transfer" */
	uint	ibd_srcbuf;	/* "points to the beginning of the source buffer" */
	uint	ibd_destbuf;	/* "points to the beginning of the destination
buffer" */
} ibd_t;

TIA.

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
