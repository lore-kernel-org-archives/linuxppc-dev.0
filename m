Return-Path: <khali@linux-fr.org>
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124])
	by ozlabs.org (Postfix) with ESMTP id 0C1B1B7BA2
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 20:23:09 +1100 (EST)
Date: Tue, 13 Oct 2009 11:23:04 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
Subject: i2c-powermac fails
Message-ID: <20091013112304.74083fd1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Tim Shepard <shep@alum.mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben, Paul,

I had a report by Tim Shepard (Cc'd) that the therm_adt746x driver
sometimes fails to initialize on his PowerBook G4 running kernel
2.6.31. The following error message can be seen in the logs when the
failure happens:

therm_adt746x 7-002e: Thermostat failed to read config!

After enabling low-level i2c debugging, it turns out that the problem
is caused by low-level errors at the I2C bus level:

PowerMac i2c bus pmu 2 registered
PowerMac i2c bus pmu 1 registered
PowerMac i2c bus mac-io 0 registered
low_i2c:xfer() chan=0, addrdir=0x5d, mode=4, subsize=1, subaddr=0x0, 1 bytes, bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
low_i2c:kw_handle_interrupt(state_addr, isr: 6)
low_i2c:KW: NAK on address
low_i2c:xfer error -6
i2c-adapter i2c-7: I2C transfer at 0x2e failed, size 2, err -6
therm_adt746x 7-002e: Thermostat failed to read config!
PowerMac i2c bus uni-n 0 registered

So apparently the I2C controller doesn't see the ack from the ADT7467.
However the ADT7467 is a SMBus-compliant device, so it must always ack
his address.

It is worth noting that many other I2C errors happen and go unnoticed.
Below is the log of a "successful" therm_adt746x registration:

PowerMac i2c bus pmu 2 registered
PowerMac i2c bus pmu 1 registered
PowerMac i2c bus mac-io 0 registered
low_i2c:xfer() chan=0, addrdir=0x5d, mode=4, subsize=1, subaddr=0x0, 1 bytes, bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
low_i2c:kw_handle_interrupt(state_addr, isr: 2)
low_i2c:kw_handle_interrupt(state_read, isr: 5)
adt746x: ADT7467 initializing
low_i2c:xfer() chan=0, addrdir=0x5d, mode=4, subsize=1, subaddr=0x6b, 1 bytes, bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
low_i2c:kw_handle_interrupt(state_addr, isr: 2)
low_i2c:kw_handle_interrupt(state_read, isr: 5)
low_i2c:xfer() chan=0, addrdir=0x5c, mode=3, subsize=1, subaddr=0x6b, 1 bytes, bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
low_i2c:kw_handle_interrupt(state_addr, isr: 6)
low_i2c:KW: NAK on address
low_i2c:xfer error -6
i2c-adapter i2c-7: I2C transfer at 0x2e failed, size 2, err -6
low_i2c:xfer() chan=0, addrdir=0x5d, mode=4, subsize=1, subaddr=0x6a, 1 bytes, bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
low_i2c:kw_handle_interrupt(state_addr, isr: 2)
low_i2c:kw_handle_interrupt(state_read, isr: 1)
low_i2c:kw_handle_interrupt(state_stop, isr: 4)
low_i2c:xfer() chan=0, addrdir=0x5c, mode=3, subsize=1, subaddr=0x6a, 1 bytes, bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001124fffed61a88]
low_i2c:kw_handle_interrupt(state_addr, isr: 6)
low_i2c:KW: NAK on address
low_i2c:xfer error -6
i2c-adapter i2c-7: I2C transfer at 0x2e failed, size 2, err -6
low_i2c:xfer() chan=0, addrdir=0x5d, mode=4, subsize=1, subaddr=0x6c, 1 bytes, bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
low_i2c:kw_handle_interrupt(state_addr, isr: 2)
low_i2c:kw_handle_interrupt(state_read, isr: 5)
low_i2c:xfer() chan=0, addrdir=0x5c, mode=3, subsize=1, subaddr=0x6c, 1 bytes, bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
low_i2c:kw_handle_interrupt(state_addr, isr: 2)
low_i2c:kw_handle_interrupt(state_write, isr: 1)
low_i2c:kw_handle_interrupt(state_stop, isr: 4)
adt746x: Lowering max temperatures from 81, 80, 87 to 70, 50, 70
low_i2c:xfer() chan=0, addrdir=0x5d, mode=4, subsize=1, subaddr=0x5c, 1 bytes, bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
eth0: Link is up at 1000 Mbps, full-duplex.
low_i2c:kw_handle_interrupt(state_addr, isr: 6)
low_i2c:KW: NAK on address
low_i2c:xfer error -6
i2c-adapter i2c-7: I2C transfer at 0x2e failed, size 2, err -6
low_i2c:xfer() chan=0, addrdir=0x5c, mode=3, subsize=1, subaddr=0x5c, 1 bytes, bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
low_i2c:kw_handle_interrupt(state_addr, isr: 6)
low_i2c:KW: NAK on address
low_i2c:xfer error -6
i2c-adapter i2c-7: I2C transfer at 0x2e failed, size 2, err -6
low_i2c:xfer() chan=0, addrdir=0x5c, mode=3, subsize=1, subaddr=0x30, 1 bytes, bus /uni-n@f8000000/i2c@f8001000/i2c-bus@0
low_i2c:kw_handle_interrupt(state_addr, isr: 2)
low_i2c:kw_handle_interrupt(state_write, isr: 1)
low_i2c:kw_handle_interrupt(state_stop, isr: 4)
PowerMac i2c bus uni-n 0 registered

As you can see there are 4 errors, but the config register read doesn't
fail so this is considered a success.

Ever heard of this problem?

One very interesting thing I've noticed is that therm_adt746x register
access _after_ the initialization works reliably. Errors only happen in
probe_thermostat(). This makes me suspect that the problem is either a
low level initialization happening too late, or another initialization
step happening in parallel and interfering with probe_thermostat().

Tim found evidences in older boot logs that the problem isn't new and
was already present back in kernel 2.6.24 at least.

Any idea what the problem can be and/or how to debug it further?

-- 
Jean Delvare
