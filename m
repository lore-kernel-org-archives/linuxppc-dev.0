Message-ID: <B25E2E5A003CD311B61E00902778AF2A02637AAA@SERVER1>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'Steven Scholz '" <steven.scholz@imc-berlin.de>,
	"'LinuxPPC '" <linuxppc-embedded@lists.linuxppc.org>,
	"'Dan Malek '" <dan@mvista.com>,
	"'John Francis '" <johnfrancsis@yahoo.com>,
	"'Greg Johnsong '" <johnson@research.canon.com.au>
Subject: RE: structs and defs for IDMA on MPC8xx???
Date: Mon, 1 Oct 2001 19:42:56 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

You can find IDMA parameter ram description and lots of
useful masks in from motorola web site --

http://www.mot.com/SPS/RISC/netcomm/tools/index.html

Anyway this is what I have used --

/*IDMA parameter RAM			             */
/*---------------------------------------------------*/

/* IDMA Parameter RAM type defintion: */
typedef struct {
        unsigned short  IBASE;
        unsigned short  DCMR;
        unsigned long   SAPR;
        unsigned long   DAPR;
        unsigned short  IBPTR;
        unsigned short  WRITE_SP;
        unsigned long   S_BYTE_C;
        unsigned long   D_BYTE_C;
        unsigned long   S_STATE;
        unsigned long   ITEMP[4];
        unsigned long   SR_MEM;
        unsigned short  READ_SP;
        unsigned short  DIFF;
        unsigned short  TEMPPTR;
        unsigned short  SR_MEM_COUNT;
        unsigned long   D_STATE;
} IDMA_PAR_RAM_T;


/* Buffer descriptor type definition: */
typedef struct {
        union {
                unsigned long ulValue;
                struct {
                unsigned uValid         : 1;
                        /* Valid, ready for processing */
                unsigned uReserved      : 1;
                unsigned uWrap          : 1;
                        /* Wrap. Marks the end of the BD table */
                unsigned uInterrupt : 1;
                /* Enable the maskable auxiliary-done (AD) interrupt */
                        unsigned uLast          : 1;
                /* Marks end of a buffer chain. Enables DONE interrupt */
                        unsigned uReserved2     : 1;
                        unsigned uContinous     : 1;
               /* Selects continous mode. (See 20.3.4 in MPC860 manual) */
                        unsigned uReserved3     : 9;
                        /* Begin DFCR definition: */
                        unsigned uReserved4    : 3;
                                        /* Should be zero */
                        unsigned uByteOrderDFCR : 2;
                           /* 0x1 = PPC Little Endian. 0x2 = Big Endian */
                        unsigned uAddrTypeDFCR  : 3;
                           /* Function code for AT[0-3] */

                        /* Begin SFCR definition: */
                        unsigned uReserved5 : 3;
                                    /* Should be zero */
                        unsigned uByteOrderSFCR : 2;
                       /* 0x1 = PowerPC Little Endian. 0x2 = Big endian */
                        unsigned uAddrTypeSFCR  : 3;
                       /* Function code for AT[0-3] */
                } bits;
        } SAC_FCR; /* Status and control, plus function code egisters. */
        unsigned long  ulBuffLen;
        void          *pvSource;
        void          *pvDest;
} DMABD_T;

#define CPM_CR_IDMA_INIT        ((ushort)0x0005)
#define CPM_CR_IDMA_STOP        ((ushort)0x000B)
#define CPM_CR_CH_IDMA1 ((ushort)0x0001)      /* I2C and IDMA1 */
#define CPM_CR_CH_IDMA2 ((ushort)0x0005)     /* SPI / IDMA2 / Timers */

#define CPMVEC_IDMA1            ((ushort)0x15)
#define CPMVEC_IDMA2            ((ushort)0x14)

-----Original Message-----
From: Steven Scholz
To: LinuxPPC; Dan Malek; John Francis; Greg Johnsong
Sent: 9/27/01 7:59 AM
Subject: structs and defs for IDMA on MPC8xx???


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
	unchar	ibd_dfcr;	/* destination function code register,
s.20.3.4.1*/
	unchar	ibd_sfcr;	/* source function code register */
	uint	ibd_buflen;	/* "number of bytes to transfer" */
	uint	ibd_srcbuf;	/* "points to the beginning of the
source buffer" */
	uint	ibd_destbuf;	/* "points to the beginning of the
destination
buffer" */
} ibd_t;

TIA.

Cheers,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
