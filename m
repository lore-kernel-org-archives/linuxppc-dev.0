Subject: Re: reboot by software
From: Gary Thomas <gary@mlbassoc.com>
To: zjzhou@newrocktech.com
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <000101c3c3b8$68333110$b702a8c0@newrock2>
References: <000101c3c3b8$68333110$b702a8c0@newrock2>
Content-Type: text/plain
Message-Id: <1071580258.17911.69.camel@hermes>
Mime-Version: 1.0
Date: 16 Dec 2003 06:10:59 -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-12-16 at 02:38, John Zhou wrote:
> Hello!
>
> I have a linux running on my mpc8260 board( power on reset at
> 0xfff00100, I use 32 bit flash, and directly maping
> 0xF0000000 ~ 0xFFFFFFF in kernel).
>
> Now, I want to reboot system by software. But, when I jump
> to 0xfff00100 in kernel mode, it's going dead. Can anybody help me?

Just jumping into the reset vector of the ROM/FLASH isn't going
to work since Linux is running with the MMU on, etc.  What you
really need is some way to tell the hardware to reenter the
RESET condition.

Probably the best way on that platform is to cause a machine
check (checkstop) and set it up to reset on checkstop.  Look
at the description of HID0 on the 8260 to see how to do it.

Here's how I did it on an 8250 (same core):
    unsigned long hid0;
    // Need interrupts off to force checkstop
    cli();
    ((immap_t *)IMAP_ADDR)->im_clkrst.car_rmr |= 0x01;  // Checkstop reset enable
    // Force a checkstop by turning on parity which is not implemented
    hid0 = mfspr(HID0);
    hid0 |= 0x30000000;
    mtspr(HID0, hid0);

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
