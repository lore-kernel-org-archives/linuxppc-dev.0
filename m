Message-ID: <3B57F6EA.A6CD5001@genetel.co.kr>
Date: Fri, 20 Jul 2001 18:16:31 +0900
From: hychon <hychon@genetel.co.kr>
Reply-To: hychon@genetel.co.kr
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Return physical address from virtual address ?
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !!

I am working a HDLC program (not device driver) as Embedded Linux
system  , that  used  SCC2 on the MPC860T target board .

I worked initialzed  SCC2 and allocat memory buffer  with the
kernel-2.2.13 based on PowerPC arch .

In my program,  I allocated  the BD (Buffer Descriptor)  in  a temporary
place of DPMEM.

 RxTxBD = (BDRINGS *)(&IMMR->udata_bd[0x600]);
      IMMR->PRAM[PAGE2].pg.scc.h.rbase = (UHWORD)&RxTxBD->RxBD[0];   /*
1 */
      IMMR->PRAM[PAGE2].pg.scc.h.rbase =
(UHWORD)0x2E00;                                /* 2 */

 case 1 :  BD state not change and down .the system
 case 2 :  BD state are change

I think that  the RBASE and TBASE in SCC PARAM is a physical address of
Buffer Descriptor

I want to get a place of BD  in  DPMEM itself  and  retun  as  physical
address. (as if ,  CPM  get a BD pointer  in commproc.c file )

Question1) How to get  a place(pointer) of BD  in DPMEM  and give RBASE
(TBASE)  the physical address ?

 And Buffer are allocated  in a virtual area , by following
    mem_addr_buf1 = mmap(0,1024,(PROT_READ|PROT_WRITE),MAP_SHARED,
mem_buf1,0x100000);
    buf = (unsigned char *)mem_addr_buf1;

 when  I write  buf  as  Buffer addr of BD,  that do not change  Buffer
(BD) state

I think that  don't find the buffer address
and the Buffer pointer of BD structure was recognized as physical
address of  the Buffer (buf) .

Question2) How to get a buffer address pointer of BD struct (a place of
Buffer) from kernel (virtual address) as physical address?

Help me !


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
