Message-ID: <20011021225419.11793.qmail@web13107.mail.yahoo.com>
Date: Sun, 21 Oct 2001 15:54:19 -0700 (PDT)
From: Dave Ray <g4tinker@yahoo.com>
Subject: Sound on G4 tower, almost
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone explored sound on the G4 towers? I
understand they use an 12c-based sound card similar to
the iBook2.

I tried the iBook sound hack on the G4 tower to see
what happens. It appears to be partly successful. The
sound driver loads and registers the deq, but when I
try to do anything that writes to the device I get
silence and "can't locate module..." errors in the
syslog. Below are the details. I'm guessing the hack
is partly successful but the "tumbler" is failing.

I'm wondering if there is any info I can capture from
my system to help developers with this. I will try to
familiarize myself with the hardware and the tunbler
code.

Here is what I see is /var/log/messages when I
modprobe:

> modprobe i2c-core

Oct 19 20:52:53 garuda kernel: i2c-core.o: i2c core
module

> modprobe i2c-keywest

Oct 19 20:53:03 garuda kernel: Keywest device found:
/uni-n@f8000000/i2c@f8001000
Oct 19 20:53:03 garuda kernel: i2c-core.o: adapter
keywest i2c registered as adapter 0.
Oct 19 20:53:03 garuda kernel: Keywest device found:
/pci@f2000000/mac-io@17/i2c@18000
Oct 19 20:53:03 garuda kernel: i2c-core.o: adapter
keywest i2c registered as adapter 1.

> modprobe i2c-dev

Oct 19 20:53:12 garuda kernel: i2c-dev.o: i2c /dev
entries driver module
Oct 19 20:53:12 garuda kernel: i2c-core.o: driver
i2c-dev dummy driver registered.
Oct 19 20:53:12 garuda kernel: i2c-dev.o: Registered
'keywest i2c' as minor 0
Oct 19 20:53:12 garuda kernel: i2c-dev.o: Registered
'keywest i2c' as minor 1

> modprobe soundcore
> modprobe dmasound_core
> modprobe dmasound_pmac

Oct 19 20:53:48 garuda kernel: dmasound_pmac: found
Keylargo rev 2 or later - H/W byte-swap disabled
Oct 19 20:53:48 garuda kernel: AE-In
awacs_tumbler_init
Oct 19 20:53:48 garuda kernel: Resetting audio
Oct 19 20:53:48 garuda kernel: address = [DA37B075]
Oct 19 20:53:48 garuda kernel: status = 1
Oct 19 20:53:48 garuda kernel: tumbler:no device
Oct 19 20:53:48 garuda kernel: tas3001c driver version
0.1 (20010812)
Oct 19 20:53:48 garuda kernel: i2c-core.o: driver
TAS3001C driver  V 0.1 registered.
Oct 19 20:53:48 garuda kernel: i2c-keywest: Ack Status
on addr expected but got: 0x09 on addr: 0x34
Oct 19 20:53:48 garuda kernel: i2c-core.o: client [tas
3001c Digital Equalizer] registered to adapter
[keywest i2c](pos. 0).
Oct 19 20:53:48 garuda kernel: AE-Init tumbler mixer
Oct 19 20:53:48 garuda kernel: PowerMac Tumbler  DMA
sound driver rev 016 installed
Oct 19 20:53:48 garuda kernel: Core driver edition
01.06 : PowerMac Built-in Sound driver edition 00.06
Oct 19 20:53:48 garuda kernel: Write will use    4
fragments of   32768 bytes as default

Oct 19 20:54:38 garuda modprobe: modprobe: Can't
locate module sound-slot-1
Oct 19 20:54:38 garuda modprobe: modprobe: Can't
locate module sound-service-1-0


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
