Message-ID: <3E3A9FAD.9070409@imms.de>
Date: Fri, 31 Jan 2003 17:09:17 +0100
From: Rolf Peukert <rolf.peukert@imms.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC850 SCC3/USB host conflict
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody!

We are installing Linux (2.4.4) on a board design using an MPC850
(XSPC850SRZT66C). We're planning to make the device work as USB host
controller, and to use SCC3 as an additional UART.

We're using Brad Parker's USB Host Controller Interface driver
m8xxhci.c, and the USB Host Start-of-Frame microcode patch available on
your site for the MPC823 (MPC823SOFGENMC). Timer 1 is configured to
generate the SOF clock, and PA6/Tout1 is connected to PC15/Dreq0. An
external 48 MHz oscillator on PA4 is used as USB clock.

The standard UART driver (8xx_io/uart.c) is configured to use SMC1 as
console, and SCC3 as an additional UART using PB29/30 (RXD3/TXD3), PC5
(CTS3), PC13 (RTS3) and PC4 (CD3). Ethernet is on SCC2.

As far as I can tell, these pin configurations don't conflict, but still
we are experiencing a conflict between the USB and UART drivers.

USB works fine when SCC3 UART is not enabled, as does SCC3 without USB.
But when both config options are selected, the kernel will hang during
bootup, shortly after the "Enable" bit in the USMOD register is set (in
function rh_port_reset).

With printk statements around that line,
...
         reset_bus_history();
     printk("rh_port_reset() before USMOD_EN\n");
         usbregs->usb_usmod |= USMOD_EN;
     printk("rh_port_reset() after USMOD_EN\n");
         wait_ms(20);
...

the output typically looks like this,
...
Freeing unused kernel memory: 60k init
rh_port_reset(1)
rh_port_reset() before USMOD_EN
rh_port

(with sometimes a few output characters more or less)

The microcode patch is installed during initialization, way before
rh_port_reset() is called.
We found out, that the Kernel will start up with a USB/SCC3
configuration, if the microcode patch is not installed. It will also
start up, if the microcode is installed, but timer 1 (SOF) is not
activated. In these cases, however, USB does not work.

So, we're left rather clueless and will be very grateful for any help.

Are there still possible I/O port conflicts we did not check?
What does the microcode patch actually do?
Is it possible to make USB (host controller mode) and SCC3 UART work
concurrently on the MPC850 at all?


Best Regards,
Rolf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
