Message-ID: <002d01bfc20b$01b79320$d2d3470a@mike>
From: "Mike Hudson" <Exoray@isys.ca>
To: "Takashi Oe" <toe@unlserve.unl.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <Pine.A41.3.96LJ1.1b7.1000518175956.15274G-101000@unlserve.unl.edu>
Subject: Re: BMAC+ & Full Duplex
Date: Fri, 19 May 2000 23:25:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Strange... the util doesn't seem to work at all. The behaviour specified in
MacOS doesn't change. I've verfied all the code line-by-line and (IMHO) the
correct parameters are passed (from the apple technote). The Cuda interface
works, as I've been able to successfully use Paul Mackerras' clock.c to
read/set the clock using the same /dev/adb interface.

For your reference, here's the complete set of ADB pseudo-commands from the
Darwin Source. Some of these are already in the Linux source, some aren't.
Someone should slap this in cuda.h for posterity.

/*
 * ADB Pseudo Commands
 */

#define ADB_PSEUDOCMD_WARM_START         0x00
...START_STOP_AUTO_POLL   0x01
...GET_6805_ADDRESS       0x02
...GET_REAL_TIME      0x03
GET_PRAM           0x07
SET_6805_ADDRESS       0x08
SET_REAL_TIME      0x09
POWER_DOWN         0x0a
SET_POWER_UPTIME      0x0b
SET_PRAM           0x0c
MONO_STABLE_RESET      0x0d
SEND_DFAC          0x0e
BATTERY_SWAP_SENSE     0x10
RESTART_SYSTEM         0x11
SET_IPL_LEVEL      0x12
FILE_SERVER_FLAG       0x13 ***
SET_AUTO_RATE      0x14
GET_AUTO_RATE      0x16
SET_DEVICE_LIST        0x19
GET_DEVICE_LIST        0x1a
SET_ONE_SECOND_MODE    0x1b
SET_POWER_MESSAGES     0x21
GET_SET_IIC        0x22
ENABLE_DISABLE_WAKEUP  0x23
TIMER_TICKLE       0x24
COMBINED_FORMAT_IIC    0x25


A possible explanation for the failure lies in the fact that the Darwin
source calls File Server mode a flag. From my experience a flag is used to
set a minor parameter on another command, not provide any individual
functionality. Possibly the documented "Server Mode" functionality depends
on another value/command? (I'm guessing)

I have three questions:

1) Has anyone independently verified if this utility works?

2) If the powerup time is already passed, will the Mac boot on restoration
of AC power? This could be used to provide similar functionality to the
server mode flag. I.e. set the wakeup time to the current time on boot.

3) Does anyone have any decent documentation on the Cuda and it's commands,
aside from the Darwin snippet, the technote and the linux/darwin sources
(which seem to focus on the clock and power on/off/restart)?

Thanks,

Mike Hudson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
