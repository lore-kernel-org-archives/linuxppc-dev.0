Date: Thu, 26 Jun 2003 13:02:04 -0400 (EDT)
From: Chris Studholme <cvs@cs.utoronto.ca>
To: linuxppc-dev@lists.linuxppc.org
Cc: Terry Greeniaus <tgree@phys.ualberta.ca>
Subject: how to setup PLL1 on 750FX
In-Reply-To: <1056275365.3808.49.camel@gaston>
Message-ID: <Pine.LNX.4.44.0306261242570.31017-100000@stoa.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to set PLL1 on my 750FX to a multiplier of 4 (for a clock speed
of 400MHz) so I can eventually use cpufreq, but the machine keeps locking
up.

I know HID1 is 0x92000000 after boot and except for my twiddling of a bit
to detect the 750FX, it is not changed.  This value is slightly confusing.
It indicates that PLL0 is in use, and its config is external.  PLL_CFG is
18 (decimal) which indicates a multiplier of 9x.  That's fine as my cpu
speed is 900MHz on a 100MHz bus.  But PLL_RNG appears to be 01 (binary),
which is labeled as a reserved value in the IBM docs.  What is the purpose
of PLL_RNG (range bits) anyway?

I'm trying to set PLL1 to 4x using the code:

  mtspr(HID1,(mfspr(HID1)&~0xFE)|0x44);

This should set PLL_CFG to a value of 8 (for a multiplier of 4x) and
PLL_RNG to 10 (binary) which the IBM docs say should be used when the
frequency is below 600MHz.  Note that I've also tried 00 and 01 as values
of PLL_RNG and they all fail.  I've tried this both with and without a
delay afterwards.  My delay is simply:

  for (i=0; i<100000000; ++i) j+=i;

Since I never switch the processor to PLL1, the delay shouldn't matter.
The machine doesn't seem to lockup the moment HID1 is changed (ie. in
finish_device_tree()).  It always locks up during the detection of the IDE
devices.  From dmesg output:

  Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
  ide: Assuming 33MHz system bus speed for PIO modes; override with
  idebus=xx
  ide0: Found Apple KeyLargo ATA-4 controller, bus ID 2
  ide1: Found Apple KeyLargo ATA-3 controller, bus ID 1
  ide2: Found Apple KeyLargo ATA-3 controller, bus ID 0 (mediabay)
  Probing IDE interface ide0...
  hda: FUJITSU MHR2020AT D, ATA DISK drive
  hda: Enabling Ultra DMA 4
  Probing IDE interface ide1...
  ide0 at 0xd1806000-0xd1806007,0xd1806160 on irq 19
  hda: attached ide-disk driver.

-> lockup is always here regardless of delay or not and particular setting <-

  hda: host protected area => 1
  hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2432/255/63,
  UDMA(66)
  Partition check:
   /dev/ide/host0/bus0/target0/lun0: [mac] p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13
  usb.c: registered new driver usbdevfs

Is there something else I need to do to set PLL1?

Chris.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
