Message-Id: <199906042129.XAA10659@denx.muc.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: MPC8xx: `init' problems / Bad emulation -- was: wrong zimage_start
From: Wolfgang Denk <wd@denx.muc.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Fri, 04 Jun 1999 23:29:07 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


First of all: thanks  to  all  (Magnus  Damm,  Kári  Davíðsson,  Leif
Lindholm) who helped me sorting out my `zimage_start' problem. I have
got  Linux  running  on  my  custom MPC860 board, both with initrd in
FLASH and with NFS mounted root.


However, I'm running into two new  problems  (maybe  related,  but  I
don't think so):

* Programs that try  do  do  any  FP  calculations  don't  work,  for
  instance:

    # date 06042124
    Bad emulation date/6
     NIP: 30122204 instruction: fd8c6828 opcode: 3f A: c B: d C: 0 code: 14 rc: 0
     pte @ 0x30122204:  (0xc1efd300)->(0xc1efb488)->0x01f1c881
     RPN: 01f1c PP: 2 SPS: 0 SH: 0 CI: 0 v: 1
    Kernel VA for NIP c1f1c204  pte @ 0xc1f1c204:  (0xc1efdc1c)->(0xc00eec70)->0x01f1c1c5
     RPN: 01f1c PP: 0 SPS: 0 SH: 1 CI: 0 v: 1
    Software Emulation date/6 NIP: 30122204 *NIP: 0xfd8c6828 code: 1Illegal Instruction
    # perl
    Bad emulation perl/7
     NIP: 3020e0e0 instruction: fc200090 opcode: 3f A: 0 B: 0 C: 2 code: 8 rc: 0
     pte @ 0x3020e0e0:  (0xc1efd300)->(0xc1efb838)->0x01eae881
     RPN: 01eae PP: 2 SPS: 0 SH: 0 CI: 0 v: 1
    Kernel VA for NIP c1eae0e0  pte @ 0xc1eae0e0:  (0xc1efdc1c)->(0xc00eeab8)->0x01eae1c5
     RPN: 01eae PP: 0 SPS: 0 SH: 1 CI: 0 v: 1
    Software Emulation perl/7 NIP: 3020e0e0 *NIP: 0xfc200090 code: 1Illegal Instruction
    # awk -f ' ' 
    Software Emulation awk/8 NIP: 180f840 *NIP: 0xc83efff8 code: eawk: fatal error: internal error
    Aborted

  Is this a known problem? Is there a fix for it?

* /sbin/init does not work. This seems to be a known  problem,  since
  the  tar  image  for  the  MBX  board  on the `embedded' FTP Server
  (mbxroot.full.tgz) has /sbin/init renamed;  I  tried  this  version
  (init.old),  and  the "standard" versions in release 4.1 and DR-1.0
  -- all show the same result (system hangs somewhere).

  Does anybody know why? Is there a fix for it?

Thanks in advance,

Wolfgang

-- 
Phone: (+49)-8142-4596-87  Fax: -88  Home: -86  Email: wd@denx.muc.de
God made the integers; all else is the work of Man.       - Kronecker

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
