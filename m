Message-ID: <3EABEDCF.3080208@jaluna.com>
Date: Sun, 27 Apr 2003 16:48:47 +0200
From: Eric Lescouet <eric.lescouet@Jaluna.COM>
MIME-Version: 1.0
To: Kamalesh B <kamal@tataelxsi.co.in>,
	Sriram Narasimhan <nsri@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Wierd RAM configration issues - MPC8260
References: <3EABDFFA.3050301@tataelxsi.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sriram,

You may try another test: write to power of 2 boundaries and then read
at 0, just to check your memory controller does not rollover to zero at
some point, due to bad configuration.

It may happens that writting in 8MB (or 16MB or 32MB ...) actually
overwrite RAM at address 0.
This may explain why it works when using only low part of memory.

Sriram Narasimhan wrote:
>
> Hello,
>
> Hardware : Custom Board (based on MPC8260)
> Kernel: 2.4.1
> PPCBoot: PPCBoot - 2.0.0 (modified for our custom board)
>
> The board has 64MB RAM. (Micron - MT48LC8M16A2TG75)
> [ 4 - 2MB SDRAM -  of  16 (bits) connected in parallel to make
> 8MBx64bits configuration]
> [ Each SDRAM having four banks]
>
> The board is booting up when we use only 8 MB out of the 64 MB.
> (We tried both NFS boot and RAM disk boot).
> The board is failing to come up for any memory configuration greater
> than 8MB.
>
> The same kernel image is working fine on MPC8260 ADS reference board,
> which has a 16 MB SDRAM.
> (Both NFS boot and RAM disk boot).
>
> Any suggestions as to why it should fail to boot up with memory
> configuration greater than 8MB?
> We changed the following between the ADS board and our custom board (wrt
> Memory Configuration only)
> * Option Register - 0xFC0028C0
> * Base Register - 0x00000041
> * PSDMR Register - 0x414DA462
> (All above configuration done in PPC Boot).
> Are we missing out any configurations?
>
> We did a read / write on the entire memory range from PPCBoot and it
> worked fine. (Test Passed).
> Can we do some other memory test to ensure that there are no hardware
> failures ?
>
> Any clues or suggestions would be very helpful.
>
> Thank you.
> Regards,
> Sriram & Kamales
--
Eric Lescouet <eric.lescouet@Jaluna.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
