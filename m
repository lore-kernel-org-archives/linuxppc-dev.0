Message-ID: <3760B964.E1424E37@switchboard.ericsson.se>
Date: Fri, 11 Jun 1999 09:23:16 +0200
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.muc.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC8xx: `init' problems / Bad emulation -- was: wrong zimage_start
References: <199906042129.XAA10659@denx.muc.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk wrote:
> 
> First of all: thanks  to  all  (Magnus  Damm,  Kári  Davíðsson,  Leif
> Lindholm) who helped me sorting out my `zimage_start' problem. I have
> got  Linux  running  on  my  custom MPC860 board, both with initrd in
> FLASH and with NFS mounted root.
> 
> However, I'm running into two new  problems  (maybe  related,  but  I
> don't think so):
> 
> * Programs that try  do  do  any  FP  calculations  don't  work,  for
>   instance:
> 
>     # date 06042124
>     Bad emulation date/6
>      NIP: 30122204 instruction: fd8c6828 opcode: 3f A: c B: d C: 0 code: 14 rc: 0
>      pte @ 0x30122204:  (0xc1efd300)->(0xc1efb488)->0x01f1c881
>      RPN: 01f1c PP: 2 SPS: 0 SH: 0 CI: 0 v: 1
>     Kernel VA for NIP c1f1c204  pte @ 0xc1f1c204:  (0xc1efdc1c)->(0xc00eec70)->0x01f1c1c5
>      RPN: 01f1c PP: 0 SPS: 0 SH: 1 CI: 0 v: 1
>     Software Emulation date/6 NIP: 30122204 *NIP: 0xfd8c6828 code: 1Illegal Instruction
>     # perl
>     Bad emulation perl/7
>      NIP: 3020e0e0 instruction: fc200090 opcode: 3f A: 0 B: 0 C: 2 code: 8 rc: 0
>      pte @ 0x3020e0e0:  (0xc1efd300)->(0xc1efb838)->0x01eae881
>      RPN: 01eae PP: 2 SPS: 0 SH: 0 CI: 0 v: 1
>     Kernel VA for NIP c1eae0e0  pte @ 0xc1eae0e0:  (0xc1efdc1c)->(0xc00eeab8)->0x01eae1c5
>      RPN: 01eae PP: 0 SPS: 0 SH: 1 CI: 0 v: 1
>     Software Emulation perl/7 NIP: 3020e0e0 *NIP: 0xfc200090 code: 1Illegal Instruction
>     # awk -f ' '
>     Software Emulation awk/8 NIP: 180f840 *NIP: 0xc83efff8 code: eawk: fatal error: internal error
>     Aborted
> 
>   Is this a known problem? Is there a fix for it?

Don't use floating point instructions in the programs, embedded PPC
doesn't have FPUs. Use -mcpu=860 -msoft-float when compiling to use
soft floats (note that all FP using programs and libraries must
be recompiled with these options to work properly).
You will also need to patch glibc to remove the FP inline assembly
and the inline memcpy  which assumes 32 byte cache lines.

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
