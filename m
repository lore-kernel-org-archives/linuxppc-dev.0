Message-Id: <4.3.2.20010921074815.00c4c150@falcon.si.com>
Date: Fri, 21 Sep 2001 07:52:31 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: PPC 750 booting... exception
In-Reply-To: <35C119252057D511BB9F0003476BF8A208E5B0@freexc01.smartm.com
 >
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 07:54 PM 9/20/01 -0700, Prasad, Siva wrote:

>Hi,
>
>I am trying to boot custom board with PPC 750.
>
>* I tftp'd the zImage into the target and when I give "go" command, it
>gives
>exception error. I can't understand what is going on. Below are the copy
>paste of it. I am using "powerboot" as the boot loader.
>
>- When I got the kernel from bk source (or from HHL 1.2), I had to
>explicitly say "n" to CONFIG_FB in arch/ppc/config.in. If not, I was
>getting
>compilations errors. Does this has any thing to do with booting.
>
>- I also tried with HHL 1.2 version (kernel 2.2.14). I was having the same
>problem of exception there also.
>
>* I know this is a basic question...
>What is "Prep" and "Chrp". zImage built had these two suffixes to it.
>
>Can some one please help me out.
>
>Thanks in advance.
>
>PowerBoot> netload zImage 400000 10.149.4.228 10.149.4.28
>  Ethernet controller diagnostics...pass
>  Init Ethernet Controller MII-Port and PHY-Device
>  PHY-Device at 100MB/s negotiated
>  LAN-controller at address FE880000 set to Ethernet 12:00:34:23:56:45
>  Transmitting ARP-REQUEST... Reception of ARP-REPLY
>  Transmitting TFTP-REQUEST to server 00:60:08:5A:F0:AC, IP 10.149.4.28
>  PACKET:1080 - loaded $00400000..$00486E65 (552550 bytes)
>
>PowerBoot> go 400000
>
>exception occured: 0x700
>SRR0 = 0x00400000
>SRR1 = 0x0008B030
>MSR  = 0x00000030
>DAR  = 0x00000000
>HID0 = 0x8010C004
>HID1 = 0x70000000
>L2CR = 0xBD080000
>*** Program Exception ***
>PowerBoot>
>
>-- Siva

srr0 holds the address of the instruction where you resume after
handling an exception (if possible :-).  In this case, it is the target
of your "go" instruction.  You are dead before you (successfully)
executed one instruction.  Disassemble the instructions at location
0x400000.  Check that that location holds the values that you think you
loaded and that the load file makes sense (if your PowerBoot doesn't
disassemble, disassemble the loadable file on your host).

gvb

******************** Lawyer gibberish: ********************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
