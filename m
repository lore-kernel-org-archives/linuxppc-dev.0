Message-ID: <009701c1d1f3$b11d7380$0200010a@WT0136>
From: "Ho-Kuo Chan" <hchan@wavesat.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Serial console not accepting input
Date: Fri, 22 Mar 2002 17:48:32 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    I have managed to get kernel 2-4-19-pre3 booting on my PPC405 GP based
custom board (which is based on the Walnut). The problem is that the serial
console does not accept any input. When I say this I mean the typed
characters are receievd but ignored. I know this because I turned on the
SERIAL_DEBUG_INTR flag on and the chars are received. I then traced the code
to find that in receive_chars in drivers/char/serial.c, the chars are only
accepted if the ignore_status_mask does not have the recieve buffer not
empty bit set. Well the ignore_status_mask is set in the function
change_speed if the cflag variable is not equal to CREAD:

if ((cflag & CREAD) == 0)
    info->ignore_status_mask |= UART_LSR_DR;

The cflag is equal to the tty's termios.c_cflag which I believe is set to
the serial console driver's cflag. I checked the sercons.cflag and it is
originally set to CREAD | HUPCL | CLOCAL in serial_console_setup called when
the driver is registered in register_console via serial_console_init.
However, the sercons.cflag is set to 0 in rs_open() in drivers/serial.c
which is called when tty_open is called. tty_open is called several times
during the boot process and as such, results in the ignore_status_mask being
set, causing the console to ignore input chars. So my question in all of
this is: why is the sercons.cflag set to 0 in rs_open?

Thanks in advance!!!

Ho-Kuo Chan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
