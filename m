Date: Mon, 3 Jul 2000 09:55:18 -0400 (EDT)
From: Jamie Guinan <guinan@bluebutton.com>
Reply-To: guinan@bluebutton.com
To: "Stephan Ruettiger (r0337c)" <r0337c@email.sps.mot.com>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCI-Interrupts with QSpan an Winbond on MBX860
In-Reply-To: <3960C9B2.15F209B3@email.sps.mot.com>
Message-ID: <Pine.LNX.4.21.0007030949330.10029-100000@gemini.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephan,

Look at arch/ppc/kernel/m8xx_setup.c, in the function
m8xx_init_IRQ(), you'll find the for loop for initializing
the 8259 commented out with "#if 0".  I uncommented it and
I now get,

# cat /proc/interrupts
           CPU0
  5:       1296   8xx SIU       cpm
  6:         70   8xx SIU       8259 cascade
 15:          0   8xx SIU       tbint
 30:         70   i8259         ide0
BAD:          0

-Jamie


On Mon, 3 Jul 2000, Stephan Ruettiger (r0337c) wrote:

>
> I have a PCI card on a MBX860 that works fine. I can access the io space
> through a module, the card generates interrupts but I'm not able to get
> the interrupt handler working. This is because the QSpan and the Winbond
> doesn't pass interrupts.
>
> I guess that some registers are incorrect (EPPCbug?). Could someone tell
> me in which place of the kernel the settings should be done.
>
> The kernel is 2.2.13 with some patches.
>
> some logs:
> #cat /proc/interrupts
>            CPU0
>   5:       3231   8xx SIU       cpm
>  15:          0   8xx SIU       tbint
> BAD:          0
> # cat /proc/pci
> cat uses obsolete /proc/pci interface
> PCI devices found:
>   Bus  0, device   3, function  0:
>     ISA bridge: Winbond W83C553 (rev 5).
>       Medium devsel.  Master Capable.  No bursts.
>   Bus  0, device   3, function  1:
>     IDE interface: Winbond SL82C105 (rev 5).
>       Medium devsel.  Fast back-to-back capable.  IRQ 14.  Master
> Capable.  No b
> ursts.  Min Gnt=2.Max Lat=40.
>       I/O at 0x1f0 [0x1f1].
>       I/O at 0x3f4 [0x3f5].
>       I/O at 0x170 [0x171].
>       I/O at 0x374 [0x375].
>       I/O at 0x1000420 [0x1000421].
>       I/O at 0x1000430 [0x1000431].
>   Bus  0, device   7, function  0:
>     Non-VGA device: Motorola Unknown device (rev 0).
>       Vendor id=1057. Device id=5804.
>       Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master
> Capable.  No b
> ursts.
>       I/O at 0x1000000 [0x1000001].
>       I/O at 0x1000100 [0x1000101].
>       I/O at 0x1000200 [0x1000201].
>       I/O at 0x1000300 [0x1000301].
>
>
> --
>
> Regards,
>      Stephan
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
