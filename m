Subject: Problems with I2C reads
Date: Fri, 2 Aug 2002 13:36:13 -0700
Message-ID: <668950F487446B4FB0CEAE9760FD2D620BE6B3@taurus.primary.local>
From: "Keith Outwater" <Keith_Outwater@mvis.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings all -

I am trying to talk to an I2C device (Analog Devices AD9888) using the
MPC860 CPM I2C interface from userland.
Writes work fine, but the chip requires a strange write-read sequence
for reading back registers.  For example, to read a register:

Start signal
Slave address (r/w/ bit = write)
Register address
Start signal
Slave address (r/w/ bit = read)
Read register data
Stop signal

Note that there is no stop between the write and the read.  If you put a
stop in, the chip will not acknowledge the read, so using /dev/i2c-0
with write() and read() does not work.

I tried using the ioctl() interface and passed I2C_RDWR to try to
suppress the stop command between messages, but it does not seem to work
(checked it on a scope).
I looked at the ioctl() handler for I2C_RDWR and it was not clear to me
whether that particular ioctl option should work with a write-read
sequence or not.  As far as I can tell it does not work.
I looked for other ways to do this, but found nothing.

Has anyone used I2C like this before? Any hints or suggestions?

Thanks!
Keith

Keith Outwater
Senior Staff Engineer
Microvision, Inc.
(425) 415-6693


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
