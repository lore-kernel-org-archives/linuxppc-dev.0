Message-ID: <3E08B2E2.3020608@tataelxsi.co.in>
Date: Wed, 25 Dec 2002 00:47:54 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: partial header file for MCC in mpc8260.
Content-Type: multipart/mixed;
 boundary="------------070904010903010705000601"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------070904010903010705000601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
Although not a hardcore kernel programmer, I have partially written some
header information for MCC in mpc8260. Transparent info is missing. HDLC
included.

I will post the code as and when it is complete for the driver part. And
have plans to integrate with the kernel. :-)

meanwhile if somebody wants, feel free to use it. Any suggestion to
improve it is welcome.

report any bugs to me.

Thanks
Om.

--------------070904010903010705000601
Content-Type: text/plain; name="mcc.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mcc.h"

/* mcc.h
* MPC 8260 Multi channel controller definitions
* Copyright (c) 2002 : Omanakuttan.N (omanakuttan@tataelxsi.co.in)
*
*
* This file contains some (partial) structure definitions for mpc8260 MCC.
* All control and status info is available through mpc8260 internal memory map.
* see immap_8260.h for details.
*
*/
#ifndef __MCC_H_
#define __MCC_H_

#include <linux/types.h>
#include <asm/immap_8260.h>

/* MCC global parameters. */
typedef struct mcc_params {
	uint 	mcc_mccbase ;
	ushort 	mcc_mccstate ;		/* reserved for the user */
	ushort 	mcc_mrblr ;			/* maximum receive buffer length, user initialized */
	ushort 	mcc_grfthr ;		/* global receive frame threshold */
	ushort 	mcc_grfcnt ;		/* global receive frame count */
	uint 	mcc_rinttmp	;		/* temporary location for holding Rx int. entry. Reserved for user */
	uint	mcc_data0 ;			/* temp. location for holding data. Used by CP. Reserved for user */
	uint	mcc_data1 ;			/* temp. location for holding data. Used by CP. Reserved for user */
	uint	mcc_tintbase ;		/* Multichannel Tx circular interrupt table base address. */
	uint 	mcc_tintptr	;		/* Ptr to the Tx. circular int. table. */
	uint 	mcc_tinttmp ;		/* Tmp location for holding Tx interrupt queue entry. User must clear this before enabling interrupts */
	ushort	mcc_sctpbase ;		/* internal pointer for super channel table, offset from dpram base */
	ushort 	mcc_res1 ;			/* reserved */
	uint	mcc_cmask32 ;		/* CRC constant for 32 bit crc calculation. User initialized to 0xDEBB20E3 */
	ushort 	mcc_xtrabase ;		/* Ptr to the beginning of the extra param info */
	ushort 	mcc_cmask16 ;		/* CRC constant for 16 bit crc calculation. User initialized to 0xF0B8 */
	uint 	mcc_rinttmp0 ;		/* RINTTMPx. for holding Rx circular int table entry. */
	uint 	mcc_rinttmp1 ;		/* RINTTMPx. for holding Rx circular int table entry. */
	uint 	mcc_rinttmp2 ;		/* RINTTMPx. for holding Rx circular int table entry. */
	uint 	mcc_rinttmp3 ;		/* RINTTMPx. for holding Rx circular int table entry. */
	uint	mcc_rintbase0 ;		/* RINTBASEx  Multi channel Rx circular int table base address. */
	uint 	mcc_rintptr0 ;		/* RINTBASEx  Multi channel Rx circular int ptr */
	uint	mcc_rintbase1 ;		/* RINTBASEx  Multi channel Rx circular int table base address. */
	uint 	mcc_rintptr1 ;		/* RINTBASEx  Multi channel Rx circular int ptr */
	uint	mcc_rintbase2 ;		/* RINTBASEx  Multi channel Rx circular int table base address. */
	uint 	mcc_rintptr2 ;		/* RINTBASEx  Multi channel Rx circular int ptr */
	uint	mcc_rintbase3 ;		/* RINTBASEx  Multi channel Rx circular int table base address. */
	uint 	mcc_rintptr3 ;		/* RINTBASEx  Multi channel Rx circular int ptr */
	uint 	mcc_tstmp ;			/* Temporary place for time stamp */

} mccp_t ;

/* MCC channel extra params */
typedef struct mcc_chnX_params {
	ushort 	mcx_tbase ;			/* TxBD base address */
	ushort 	mcx_tbptr ;			/* TxBD ptr */
	ushort 	mcx_rbase ;			/* RxBD base address */
	ushort 	mcx_rbptr ;			/* RxBD ptr */

} mcxtrp_t ;

/* MCC channel specific HDLC params */
typedef struct mcc_HDLC_params {
	uint	mch_tstate ;		/* Tx internal state. User must write 0xHH80_0000 in order to start Tx */
	uint 	mch_zistate ; 		/* Zero insertion state, or bit stuffing state
								Initialized to 0x1000_0207 for regular channel, and 0x3000_0270 for super channel */
	uint	mch_zidata0	;		/* Zero insertion high word data buffer. User initialized to 0xFFFF_FFFF */
	uint	mch_zidata1	;		/* Zero insertion low word data buffer. User initialized to 0xFFFF_FFFF */
	ushort	mch_tbdflags ;		/* TxBD flags, used by CP, Read only for user */
	ushort	mch_tbdcnt ;		/* Tx internal byte count. Number of remaining bytes in buffer. Used by CP, RO for user */
	uint	mch_tbdptr ;		/* Tx internal data ptr. Ptr to current absolute data channel. Used by CP, RO for user */
	ushort	mch_intmsk ;		/* channel's int. mask flag. */
	ushort	mch_chamr ;			/* channel mode register */
	uint	mch_tcrc ;			/* Tmp. transmit CRC. Used by CP, read only for user. */
	uint	mch_rstate ;		/* Rx. Internal state. To start Rx channel, user must write 0xHH80_0000 to this */
	uint	mch_zdstate ;		/* Zero deletion m/c state. User initialized to 0x00FF_FFE0 for regular channel and
									0x20FF_FFE0 for inverted channel */
	uint	mch_zddata0	;		/* Zero deletion high word data buffer. User initialized to 0xFFFF_FFFF */
	uint	mch_zddata1	;		/* Zero deletion low word data buffer. User initialized to 0xFFFF_FFFF */
	ushort	mch_rbdflags ;		/* RxBD flags. Used by CP, read only for user. */
	ushort	mch_rbdcnt ;		/* Rx internal byte count. No. or remaining bytes in buffer. Used by CP, RO for user */
	uint	mch_rbdptr ;		/* Rx internal date ptr. Points to current absolute data channel. Used by CP, RO for user */
	ushort	mch_mflr ;			/* Max. Frame length reg. Any frame whose size > this is rejected. */
	ushort	mch_maxcnt ;		/* Max length counter. */
	uint	mch_rcrc ;			/* Temp receive CRC */
} mchldcp_t ;

#define MCC_TSTATE_GBL			((u_char) 0x20)
#define MCC_TSTATE_BO_PPC_LE	((u_char) 0x08)		/* powerpc little endian */
#define	MCC_TSTATE_BO_BE		((u_char) 0x10)		/* Big endian */
#define MCC_TSTATE_TC2			((u_char) 0x04)
#define MCC_TSTATE_DTB			((u_char) 0x02)
#define MCC_TSTATE_BDB			((u_char) 0x01)

#define MCC_RSTATE_GBL			((u_char) 0x20)
#define MCC_RSTATE_BO_PPC_LE	((u_char) 0x08)		/* powerpc little endian */
#define	MCC_RSTATE_BO_BE		((u_char) 0x10)		/* Big endian */
#define MCC_RSTATE_TC2			((u_char) 0x04)
#define MCC_RSTATE_DTB			((u_char) 0x02)
#define MCC_RSTATE_BDB			((u_char) 0x01)

#define MCC_CHAMR_MODE_HDLC		((ushort) 0x8000)	/* HDLC mode */
#define MCC_CHAMR_POL			((ushort) 0x4000)
#define MCC_CHAMR_MUSTSET		((ushort) 0x2000)	/* A must set value. All chamr values should OR this */
#define MCC_CHAMR_IDL_EP		((ushort) 0x1000)	/* enable pattern sending */
#define MCC_CHAMR_CRC32			((ushort) 0x0080)	/* CRC 32 bits */
#define MCC_CHAMR_TS			((ushort) 0x0020)	/* Receive Time stamp */
#define MCC_CHAMR_RQN_MSK		((ushort) 0x0018)	/* To get queue, & with this value */

#define MCC_GETRXQ(chamr) ( (((chamr) & (MCC_CHAMR_RQN_MSK)) >> 0x3))
#define MCC_SETRXQ(chamr,n) ( (channel) |= ((n & 0x3) << 0x3) )

#define MCC_GETNOF(chamr) 	( ((channel) & 0x7) )
#define MCC_SETNOF(chamr,n) ( (channel)|((n) & 0x7) )

/* the following are for MCCFx. This is defined in immap_8260.h
 */

/* | gr1 | gr2 | gr3 | gr4 |
	 00    00    00    00

	00 -> used by TDMA
	01 -> used by TDMB
	10 -> used by TDMC
	11 -> used by TDMD
*/

#define MCC_SETGR1TA(mccf) ( (mccf)  &= 0x3f)
#define MCC_SETGR1TB(mccf) ( ((mccf) &= 0x3f) |= 0x40 )
#define MCC_SETGR1TC(mccf) ( ((mccf) &= 0x3f) |= 0x80 )
#define MCC_SETGR1TB(mccf) ( ((mccf) &= 0x3f) |= 0xc0 )

#define MCC_SETGR2TA(mccf) ( (mccf)  &= 0xcf)
#define MCC_SETGR2TB(mccf) ( ((mccf) &= 0xcf) |= 0x10 )
#define MCC_SETGR2TC(mccf) ( ((mccf) &= 0xcf) |= 0x20 )
#define MCC_SETGR2TB(mccf) ( ((mccf) &= 0xcf) |= 0x30 )

#define MCC_SETGR3TA(mccf) ( (mccf)  &= 0xf3)
#define MCC_SETGR3TB(mccf) ( ((mccf) &= 0xf3) |= 0x04 )
#define MCC_SETGR3TC(mccf) ( ((mccf) &= 0xf3) |= 0x08 )
#define MCC_SETGR3TB(mccf) ( ((mccf) &= 0xf3) |= 0x0c )

#define MCC_SETGR4TA(mccf) ( (mccf)  &= 0xfc)
#define MCC_SETGR4TB(mccf) ( ((mccf) &= 0xfc) |= 0x01 )
#define MCC_SETGR4TC(mccf) ( ((mccf) &= 0xfc) |= 0x02 )
#define MCC_SETGR4TB(mccf) ( ((mccf) &= 0xfc) |= 0x03 )

#define MCC_INT_QOV0	((ushort) 0x8000)
#define MCC_INT_RINT0	((ushort) 0x4000)
#define MCC_INT_QOV1	((ushort) 0x2000)
#define MCC_INT_RINT1	((ushort) 0x1000)

#define MCC_INT_QOV2	((ushort) 0x0800)
#define MCC_INT_RINT2	((ushort) 0x0400)
#define MCC_INT_QOV3	((ushort) 0x0200)
#define MCC_INT_RINT3	((ushort) 0x0100)

#define MCC_INT_TQOV	((ushort) 0x0008)
#define MCC_INT_TINT	((ushort) 0x0004)
#define MCC_INT_GUN		((ushort) 0x0002)
#define MCC_INT_GOV		((ushort) 0x0001)


#endif	/* end of #ifndef __MCC_H_ */


--------------070904010903010705000601--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
