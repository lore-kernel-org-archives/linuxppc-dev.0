Date: Fri, 30 Nov 2001 11:35:57 -0700
From: Okehee Goh <ogoh@asu.edu>
Subject: Printing out message to a console in MBX860??
In-reply-to: <20011130104542.B8845@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <CPEELCODKANPCLBCAGOFMEKICAAA.ogoh@asu.edu>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_LaP6ARk1zVn9Tg1Uzf7AMg)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Boundary_(ID_LaP6ARk1zVn9Tg1Uzf7AMg)
Content-type: text/plain;	charset="us-ascii"
Content-transfer-encoding: 7bit


 I'm so sorry to post this unrelated message.
....
Hello,
I want to print out some message to console monitor for a debugging from the
application loaded
 at MBX860 through EPPC-Bug.This machine doesn't have any OS and my
application is a kernel.

The port status is the following.

EPPC-Bug>pf
Current Port Assignments:  (LUN: Device-Name Port-Name)

00: FDC37C672-COM     COM1              (Console)

01: MPC8XX-SMC        SMC2

02: MEMORY            CHNL0

According to MBX manual, SMC1 is used as console port.

If it's true, COM1 is using SMC1?

So, I thought I must use SMC'1 UART to print out to a console. Is it
correct?

I tested the application using SMC1' s UART

 by applying a SMC's UART application note provided by Motorola's
website(MPC860COD17).

But It doesn't seem to work. I can't see anything from a console after
executing this test application.

The following is what I did to run this application using SMC1' UART.

-----------

EPPC-Bug>LO 0; X=cat smc1.s3

EPPC-Bug>GO

Effective address: 00080004


--------------
I attached the source code.

Thank you so much for any help.



Okehee

--Boundary_(ID_LaP6ARk1zVn9Tg1Uzf7AMg)
Content-type: application/octet-stream; name=smc1.c
Content-transfer-encoding: QUOTED-PRINTABLE
Content-disposition: attachment; filename=smc1.c

/*-------------------------------------------------------------------=
------=0D=0A* FILENAME:  SMC1.c=0D=0A*=0D=0A* DESCRIPTION:   =0D=0A*=
=0D=0A*   The code in this module provides echo capability on SMC1. I=
t's =0D=0A*   intent is to provide the beginnings of a debug port tha=
t is =0D=0A*   mostly compiler independent. If an ASCII terminal is c=
onnected=0D=0A*   at 9600,N,8,1 on Port 2 (PB3) on the ADS board with=
 no hardware=0D=0A*   control, characters typed on the keyboard will =
be received by=0D=0A*   SMC1 and echoed back out the RS232 port to th=
e ASCII terminal.=0D=0A*   This function was designed and tested on a=
n ADS860 =0D=0A*   development board. Note that if a different baud r=
ate is =0D=0A*   required, there is a header file on the netcomm webs=
ite under =0D=0A*   the General Software category that is labelled "A=
synchronous=0D=0A*   Baud Rate Tables".=0D=0A*=0D=0A* REFERENCES:=
=0D=0A*=0D=0A*   1) MPC860 Users Manual=0D=0A*   2) PowerPC Microproc=
essor Family: The Programming Environments for =0D=0A*      32-Bit Mi=
croprocessors=0D=0A*=0D=0A* HISTORY:=0D=0A*=0D=0A* 27 APR 98  jay    =
initial release=0D=0A*=0D=0A*----------------------------------------=
---------------------------------*/=0D=0A=0D=0A#include "netcomm.h"=
=0D=0A#include "mpc860.h"=0D=0A#include "masks860.h"=0D=0A#include "s=
mc1.h"=0D=0A=0D=0Aint stack[100]=3D0;=0D=0Aint stackTop;=0D=0A=0D=
=0A/***********************/=0D=0A/* Global Declarations */=0D=0A/***=
********************/=0D=0A=0D=0AEPPC  *IMMR;      /* IMMR base point=
er */=0D=0ABDRINGS *RxTxBD;  /* buffer descriptors base pointer */=
=0D=0ALB *SMC1Buffers;  /* SMC1 base pointers */=0D=0A=0D=0A/*-------=
--------------*/=0D=0A/* Function Prototypes */=0D=0A/*--------------=
-------*/=0D=0A=0D=0Avoid  startup(void);=0D=0Avoid  SMC1Init(void);=
=0D=0Avoid  SMC1PutChar(UBYTE);=0D=0AUBYTE SMC1GetChar(void);=0D=0AUB=
YTE SMC1Poll(void);=0D=0Avoid  main(void);=0D=0Avoid  InitBDs(void);=
=0D=0Avoid  EchoChar(void);=0D=0A=0D=0A=0D=0A/*=0D=0Avoid startup (vo=
id)=0D=0A{=0D=0A=09 asm("     =09.global=09_start ");=0D=0A=09 asm("_=
start:=09 ");=0D=0A=09 asm("=09=09addis   r1,r0,stackTop@h");=0D=0A=
=09 asm("=09=09ori     r1,r1,stackTop@l");=0D=0A=0D=0A  main();=0D=
=0A}=0D=0A*/=0D=0A=0D=0A/*-------------------------------------------=
----------------------------------=0D=0A*=0D=0A* FUNCTION NAME:  main=
 =0D=0A*=0D=0A* DESCRIPTION:=0D=0A*=0D=0A*  This is the main function=
 for the SMC1 code.=0D=0A*=0D=0A* EXTERNAL EFFECT: =0D=0A*           =
      =0D=0A* PARAMETERS:  None=0D=0A*=0D=0A* RETURNS: None=0D=0A*=
=0D=0A*--------------------------------------------------------------=
-------------*/=0D=0A=0D=0Avoid main(void)=0D=0A=0D=0A{=0D=0A=0D=0A  =
 /*------------------------*/=0D=0A   /* Establish IMMR pointer */=
=0D=0A   /*------------------------*/=0D=0A      =0D=0A   IMMR =3D (E=
PPC *)(GetIMMR() & 0xFFFF0000);  /* MPC8xx internal register=0D=0A   =
                                             map  */=0D=0A=0D=0A   /*=
--------------------------------------------------------------------*=
/=0D=0A   /* We add 64 bytes to the start of the buffer descriptors b=
ecause     */=0D=0A   /* this code was also tested on the monitor ver=
sion of SDS debugger.  */=0D=0A   /* The monitor program on our targe=
t uses most of the first 64 bytes  */=0D=0A   /* for buffer descripto=
rs. If you are not using the SDS monitor  with */=0D=0A   /* Motorola=
's ADS development board, you can delete 64 below and      */=0D=0A  =
 /* start at the beginning of this particular block of Dual Port RAM.=
  */=0D=0A   /*------------------------------------------------------=
--------------*/=0D=0A=0D=0A   /*----------------------------------*/=
  =0D=0A   /* Get pointer to BD area on DP RAM */=0D=0A   /*---------=
-------------------------*/  =0D=0A      =0D=0A   RxTxBD =3D (BDRINGS=
 *)(IMMR->qcp_or_ud.ud.udata_bd + 64);  =0D=0A=0D=0A   /*------------=
-------------------------------------------------------*/=0D=0A   /* =
Establish the buffer pool in Dual Port RAM. We do this because the*/=
=0D=0A   /* pool size is only 2 bytes (1 for Rx and 1 for Tx) and to =
avoid    */=0D=0A   /* disabling data cache for the memory region whe=
re BufferPool would */=0D=0A   /* reside. The CPM does not recognize =
data in buffer pools once it   */=0D=0A   /* been cached. It's acesse=
s are direct through DMA to external      */=0D=0A   /* memory.      =
                                                     */=0D=0A   /*---=
----------------------------------------------------------------*/=
=0D=0A=0D=0A   SMC1Buffers =3D (LB *)(IMMR->qcp_or_ud.ud.udata_bd + 8=
0);=0D=0A=0D=0A   /*----------------------------------------*/=0D=
=0A   /* Initialize SMC1 and buffer descriptors */=0D=0A   /*--------=
--------------------------------*/=0D=0A=0D=0A   SMC1Init();=0D=0A=
=0D=0A   while (1)=0D=0A=0D=0A   {=0D=0A      /*---------------------=
-----------------------------*/=0D=0A      /* if there is a receive c=
haracter echo it back out */=0D=0A      /*---------------------------=
-----------------------*/=0D=0A=0D=0A      if (SMC1Poll())   /* Check=
 BD status for Rx characters */=0D=0A=0D=0A         EchoChar();=0D=
=0A   }=0D=0A=0D=0A} /* END main */=0D=0A=0D=0A=0D=0A=0D=0A/*--------=
---------------------------------------------------------------------=
=0D=0A*=0D=0A* FUNCTION NAME:  SMC1Init =0D=0A*=0D=0A* DESCRIPTION:=
=0D=0A*=0D=0A*  Initialize SMC1 as a UART at 9600 Baud =0D=0A*  with =
40MHZ CPU clock.=0D=0A*=0D=0A* EXTERNAL EFFECT: =0D=0A*              =
   =0D=0A* PARAMETERS:  None=0D=0A*=0D=0A* RETURNS: None=0D=0A*=0D=
=0A*-----------------------------------------------------------------=
----------*/=0D=0A=0D=0Avoid SMC1Init(void)=0D=0A=0D=0A{=0D=0A=0D=
=0Aunsigned long *bcsr1; =0D=0A   =0D=0A=09/*-----------------------*=
/=0D=0A=09/* Allow SMC1 TX, RX out */=0D=0A=09/*---------------------=
--*/=0D=0A=0D=0A   IMMR->pip_pbpar |=3D (0x03000000);     =0D=0A   IM=
MR->pip_pbdir &=3D 0xFCFFFFFF; =0D=0A=0D=0A   /*---------------------=
---------------------------*/=0D=0A   /* Set Baud Rate to 9600 for 40=
MHz System Clock.  */=0D=0A   /* Enable BRG Count.=09=09=09=09=09=
=09=09=09=09     */=0D=0A   /*---------------------------------------=
---------*/=0D=0A=0D=0A   IMMR->brgc2 =3D (0x00202 | 0x10000);   /* C=
D is 259 for target bd 9600 at 40MHz system */=0D=0A=0D=0A   IMMR->si=
_simode &=3D ~(0x0000F000);    /* SMC1:  NMSI mode */=0D=0A   IMMR->s=
i_simode |=3D 0x00001000;       /* SMC1:  Tx/Rx Clocks are BRG2 */=
=0D=0A=0D=0A=0D=0A   /*----------------------------------------*/=
=0D=0A=09/* Set RXBD table start at Dual Port +800 */=0D=0A=09/*-----=
-----------------------------------*/=0D=0A=0D=0A   IMMR->PRAM[PAGE3]=
.pg.other.smc_dsp1.psmc1.u1.rbase =3D =0D=0A    =0D=0A   (UHWORD)&RxT=
xBD->RxBD;=0D=0A=0D=0A   /*----------------------------------------*/=
=0D=0A=09/* Set TXBD table start at Dual Port +808 */=0D=0A=09/*-----=
-----------------------------------*/=0D=0A=0D=0A   IMMR->PRAM[PAGE1]=
.pg.other.smc_dsp1.psmc1.u1.tbase =3D=09=0D=0A    =0D=0A   (UHWORD)&R=
xTxBD->TxBD;=09    =09=0D=0A=0D=0A   /*------------------------------=
---------*/=0D=0A   /* Initialize Rx and Tx Params for SMC1: */=0D=
=0A   /* Spin until cpcr flag is cleared=09=09  */=0D=0A   /*--------=
-------------------------------*/=0D=0A=0D=0A   for(IMMR->cp_cr =3D 0=
x0091; IMMR->cp_cr & 0x0001;) ;=0D=0A=09=0D=0A   /*------------------=
---------------------*/=0D=0A   /* Initialize SDCR: */=0D=0A   /*----=
-----------------------------------*/=0D=0A   IMMR->dma_sdcr =3D 0x00=
01;=0D=0A   =0D=0A=09/*--------------------------------------*/=0D=
=0A   /* Set RFCR,TFCR -- Rx,Tx Function Code */=0D=0A   /* Normal Op=
eration and Motorola byte   */=0D=0A   /* ordering                   =
          */=0A=09/*--------------------------------------*/=0D=0A=
=0D=0A   IMMR->PRAM[PAGE3].pg.other.smc_dsp1.psmc1.u1.rfcr =3D 0x10; =
 =0D=0A                                                              =
 =0D=0A=0D=0A   IMMR->PRAM[PAGE3].pg.other.smc_dsp1.psmc1.u1.tfcr =
=3D 0x10;  =0D=0A=0D=0A   /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/=0D=0A   =
/* Protocol Specific Parameters */=0D=0A   /*~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~*/=0D=0A=0D=0A   /*---------------------------*/=0D=0A   /* MRB=
LR =3D MAX buffer length */=0D=0A   /*---------------------------*/=
=0D=0A=0D=0A   IMMR->PRAM[PAGE3].pg.other.smc_dsp1.psmc1.u1.mrblr =
=3D 0x0010;    =0D=0A=0D=0A   /*------------------------------------*=
/=0D=0A   /* MAX_IDL =3D Disable MAX Idle Feature */=0D=0A   /*------=
------------------------------*/=0D=0A=0D=0A   IMMR->PRAM[PAGE3].pg.o=
ther.smc_dsp1.psmc1.u1.max_idl =3D 0;  =0D=0A=0D=0A   /*-------------=
------------------------*/=0D=0A   /* BRKEC =3D No break condition oc=
curred */=0D=0A   /*-------------------------------------*/=0D=0A=
=0D=0A   IMMR->PRAM[PAGE3].pg.other.smc_dsp1.psmc1.u1.brkec =3D 0;   =
 =0D=0A=0D=0A   /*---------------------------------------*/=0D=0A   /=
* BRKCR =3D 1 break char sent on top XMIT */=0D=0A   /*--------------=
-------------------------*/=0D=0A=0D=0A   IMMR->PRAM[PAGE3].pg.other.=
smc_dsp1.psmc1.u1.brkcr =3D 0;    =0D=0A=0D=0A=0D=0A   /*------------=
--------*/=0D=0A   /* Initialize the BDs */=0D=0A   /*---------------=
-----*/=0D=0A=0D=0A   InitBDs();=0D=0A=0D=0A   IMMR->smc_regs[SMC1_RE=
G].smc_smce =3D 0xFF;  /* Clear any pending events */=0D=0A=0D=0A   /=
*--------------------------------------------------*/=0D=0A   /* SMC_=
SMCM =3D Mask all interrupts, use polling mode */=0D=0A   /*---------=
-----------------------------------------*/=0D=0A=0D=0A   IMMR->smc_r=
egs[SMC1_REG].smc_smcm =3D 0x17;     =0D=0A=0D=0A   IMMR->cpmi_cicr =
=3D 0;           /* Disable all CPM interrups */=0D=0A   IMMR->cpmi_c=
ipr =3D 0xFFFFFFFF;  /* Clear all pending interrupt events */=0D=0A  =
 IMMR->cpmi_cimr =3D 0;           /* Mask all event interrupts */=
=0D=0A=0D=0A   /*-----------------------------------------------*/=
=0D=0A   /* Enable RS232 interface on ADS board via BCSR1 */=0D=0A   =
/* Get the base address of BCSR                  */ =0D=0A   /*------=
-----------------------------------------*/=0D=0A=0D=0A   bcsr1 =3D (=
UWORD *) ((IMMR->memc_br1 & 0xFFFFFFFE) + 4);    =0D=0A   *bcsr1 &=
=3D 0xFFFB0000;  /* Assert the RS232EN* bit */=0D=0A=0D=0A   /*------=
------------------------------*/=0D=0A   /* 8-bit mode,  no parity, 1=
 stop-bit */=0D=0A   /* UART SMC Mode=09=09=09=09=09=09=09  */=0D=
=0A   /* Normal operation (no loopback),=09  */=0D=0A   /* SMC Transm=
itter/Receiver Enabled=09  */=0D=0A   /*-----------------------------=
-------*/=0D=0A=0D=0A   IMMR->smc_regs[SMC1_REG].smc_smcmr =3D 0x4823=
;=0D=0A=0D=0A} /* END SMC1Init */=0D=0A=0D=0A=0D=0A=0D=0A/*----------=
-------------------------------------------------------------------=
=0D=0A*=0D=0A* FUNCTION NAME:  InitBDs=0D=0A*=0D=0A* DESCRIPTION: Thi=
s function initializes the Tx and Rx Buffer Descriptors.=0D=0A*=0D=
=0A* EXTERNAL EFFECT: RxTxBD=0D=0A*                 =0D=0A* PARAMETER=
S:  None=0D=0A*=0D=0A* RETURNS: None=0D=0A*=0D=0A*-------------------=
--------------------------------------------------------*/=0D=0A=0D=
=0Avoid InitBDs(void)=0D=0A=0D=0A{=0D=0A   /*------------------------=
-----------*/=0D=0A   /* Setup Receiver Buffer Descriptors */=0D=0A  =
 /*-----------------------------------*/=0D=0A   =0D=0A   RxTxBD->RxB=
D.bd_cstatus =3D 0xB000;            /* Enable, Last BD */=0D=0A   RxT=
xBD->RxBD.bd_length =3D 1;=0D=0A   RxTxBD->RxBD.bd_addr =3D &(SMC1Buf=
fers->RxBuffer);=0D=0A=0D=0A=0D=0A   /*------------------------------=
--------*/=0D=0A   /* Setup Transmitter Buffer Descriptors */=0D=0A  =
 /*--------------------------------------*/=0D=0A=0D=0A   RxTxBD->TxB=
D.bd_cstatus =3D 0xB000;      /* Buffer not yet ready; Last BD */=
=0D=0A   RxTxBD->TxBD.bd_length =3D 5;=0D=0A   RxTxBD->TxBD.bd_addr =
=3D &(SMC1Buffers->TxBuffer);=0D=0A=0D=0A=0D=0A} /* END InitBDs */=
=0D=0A=0D=0A=0D=0A=0D=0A/*-------------------------------------------=
----------------------------------=0D=0A*=0D=0A* FUNCTION NAME:  Echo=
Char=0D=0A*=0D=0A* DESCRIPTION: This function facilitates the echoing=
 of a received character.=0D=0A*=0D=0A* EXTERNAL EFFECT: RxTxBD=0D=
=0A*                 =0D=0A* PARAMETERS:  None=0D=0A*=0D=0A* RETURNS:=
 None=0D=0A*=0D=0A*--------------------------------------------------=
-------------------------*/=0D=0A=0D=0Avoid  EchoChar(void)=0D=0A=
=0D=0A{=0D=0A=0D=0AUBYTE mych;=0D=0A=0D=0A   mych =3D SMC1GetChar();=
=0D=0A   SMC1PutChar(mych); =0D=0A  /*SMC1PutChar(1); */=0D=0A=0D=
=0A} /* end EchoChar */=0D=0A=0D=0A=0D=0A/*--------------------------=
---------------------------------------------------=0D=0A*=0D=0A* FUN=
CTION NAME:  SMC1PutChar=0D=0A*=0D=0A* DESCRIPTION: Output a characte=
r to SMC1=0D=0A*=0D=0A* EXTERNAL EFFECT: RxTxBD=0D=0A*               =
  =0D=0A* PARAMETERS:  ch - input character=0D=0A*=0D=0A* RETURNS: No=
ne=0D=0A*=0D=0A*-----------------------------------------------------=
----------------------*/=0D=0A=0D=0Avoid SMC1PutChar(UBYTE ch)=0D=
=0A=0D=0A{=0D=0A   /*-----------------------------------*/=0D=0A=09/*=
 Loop until transmission completed */=0D=0A=09/*---------------------=
--------------*/=0D=0A   =0D=0A   while (RxTxBD->TxBD.bd_cstatus  &  =
0x8000);    =0D=0A   =0D=0A   /*------------*/ =0D=0A=09/* Store data=
 */=0D=0A=09/*------------*/=0D=0A=0D=0A   *(RxTxBD->TxBD.bd_addr) =
=3D ch;                  =0D=0A   RxTxBD->TxBD.bd_length =3D 1;=0D=
=0A=0D=0A   /*---------------*/=0D=0A   /* Set Ready bit */=0D=0A =
=09/*---------------*/=0D=0A=0D=0A   RxTxBD->TxBD.bd_cstatus |=3D 0x8=
000;              =0D=0A=0D=0A=0D=0A} /* END SMC1PutChar */=0D=0A=
=0D=0A=0D=0A=0D=0A/*-------------------------------------------------=
----------------------------=0D=0A*=0D=0A* FUNCTION NAME:  SMC1GetCha=
r=0D=0A*=0D=0A* DESCRIPTION: Get a character from SMC1=0D=0A*=0D=0A* =
EXTERNAL EFFECT: RxTxBD=0D=0A*                 =0D=0A* PARAMETERS:  N=
ONE=0D=0A*=0D=0A* RETURNS: A character from SMC1=0D=0A*=0D=0A*-------=
--------------------------------------------------------------------*=
/=0D=0A=0D=0AUBYTE SMC1GetChar(void)=0D=0A=0D=0A{=0D=0A=0D=0AUBYTE ch=
;   /* output character from SMC1 */=0D=0A   =0D=0A=09/*-------------=
-------*/=0D=0A=09/* Loop if RxBD empty */=0D=0A=09/*----------------=
----*/=0D=0A=0D=0A   while (RxTxBD->RxBD.bd_cstatus  &  0x8000);     =
 =0D=0A=0D=0A=09/*--------------*/=0D=0A   /* Receive data */=0D=0A=
=09/*--------------*/=0D=0A=0D=0A   ch =3D *(RxTxBD->RxBD.bd_addr);  =
 =0D=0A                   =0D=0A=09/*----------------------*/=0D=0A  =
 /* Set Buffer Empty bit */=0D=0A=09/*----------------------*/=0D=
=0A=0D=0A   RxTxBD->RxBD.bd_cstatus |=3D 0x8000;   =0D=0A=0D=0A   ret=
urn ch;=0D=0A=0D=0A} /* END SMC1GetChar */=0D=0A=0D=0A=0D=0A=0D=0A/*-=
---------------------------------------------------------------------=
-------=0D=0A*=0D=0A* FUNCTION NAME:  SMC1Poll=0D=0A*=0D=0A* DESCRIPT=
ION: Poll SMC1 RxBD and check to see if a character was received=0D=
=0A*=0D=0A* EXTERNAL EFFECT: NONE=0D=0A*                 =0D=0A* PARA=
METERS:  NONE=0D=0A*=0D=0A* RETURNS: A one if there is a character av=
ailable in the receive buffer,=0D=0A*          else zero.=0D=0A*=0D=
=0A*-----------------------------------------------------------------=
----------*/=0D=0A=0D=0AUBYTE SMC1Poll(void)=0D=0A=0D=0A{=0D=0A      =
=0D=0A   if(RxTxBD->RxBD.bd_cstatus & 0x8000) =0D=0A   =0D=0A   {=
=0D=0A       return 0;  /*  character NOT available */=0D=0A   } =
=0D=0A   =0D=0A   else=0D=0A   =0D=0A   {=0D=0A       return 1;  /*  =
character IS available */=0D=0A   }=0D=0A=0D=0A} /* END SMC1Poll */=
=0D=0A=0D=0A=0D=0A=0D=0A/*-------------------------------------------=
----------------------------------=0D=0A*=0D=0A* FUNCTION NAME:  GetI=
MMR=0D=0A*=0D=0A* DESCRIPTION: Returns current value in the IMMR regi=
ster.=0D=0A*=0D=0A* EXTERNAL EFFECT: NONE=0D=0A*                 =
=0D=0A* PARAMETERS:  NONE=0D=0A*=0D=0A* RETURNS: The IMMR value in r3=
. The compiler uses r3 as the register =0D=0A*          containing th=
e return value.=0D=0A*=0D=0A*----------------------------------------=
-----------------------------------*/=0D=0A=0D=0AGetIMMR()=0D=0A=0D=
=0A{=0D=0A    asm(" mfspr  r3,638 ");        /* IMMR is spr #638 */=
=0D=0A}=0D=0A=0D=0A=0D=0A=0D=0A=

--Boundary_(ID_LaP6ARk1zVn9Tg1Uzf7AMg)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
