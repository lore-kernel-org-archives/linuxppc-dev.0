Message-ID: <1DF71FB881F4D311A6B700C04FA06A1AC436B1@orca.desanasystems.com>
From: "Marti, Felix" <fmarti@desanasystems.com>
To: "'hychon@genetel.co.kr'" <hychon@genetel.co.kr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: memory access
Date: Tue, 10 Jul 2001 10:51:17 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There are two main procedure that you can follow:

A. static
(1) grab memory during boottime
(2) mmap memory to userspace
(3) implement your own memory allocator on top of the mmaped memory
-> physical to virtual mapping is straight forward (base/offset)

B. dynamic
(1) malloc memory at runtime
(2) use the kiovec stuff to lock pages and determine physical mapping
-> physical to virtual mapping comes at the expense of a system call, ...

felix

-----Original Message-----
From: hychon [mailto:hychon@genetel.co.kr]
Sent: Tuesday, July 10, 2001 1:07 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: memory access



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
----------------------------------------------------------------------------
-

I used some rest area of dpmem except buffer descriptor area,

then , system was down.

 I want to a way of use some user spaec(memory)  for  Buffer ( receving
and transmitting data).

 how to memory access  " from virtual memory to physical memory and from
physical memory to virutal memory " ?

can you hlep me  with some example ???


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
