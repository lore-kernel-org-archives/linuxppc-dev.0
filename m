Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3B4AB798.687AF994@genetel.co.kr>
Date: Tue, 10 Jul 2001 17:06:54 +0900
From: hychon <hychon@genetel.co.kr>
Reply-To: hychon@genetel.co.kr
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: memory access
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

I want to make a HDLC driver based on the MPC860T target board

To use  SCC2  as hdlc , I was access immr area by following

 ------------------------------------------------------------------------

 if((mem_hdlc = open("/dev/mem", O_RDWR)) < 0){

         perror("mem open error\n");
         exit(2);
  }

  mem_addr_hdlc = mmap(0,(64*1024),(PROT_READ|PROT_WRITE),MAP_SHARED,
mem_hdlc,0xFF000000 );

  if((int)mem_addr_hdlc < 0 ) {
   TRACE("mem_addr_hdlc mmap error\n");
   exit(2);
   }

   IMMR = (immap_t *) mem_addr_hdlc;
-----------------------------------------------------------------------------

I used some rest area of dpmem except buffer descriptor area,

then , system was down.

 I want to a way of use some user spaec(memory)  for  Buffer ( receving
and transmitting data).

 how to memory access  " from virtual memory to physical memory and from
physical memory to virutal memory " ?

can you hlep me  with some example ???


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
