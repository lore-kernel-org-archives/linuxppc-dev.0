Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C88CDB2.7070905@dgt-lab.com.pl>
Date: Fri, 08 Mar 2002 15:41:54 +0100
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.4.18 & copy-back cache mode
References: <D3A72C5007329A4F991C0DD87202259F096A96@sekhmet.ad.newisys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>I am sorry. I meant 64Mhz , not 66Mhz.
>
>
>
>
>I am running my MPC855T at 66Mhz 1:1 CPU/bus clock mode without any problems. I used an app. note from Motorola to do this and according to the app.note, we just need to satisfy some timing constraints on the processor (latency of data reaching the MPC pins from SDRAM). The app. note suggests using specific Micron SDRAM which satisfy all these requirements.
>
>Subject: Re: linux-2.4.18 & copy-back cache mode
>
Maybe it's teh same problem.
I have some problems while strong memory usage, for example copying a lot of files.
It stops on bus errors.

Anyone could send me UPM table for CAS_LATENCY==3. I'm not sure if burst is realy needed. Now its disabled, because I do not have correct UPM table for this.


==================================


I have  CPU:   XPC860xxZPnnD4 at 80 MHz: 4 kB I-Cache 4 kB D-Cache FEC present

And SDRAM:

  DIMM size 0x08000000 (128 MB)
  [00] 80  number of bytes written/used
  [01] 08  total number of bytes in serial PD device
  [02] 04  fundamental memory type (SDRAM)
  [03] 0c  number of rows
  [04] 09  number of columns
  [05] 02  number of banks
  [06] 40  data width (lo)
  [07] 00  data width (hi)
  [08] 01  interface levels
  [09] 75  RAS access
  [0A] 54  CAS access
  [0B] 00  configuration type (non-parity/parity/ECC)
  [0C] 80  refresh rate/type
  [0D] 08  primary DRAM organization
  [0E] 00  secondary DRAM organization (parity/ECC-checkbits)
  [0F] 01
  [12] 04  supported CAS latencies: 3
  [1F] 10   bank size (64 MB)
  other:
        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
  [1x] 8f 04 04 01 01 00 0e a0 60 00 00 14 0f 14 2c 10
  [2x] 15 08 15 08 00 00 00 00 00 00 00 00 00 00 00 00
  [3x] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 9c
  [4x] 2c ff ff ff ff ff ff ff 01 00 00 00 00 00 00 00
  [5x] 00 00 00 00 00 00 00 00 00 00 00 01 00 ff ff ff
  [6x] ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
  [7x] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 64 fd


setup MEM like this

 UPM 00804000
 MPTPR 00001000
 SDRAM 2 32MB   BR fff00110=0x000000C1 OR fff00114=0xFE000F00
 SDRAM 3 32MB   BR fff00118=0x020000C1 OR fff0011c=0xFE000F00
 SDRAM 5 32MB   BR fff00128=0x040000C1 OR fff0012c=0xFE000F00
 SDRAM 6 32MB   BR fff00130=0x060000C1 OR fff00134=0xFE000F00
 MBMR 4e944112  MAR 000000c8  MCR  80804234 80806234 8080a234 8080c234



--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
