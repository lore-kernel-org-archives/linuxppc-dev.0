Return-Path: <phileas-fogg@mail.ru>
Received: from smtp23.mail.ru (smtp23.mail.ru [94.100.176.176])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 244CA2C029C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 06:38:27 +1100 (EST)
Message-ID: <512685B7.5080404@mail.ru>
Date: Thu, 21 Feb 2013 21:38:15 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
References: <1360365046.495584377@f356.mail.ru> <5123C729.5040607@mail.ru>
 <5123D864.4060503@mail.ru> <51253558.1070407@mail.ru>
 <1361406741.4676.44.camel@pasglop>
In-Reply-To: <1361406741.4676.44.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2013-02-20 at 21:43 +0100, Phileas Fogg wrote:
>
>> I found the single commit which brakes kexec stuff for FreeBSD loader or other
>> custom ELF kernels on the PS3 console.
>>
>>
>>   From 7230c5644188cd9e3fb380cc97dde00c464a3ba7 Mon Sep 17 00:00:00 2001
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Date: Tue, 6 Mar 2012 18:27:59 +1100
>> Subject: [PATCH] powerpc: Rework lazy-interrupt handling
>
> Odd... That rework had its own issues and so several patches went in
> subsequently to address them. It's possible that the PS3 does more
> horrid stuff we missed here but I don't quite see how to relate that to
> your specific memory corruption problem...
>
> Do you see any "pattern" to the corruption ? Does it looks like
> something known ? IE., exception frame, ASCII data, MSR values, ...
>
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

Hi,

here is some data for analyzing.

First, i modified kexec-tools and dumped the kernel and DT segments before they
are passed to the kexec_load syscall. I also modified the purgatory code and
made it dump the computed SHA256 checksum, the original SHA256 checksum and
the DT.

Here is the output from kexec-tools:
--------------------------------------

root@ps3-linux:~# kexec -l loader.ps3
segment[0].mem:0x1371000 memsz:262144
segment[1].mem:0x13b1000 memsz:36864
segment[2].mem:0x7fff000 memsz:4096
sha256_digest: 66 a6 c0 be d5 3c ba c2 85 6 97 4 d2 e1 aa 28 63 fa 7f 79 ce de
                e7 7f 26 14 a1 fa 2a ea bc 83



Here is the output from the purgatory code:
---------------------------------------------

I'm in purgatory
sha256 digests do not match :(
        digest: d4 dc 50 0a ef 78 8e 28 e0 9a fe 52 e1 72 1c b3 23 a6 f4 ea 40
                7a 2d fd 6b 2a 66 95 63 f6 99 2a
sha256_digest: 66 a6 c0 be d5 3c ba c2 85 06 97 04 d2 e1 aa 28 63 fa 7f 79 ce
                de e7 7f 26 14 a1 fa 2a ea bc 83
sha256_regions:
start=0x0000000001371000 len=0x0000000000040000
start=0x0000000007fff000 len=0x0000000000001000



Here is the DT dump from kexec-tools:
---------------------------------------

00000000  d0 0d fe ed 00 00 03 70  00 00 00 40 00 00 02 74  |.......p...@...t|
00000010  00 00 00 20 00 00 00 02  00 00 00 02 00 00 00 00  |... ............|
00000020  00 00 00 00 07 ff f0 00  00 00 00 00 00 00 03 70  |...............p|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000040  00 00 00 01 2f 00 00 00  00 00 00 03 00 00 00 04  |..../...........|
00000050  00 00 00 00 00 00 00 02  00 00 00 03 00 00 00 04  |................|
00000060  00 00 00 0f 00 00 00 02  00 00 00 03 00 00 00 09  |................|
00000070  00 00 00 1b 00 00 00 00  73 6f 6e 79 2c 70 73 33  |........sony,ps3|
00000080  00 00 00 00 00 00 00 03  00 00 00 04 00 00 00 26  |...............&|
00000090  00 00 00 00 00 00 00 03  00 00 00 08 00 00 00 39  |...............9|
000000a0  00 00 00 00 38 6d 43 80  00 00 00 03 00 00 00 08  |....8mC.........|
000000b0  00 00 00 48 00 00 00 00  53 6f 6e 79 50 53 33 00  |...H....SonyPS3.|
000000c0  00 00 00 03 00 00 00 01  00 00 00 4e 00 00 00 00  |...........N....|
000000d0  00 00 00 01 2f 63 68 6f  73 65 6e 00 00 00 00 03  |..../chosen.....|
000000e0  00 00 00 08 00 00 00 53  00 00 00 00 00 00 00 00  |.......S........|
000000f0  00 00 00 03 00 00 00 07  00 00 00 4e 63 68 6f 73  |...........Nchos|
00000100  65 6e 00 00 00 00 00 03  00 00 00 02 00 00 00 66  |en.............f|
00000110  20 00 00 00 00 00 00 02  00 00 00 01 2f 63 70 75  | .........../cpu|
00000120  73 00 00 00 00 00 00 03  00 00 00 04 00 00 00 00  |s...............|
00000130  00 00 00 01 00 00 00 03  00 00 00 04 00 00 00 0f  |................|
00000140  00 00 00 00 00 00 00 03  00 00 00 05 00 00 00 4e  |...............N|
00000150  63 70 75 73 00 00 00 00  00 00 00 01 2f 63 70 75  |cpus......../cpu|
00000160  73 2f 63 70 75 40 30 00  00 00 00 03 00 00 00 04  |s/cpu@0.........|
00000170  00 00 00 6f 00 00 00 00  00 00 00 03 00 00 00 04  |...o............|
00000180  00 00 00 7f 00 00 00 80  00 00 00 03 00 00 00 04  |................|
00000190  00 00 00 91 00 00 80 00  00 00 00 03 00 00 00 04  |................|
000001a0  00 00 00 9e 63 70 75 00  00 00 00 03 00 00 00 04  |....cpu.........|
000001b0  00 00 00 aa 00 00 00 80  00 00 00 03 00 00 00 04  |................|
000001c0  00 00 00 bc 00 00 80 00  00 00 00 03 00 00 00 08  |................|
000001d0  00 00 00 c9 00 00 00 00  00 00 00 00 00 00 00 01  |................|
000001e0  00 00 00 03 00 00 00 04  00 00 00 4e 63 70 75 00  |...........Ncpu.|
000001f0  00 00 00 03 00 00 00 04  00 00 00 e4 00 00 00 00  |................|
00000200  00 00 00 03 00 00 00 04  00 00 00 e8 00 00 00 00  |................|
00000210  00 00 00 02 00 00 00 02  00 00 00 01 2f 6d 65 6d  |............/mem|
00000220  6f 72 79 00 00 00 00 03  00 00 00 07 00 00 00 9e  |ory.............|
00000230  6d 65 6d 6f 72 79 00 00  00 00 00 03 00 00 00 07  |memory..........|
00000240  00 00 00 4e 6d 65 6d 6f  72 79 00 00 00 00 00 03  |...Nmemory......|
00000250  00 00 00 10 00 00 00 e4  00 00 00 00 00 00 00 00  |................|
00000260  00 00 00 00 08 00 00 00  00 00 00 02 00 00 00 02  |................|
00000270  00 00 00 09 23 61 64 64  72 65 73 73 2d 63 65 6c  |....#address-cel|
00000280  6c 73 00 23 73 69 7a 65  2d 63 65 6c 6c 73 00 63  |ls.#size-cells.c|
00000290  6f 6d 70 61 74 69 62 6c  65 00 6c 69 6e 75 78 2c  |ompatible.linux,|
000002a0  61 76 5f 6d 75 6c 74 69  5f 6f 75 74 00 6c 69 6e  |av_multi_out.lin|
000002b0  75 78 2c 72 74 63 5f 64  69 66 66 00 6d 6f 64 65  |ux,rtc_diff.mode|
000002c0  6c 00 6e 61 6d 65 00 6c  69 6e 75 78 2c 6d 65 6d  |l.name.linux,mem|
000002d0  6f 72 79 2d 6c 69 6d 69  74 00 62 6f 6f 74 61 72  |ory-limit.bootar|
000002e0  67 73 00 63 6c 6f 63 6b  2d 66 72 65 71 75 65 6e  |gs.clock-frequen|
000002f0  63 79 00 64 2d 63 61 63  68 65 2d 6c 69 6e 65 2d  |cy.d-cache-line-|
00000300  73 69 7a 65 00 64 2d 63  61 63 68 65 2d 73 69 7a  |size.d-cache-siz|
00000310  65 00 64 65 76 69 63 65  5f 74 79 70 65 00 69 2d  |e.device_type.i-|
00000320  63 61 63 68 65 2d 6c 69  6e 65 2d 73 69 7a 65 00  |cache-line-size.|
00000330  69 2d 63 61 63 68 65 2d  73 69 7a 65 00 69 62 6d  |i-cache-size.ibm|
00000340  2c 70 70 63 2d 69 6e 74  65 72 72 75 70 74 2d 73  |,ppc-interrupt-s|
00000350  65 72 76 65 72 23 73 00  72 65 67 00 74 69 6d 65  |erver#s.reg.time|
00000360  62 61 73 65 2d 66 72 65  71 75 65 6e 63 79 00 00  |base-frequency..|
00000370



Here is the DT dump from the purgatory code after the verify function failed:
------------------------------------------------------------------------------

00000000  d0 0d fe ed 00 00 03 70  00 00 00 40 00 00 02 74  |.......p...@...t|
00000010  00 00 00 20 00 00 00 02  00 00 00 02 00 00 00 00  |... ............|
00000020  00 00 00 00 07 ff f0 00  00 00 00 00 00 00 03 70  |...............p|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000040  00 00 00 01 2f 00 00 00  00 00 00 03 00 00 00 04  |..../...........|
00000050  00 00 00 00 00 00 00 02  00 00 00 03 00 00 00 04  |................|
00000060  00 00 00 0f 00 00 00 02  00 00 00 03 00 00 00 09  |................|
00000070  00 00 00 1b 00 00 00 00  73 6f 6e 79 2c 70 73 33  |........sony,ps3|
00000080  80 00 00 00 00 00 80 30  80 00 00 00 00 00 80 02  |.......0........|
00000090  c0 00 00 00 00 01 a4 a0  00 00 00 08 00 00 00 39  |...............9|
000000a0  00 00 00 00 38 6d 43 80  00 00 00 03 00 00 00 08  |....8mC.........|
000000b0  00 00 00 48 00 00 00 00  53 6f 6e 79 50 53 33 00  |...H....SonyPS3.|
000000c0  00 00 00 03 00 00 00 01  00 00 00 4e 00 00 00 00  |...........N....|
000000d0  00 00 00 01 2f 63 68 6f  73 65 6e 00 00 00 00 03  |..../chosen.....|
000000e0  00 00 00 08 00 00 00 53  00 00 00 00 00 00 00 00  |.......S........|
000000f0  00 00 00 03 00 00 00 07  00 00 00 4e 63 68 6f 73  |...........Nchos|
00000100  65 6e 00 00 00 00 00 03  00 00 00 02 00 00 00 66  |en.............f|
00000110  20 00 00 00 00 00 00 02  00 00 00 01 2f 63 70 75  | .........../cpu|
00000120  73 00 00 00 00 00 00 03  00 00 00 04 00 00 00 00  |s...............|
00000130  00 00 00 01 00 00 00 03  00 00 00 04 00 00 00 0f  |................|
00000140  00 00 00 00 00 00 00 03  00 00 00 05 00 00 00 4e  |...............N|
00000150  63 70 75 73 00 00 00 00  00 00 00 01 2f 63 70 75  |cpus......../cpu|
00000160  73 2f 63 70 75 40 30 00  00 00 00 03 00 00 00 04  |s/cpu@0.........|
00000170  00 00 00 6f 00 00 00 00  00 00 00 03 00 00 00 04  |...o............|
00000180  00 00 00 7f 00 00 00 80  00 00 00 03 00 00 00 04  |................|
00000190  00 00 00 91 00 00 80 00  00 00 00 03 00 00 00 04  |................|
000001a0  00 00 00 9e 63 70 75 00  00 00 00 03 00 00 00 04  |....cpu.........|
000001b0  00 00 00 aa 00 00 00 80  00 00 00 03 00 00 00 04  |................|
000001c0  00 00 00 bc 00 00 80 00  00 00 00 03 00 00 00 08  |................|
000001d0  00 00 00 c9 00 00 00 00  00 00 00 00 00 00 00 01  |................|
000001e0  00 00 00 03 00 00 00 04  00 00 00 4e 63 70 75 00  |...........Ncpu.|
000001f0  00 00 00 03 00 00 00 04  00 00 00 e4 00 00 00 00  |................|
00000200  00 00 00 03 00 00 00 04  00 00 00 e8 00 00 00 00  |................|
00000210  00 00 00 02 00 00 00 02  00 00 00 09 2f 6d 65 6d  |............/mem|
00000220  6f 72 79 00 00 00 00 03  00 00 00 07 00 00 00 9e  |ory.............|
00000230  6d 65 6d 6f 72 79 00 00  00 00 00 03 00 00 00 07  |memory..........|
00000240  00 00 00 4e 6d 65 6d 6f  72 79 00 00 00 00 00 03  |...Nmemory......|
00000250  00 00 00 10 00 00 00 e4  00 00 00 00 00 00 00 00  |................|
00000260  00 00 00 00 08 00 00 00  00 00 00 02 00 00 00 02  |................|
00000270  00 00 00 09 23 61 64 64  72 65 73 73 2d 63 65 6c  |....#address-cel|
00000280  6c 73 00 23 73 69 7a 65  2d 63 65 6c 6c 73 00 63  |ls.#size-cells.c|
00000290  6f 6d 70 61 74 69 62 6c  65 00 6c 69 6e 75 78 2c  |ompatible.linux,|
000002a0  61 76 5f 6d 75 6c 74 69  5f 6f 75 74 00 6c 69 6e  |av_multi_out.lin|
000002b0  75 78 2c 72 74 63 5f 64  69 66 66 00 6d 6f 64 65  |ux,rtc_diff.mode|
000002c0  6c 00 6e 61 6d 65 00 6c  69 6e 75 78 2c 6d 65 6d  |l.name.linux,mem|
000002d0  6f 72 79 2d 6c 69 6d 69  74 00 62 6f 6f 74 61 72  |ory-limit.bootar|
000002e0  67 73 00 63 6c 6f 63 6b  2d 66 72 65 71 75 65 6e  |gs.clock-frequen|
000002f0  63 79 00 64 2d 63 61 63  68 65 2d 6c 69 6e 65 2d  |cy.d-cache-line-|
00000300  73 69 7a 65 00 64 2d 63  61 63 68 65 2d 73 69 7a  |size.d-cache-siz|
00000310  65 00 64 65 76 69 63 65  5f 74 79 70 65 00 69 2d  |e.device_type.i-|
00000320  63 61 63 68 65 2d 6c 69  6e 65 2d 73 69 7a 65 00  |cache-line-size.|
00000330  69 2d 63 61 63 68 65 2d  73 69 7a 65 00 69 62 6d  |i-cache-size.ibm|
00000340  2c 70 70 63 2d 69 6e 74  65 72 72 75 70 74 2d 73  |,ppc-interrupt-s|
00000350  65 72 76 65 72 23 73 00  72 65 67 00 74 69 6d 65  |erver#s.reg.time|
00000360  62 61 73 65 2d 66 72 65  71 75 65 6e 63 79 00 00  |base-frequency..|
00000370


And here is the diff between 2 hexdumps:
-----------------------------------------

--- dt.kexec.hex
+++ dt.dump.hex
@@ -6,8 +6,8 @@
  00000050  00 00 00 00 00 00 00 02  00 00 00 03 00 00 00 04  |................|
  00000060  00 00 00 0f 00 00 00 02  00 00 00 03 00 00 00 09  |................|
  00000070  00 00 00 1b 00 00 00 00  73 6f 6e 79 2c 70 73 33  |........sony,ps3|
-00000080  00 00 00 00 00 00 00 03  00 00 00 04 00 00 00 26  |...............&|
-00000090  00 00 00 00 00 00 00 03  00 00 00 08 00 00 00 39  |...............9|
+00000080  80 00 00 00 00 00 80 30  80 00 00 00 00 00 80 02  |.......0........|
+00000090  c0 00 00 00 00 01 a4 a0  00 00 00 08 00 00 00 39  |...............9|
  000000a0  00 00 00 00 38 6d 43 80  00 00 00 03 00 00 00 08  |....8mC.........|
  000000b0  00 00 00 48 00 00 00 00  53 6f 6e 79 50 53 33 00  |...H....SonyPS3.|
  000000c0  00 00 00 03 00 00 00 01  00 00 00 4e 00 00 00 00  |...........N....|
@@ -31,7 +31,7 @@
  000001e0  00 00 00 03 00 00 00 04  00 00 00 4e 63 70 75 00  |...........Ncpu.|
  000001f0  00 00 00 03 00 00 00 04  00 00 00 e4 00 00 00 00  |................|
  00000200  00 00 00 03 00 00 00 04  00 00 00 e8 00 00 00 00  |................|
-00000210  00 00 00 02 00 00 00 02  00 00 00 01 2f 6d 65 6d  |............/mem|
+00000210  00 00 00 02 00 00 00 02  00 00 00 09 2f 6d 65 6d  |............/mem|
  00000220  6f 72 79 00 00 00 00 03  00 00 00 07 00 00 00 9e  |ory.............|
  00000230  6d 65 6d 6f 72 79 00 00  00 00 00 03 00 00 00 07  |memory..........|
  00000240  00 00 00 4e 6d 65 6d 6f  72 79 00 00 00 00 00 03  |...Nmemory......|




As you see, the data is different at offsets 0x80, 0x90 and 0x210.

The new 8 bytes at offset 0x90 in dt.dump.hex look suspicously like the kernel
virtual address: 0xc00000000001a4a0.

I'll try out the advice with DABR register from Geoff later and see if i can get 
the code address which corrupts the data in DT.

regards
