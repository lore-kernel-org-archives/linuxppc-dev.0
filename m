In-Reply-To: <1075910536.5199.5659.camel@chuck.arlut.utexas.edu>
References: <1075910536.5199.5659.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E8829FA9-5795-11D8-9997-000393DBC2E8@motorola.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: mpc8540 and stack overflow
Date: Wed, 4 Feb 2004 22:43:57 -0600
To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It appears from the backtrace that you may be running out of stack
space due to some external interrupt that is not getting services (just
a guess).  What may be happening is that the StackOverflow is occurring
because of an extensive functional depth.

Are you able to see anything on the console from Linux?

- kumar

On Feb 4, 2004, at 10:02 AM, Matthew S. McClintock wrote:

>
> 	I am trying to get the linux kernel working on a board with an MPC8540
> cpu. I'm loading the kernel from u-boot and after transferring control
> to the kernel from u-boot I immediately run into errors.
>
> 	Upon investigating with the bdi2000 I get the following backtrace:
>
> #0  printk (fmt=0xc0166ac0 "") at printk.c:448
> #1  0xc0006dd8 in print_backtrace (sp=0xc01651f8) at process.c:594
> #2  0xc0006874 in show_regs (regs=0xc0164798) at process.c:352
> #3  0xc00044f0 in StackOverflow (regs=0xc0164798) at traps.c:485
> #4  0xc00007a0 in ExternalInput ()
>
> So my question is what causes a StackOverflow? Is it because I have run
> out of stack space? Do I need to make it bigger? If so, how does one do
> that? Or perhaps I am misinterpreting the meaning of a stack overflow,
> is it just bad code somewhere?
>
> Thanks,
> Matthew
>
> The output from the console is:
>
> U-Boot 1.0.2 (Feb  3 2004 - 12:37:25)
>
> Motorola PowerPC ProcessorID=00000000 Rev. PVR=80200010
> Board: Motorola MPC8540ADS Board
>         CPU: 660 MHz
>         CCB: 264 MHz
>         DDR: 132 MHz
>         LBC: 66 MHz
> L1 D-cache 32KB, L1 I-cache 32KB enabled.
> I2C:   ready
> DRAM:  DDR module detected, total size:256MB.
> 256 MB
> Top of RAM usable for U-Boot at: 10000000
> Reserving 141k for U-Boot at: 0ffdc000
> Reserving 136k for malloc() at: 0ffba000
> Reserving 72 Bytes for Board Info at: 0ffb9fb8
> Reserving 48 Bytes for Global Data at: 0ffb9f88
> Stack Pointer at: 0ffb9f68
> New Stack Pointer is: 0ffb9f68
> Now running in RAM - U-Boot at: 0ffdc000
> FLASH:  8 MB
> L2 cache enabled: 256KB
> In:    serial
> Out:   serial
> Err:   serial
> U-Boot relocated to 0ffdc000
> Net:   MOTOROLA ETHERNE
> ### main_loop entered: bootdelay=3
>
> ### main_loop: bootcmd="bootm 0xff800000"
> Hit any key to stop autoboot:  0
> ## Booting image at ff800000 ...
>    Image Name:   Linux-2.4.23-rc1
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    821468 Bytes = 802.2 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Current stack ends at 0x0FFB9CE8 => set upper limit to 0x00800000
> ## cmdline at 0x007FFF00 ... 0x007FFFAA
> bd address  = 0x0FFB9FB8
> memstart    = 0x00000000
> memsize     = 0x10000000
> flashstart  = 0xFF800000
> flashsize   = 0x00800000
> flashoffset = 0x00000000
> sramstart   = 0x00000000
> sramsize    = 0x00000000
> immr_base   = 0xFDF00000
> bootflags   = 0x40003F80
> intfreq     =    660 MHz
> busfreq     =    264 MHz
> ethaddr     = 00:01:AF:07:9B:8A
> eth1addr    = 00:01:AF:07:9B:8B
> eth2addr    = 00:01:AF:07:9B:8C
> IP addr     = 10.82.0.105
> baudrate    = 115200 bps
> No initrd
> ## Transferring control to Linux (at address 00000000) ...
>
>
> --
> Matthew S. McClintock <mattsm@arlut.utexas.edu>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
