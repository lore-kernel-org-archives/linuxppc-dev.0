Subject: Internal interrupts on the MPC107
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Date: 28 May 2003 11:49:46 +0100
Message-Id: <1054119003.23151.23.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have an interrupt driven driver for the I2C controller of the MPC107
and MPC8245:

http://www.humboldt.co.uk/mpc10xi2c.html

In this driver I attempt to find the interrupt vector for I2C by reading
it directly out of the EPIC hardware in the driver initialisation code:

	i2c_vec = readl(epic_base + 0x11020) & 0xff;

This works fine on my custom board based on the linuxppc_2_4_devel
kernel, but caused problems for an end user using a 2.4.17 kernel from
Montavista. On that kernel, the EPIC register at offset 0x11020
contained 0. Another user with an unknown kernel found 0 in the
register, but was able to make progress by hardcoding the IRQ number 20.

Does anybody have any suggestions for a generic solution? I'd like to
get the driver into the kernel at some point, but this part of the code
seems a bit too ugly for now.

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
