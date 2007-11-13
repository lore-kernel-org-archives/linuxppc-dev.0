Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Tue, 13 Nov 2007 09:16:35 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Siva Prasad <sprasad@bivio.net>
Subject: Re: printk/console_init
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73BF1@corpexc01.corp.networkrobots.com>
Message-ID: <Pine.LNX.4.62.0711130915480.31003@pademelon.sonytel.be>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73BF1@corpexc01.corp.networkrobots.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-676486446-1194941795=:31003"
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-676486446-1194941795=:31003
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 12 Nov 2007, Siva Prasad wrote:
> I am using 2.6.19 Linux on 8641D based system.
> 
> I am using early printk's and it works fine until console_init() is
> executed. After that it does not, as the early printk's get disabled,
> which is fine. However, I don't see any prints after that at all, that
> are based on regular printk statements. I looked directly into the
> memory at __log_buf and found all the print messages. It is just not
> coming out to the serial port properly.
> 
> It would be great if some one can tell me various parameters that I need
> to consider changing, to successfully port the serial driver for a new
> board.
> 
> Based on the early printk's, I am getting the following messages...
> 
> Using MPC86xx HPCN machine description
> Total memory = 1024MB; using 2048kB for hash table (at cfe00000)
> Linux version 2.6.19 (sprasad@cider.bivio.net) (gcc version 4.1.1
> 20060525 (Red Hat 4.1.1-1)) #115 SMP Mon Nov 12 18:21:43 PST 2007
> Found legacy serial port 0 for /soc8641@ff700000/serial@4500
>   mem=ff704500, taddr=ff704500, irq=1a, clk=1496250, speed=0
> Found MPC86xx PCIE host bridge at 0x00000000ff708000. Firmware bus
> number: 0->254
> Found MPC86xx PCIE host bridge at 0x00000000ff709000. Firmware bus
> number: 0->255
> MPC86xx HPCN board from Freescale Semiconductor
> Zone PFN ranges:
>   DMA             0 ->   196608
>   Normal     196608 ->   196608
>   HighMem    196608 ->   262144
> early_node_map[1] active PFN ranges
>     0:        0 ->   262144
> start_kernel: 8 22000000.
> Built 1 zonelists.  Total pages: 260096
> Kernel command line: console=ttyS0,115200 root=/dev/sda8
                               ^^^^^^^^^^^^
> mpic: Setting up MPIC " MPIC     " version 1.2 at ff740000, max 2 CPUs
> mpic: ISU size: 16, shift: 4, mask: f
> mpic: Initializing for 80 sources
> PID hash table entries: 4096 (order: 12, 16384 bytes)
> time_init: decrementer frequency = 150.000000 MHz
> time_init: processor frequency   = 1496.250000 MHz
> <........ Nothing gets printed after this .......>

Did your serial driver (a) call register_console() (b) using the correct name?

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-676486446-1194941795=:31003--
