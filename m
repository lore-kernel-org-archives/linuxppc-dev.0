Message-ID: <38F23EF0.8AFC5354@charter.net>
Date: Mon, 10 Apr 2000 15:52:01 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch
CC: linuxppc-embedded@lists.linuxppc.org, systemboot@linux01.hasler.ascom.ch
Subject: Re: Bootloader 8xxrom on ADS860, gcc 2.95
References: <0FSS009D0XGBQZ@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch wrote:
>
> Hi

Hi Ruedi

> I'm using almost the standard 8xxrom bootloader on my ADS860 board.
>
> When I cross compile it on my I386 Linux host using the egcs-2.91, it works ok.
>
> When I cross compile it on my I386 Linux host using the gcc 2.95.2, it doesn't work.
> That means, it always crashes like:
>
> -----
> 8xxROM 0.3.0
>
> compiletime options:
> board: ADS DRAM_25MHZ
> disk: DISK_ATA PCMCIABUG
>
> cpu: XPC860xxZPnnA3 at 25 MHz: 4Kbyte icache 4Kbyte dcache
>
> <warning: cpu core has silicon bugs, check the errata>
>
> board: ADS rev A - warning, read errata
> flash: 2 Mbytes, delay 90 ns
> dram: 32 Mbyte, 70 ns, OK
> pcmcia: 5V and 3V
> pcsr = 0x0070fe70
>
> ATA disk: 'SunDisk SDP'.
>
> Boot device list:ata.c : Card Not Ready 0x0
>
> disk: No disk found.
> NIP: 00000000 XER: E0004A7F LR: FE004604 REGS: 01fefb80 TRAP: 1000
> MSR: 00001002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
>
> GPR00: 00000000 01FEFC70 FE004310 00000000 00000001 01FEFC88 FFFFFFFB 01FEFE10
> GPR08: 00000000 FE00B264 00000000 00012600 01FEFD48 1011AFB0 000125C0 00000000
> GPR16: 00000000 00000000 00000002 FE010000 00009032 000125B8 00010000 C0002544
> GPR24: 00000002 00000001 00000001 01FF0000 01FEFEE8 FF002FDC 01FEFF08 01FEFEA8
> Call backtrace:
> Software Emulation Exception
> -----
>
> Did someone encounter the same problem??

Not the same problem, but something that may be quite similar.
Yesterday I encountered a problem with the "disk: No disk found."
message.  Well, not with the message per se, but with not finding
any disks.  In this case, 8xxrom still tries to prompt you, but the
file_cwd (I think - this was about 24 hours ago) was not set, so
the prompt tried to print "rom:0:              "  with the spacing
continuing on for several lines until the machine crashed.
And, I am using egcs-2.95.2 to compile for my 850.
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
