Date: Wed, 11 Aug 1999 14:36:51 -0500 (CDT)
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-dev@lists.linuxppc.org
cc: cort@cs.nmt.edu
Subject: Patch for mkprep.c
Message-ID: <Pine.SGI.3.91.990811143033.161699B-100000@brule.lcse.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I believe I've solved the problem with mkprep core dumping with a bus 
error on Sun UltraSPARC/Solaris and SGI MIPS/Irix machines.

The bus error was due to an unaligned word access. This occured because
'pe' was based on &block[0x1BE], thus referencing pe->beginning_sector or
pe->number_of_sectors attempts to do a word access at an unaligned byte 
address--which neither UltraSPARCs nor R5000s appear to like.

The following patch should address the issue. Applying and running it on
both 386 and Solaris machines result in identical zImage files from a
given zvmlinux.  However, I don't have a PReP machine to verify the
resultant image on.  Anyone care to give it a whirl? 

*** mkprep.c    1999/08/05 01:59:31     1.1.1.1
--- mkprep.c    1999/08/11 19:27:18
***************
*** 145,151 ****
  void write_prep_partition(int in, int out)
  {
    unsigned char block[512];
!   partition_entry_t *pe = (partition_entry_t *)&block[0x1BE];
    dword_t *entry  = (dword_t *)&block[0];
    dword_t *length = (dword_t *)&block[sizeof(long)];
    struct stat info;
--- 145,151 ----
  void write_prep_partition(int in, int out)
  {
    unsigned char block[512];
!   partition_entry_t pent, *pe = &pent;
    dword_t *entry  = (dword_t *)&block[0];
    dword_t *length = (dword_t *)&block[sizeof(long)];
    struct stat info;
***************
*** 214,219 ****
--- 214,221 ----
  #else
    pe->number_of_sectors = cpu_to_le32(2*18*80-1);
  #endif /* __i386__ */
+ 
+   memcpy(&block[0x1BE], pe, sizeof (pent));
  
    write( out, block, sizeof(block) );
    write( out, entry, sizeof(*entry) );

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
