Message-ID: <3AFE70AD.82BA5ED4@folkwang-hochschule.de>
Date: Sun, 13 May 2001 13:31:57 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
References: <3AFE3C09.835966B5@folkwang-hochschule.de> <20010513100649.25517@smtp.wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >
> >well, it looks like it's going to sleep, but the standby led doesn't
> >blink. just like when i switch it off, except i can't switch it on
> >again by simply pressing "power", so i suspect it hangs.
>
> Ok, well, it dies. Are you in console or X mode when that happens ?

it happens in both modes.

> >> >* the box falls asleep sometimes even when i'm busy typing or moving
> >> >the mouse. this happens at least once every half hour.
> >>
> >> What do you mean by "fall asleep" ? it stops working ? how do you
> >> get it back ?
>
> >it enters sleep mode, even though there are pretty many keyboard and
> >mouse events that should keep it from doing so.
> >i get it back by pressing a key after waiting a few seconds.
> >(immediately after entering sleep mode, key events seem to be
> >ignored for a few seconds.)
>
> Are you sure it's actually sleep mode (with the blinking sleep LED) ?
> and not the console blank mode or X blank mode ?

yes. the led is blinking.

besides, when only blanking, the system is back on immediately,
while in the case described above, it takes a few seconds. plus it
acknowledges the wakeup event by rapidly flashing the standby led a
few times while waking.

> That's really weird.... maybe pmud incorrectly thinks you are running
> off an empty battery ?

i don't think so. i have set it up to shut the box down when the
battery runs low.
and when it occured, there was always at least 1/2 of a battery left
(according to the meters on the battery modules themselves). oh,
btw, i'm using two batteries.

here is a syslog excerpt from booting to falling asleep in spite of
me typing (this time on a console):

May 14 13:07:19 ephraim syslogd 1.3-3: restart.
May 14 13:07:19 ephraim sshd[204]: RSA key generation complete.
May 14 13:07:21 ephraim usbmgr[220]: start 0.4.1
May 14 13:07:21 ephraim usbmgr[222]: "hid" was loaded
May 14 13:07:21 ephraim usbmgr[222]: "mousedev" was loaded
May 14 13:07:21 ephraim usbmgr[222]: "usb-ohci" was loaded
May 14 13:07:21 ephraim usbmgr[227]: mount /proc/bus/usb
May 14 13:07:21 ephraim usbmgr[222]: class:0x9 subclass:0x0
protocol:0x0
May 14 13:07:21 ephraim usbmgr[222]: USB device is matched the
configuration
May 14 13:07:21 ephraim usbmgr[222]: "none" isn't loaded
May 14 13:07:22 ephraim kernel: klogd 1.3-3, log source = /proc/kmsg
started.
May 14 13:07:22 ephraim kernel: Inspecting /boot/System.map
May 14 13:07:22 ephraim kernel: Loaded 16080 symbols from
/boot/System.map.
May 14 13:07:22 ephraim kernel: Symbols match kernel version 2.4.4.
May 14 13:07:22 ephraim kernel: Loaded 65 symbols from 3 modules.
May 14 13:07:22 ephraim kernel: usb.c: registered new driver
usbdevfs
May 14 13:07:22 ephraim kernel: usb.c: registered new driver hub
May 14 13:07:22 ephraim kernel: PCI: Enabling device 01:18.0 (0000
-> 0002)
May 14 13:07:22 ephraim kernel: usb-ohci.c: USB OHCI at membase
0xcd914000, IRQ 27
May 14 13:07:22 ephraim kernel: usb-ohci.c: usb-01:18.0, Apple
Computer Inc. KeyLargo USB
May 14 13:07:22 ephraim kernel: usb.c: new USB bus registered,
assigned bus number 1
May 14 13:07:22 ephraim kernel: hub.c: USB hub found
May 14 13:07:22 ephraim kernel: hub.c: 2 ports detected
May 14 13:07:22 ephraim kernel: PCI: Enabling device 01:19.0 (0000
-> 0002)
May 14 13:07:22 ephraim kernel: usb-ohci.c: USB OHCI at membase
0xcd916000, IRQ 28
May 14 13:07:22 ephraim kernel: usb-ohci.c: usb-01:19.0, Apple
Computer Inc. KeyLargo USB (#2)
May 14 13:07:22 ephraim kernel: usb.c: new USB bus registered,
assigned bus number 2
May 14 13:07:22 ephraim kernel: hub.c: USB hub found
May 14 13:07:22 ephraim kernel: hub.c: 2 ports detected
May 14 13:07:22 ephraim kernel: usb.c: registered new driver hid
May 14 13:07:23 ephraim pmud[270]: pmud [treshold = 420, margin =
15] started
May 14 13:07:23 ephraim pmud[270]: PMU version 12: iBook
May 14 13:07:23 ephraim pmud[270]: Sleep for this PMU unsupported:
will shutdown the machine on sleep request

^^^^^^^^^^^^^^^^^^^^^^^^^^ (i have not been able to find a newer
pmud version - anyway, it DOES sleep)

May 14 13:07:23 ephraim pmud[271]: running /etc/power/pwrctl minimum
battery
May 14 13:07:23 ephraim pmud[270]: daemon stopped (parent exiting
[note PID])
May 14 13:07:23 ephraim pwrctl: no function for PMU 12
May 14 13:07:24 ephraim modprobe: modprobe: Can't locate module
net-pf-10
May 14 13:07:24 ephraim /usr/sbin/cron[305]: (CRON) STARTUP (fork
ok)
Mai 14 13:08:25 ephraim PAM-unix2[367]: session started for user
nettings, service xdm
May 14 13:12:11 ephraim login: FAILED LOGIN 1 FROM /dev/tty1 FOR
root, Authentication failure

^^^^^^^ now i log in as root and view logfiles. suddenly, while
typing, the box goes to sleep:

May 14 13:15:01 ephraim pmud[271]: initiating user requested sleep

how can i request sleep ? is there some hotkey that i might be
triggering ? but then, it seems to happen no matter what i type.

May 14 13:15:01 ephraim pmud[271]: running /etc/power/pwrctl sleep
battery
May 14 13:15:01 ephraim pwrctl: no function for PMU 12
May 14 13:15:01 ephraim pmud[271]: going to sleep

^^^^^^^^ i press a key after about 1 sec, the standby led flashes
quickly, the disk spins up again, the screen comes back.
after less than 10 secs, it is up again.

looking at the timestamps, syslogd seems to log the events only
after the system is back:

May 14 13:15:18 ephraim kernel: usb-ohci.c: USB suspend: usb-01:18.0
May 14 13:15:18 ephraim kernel: usb-ohci.c: USB suspend: usb-01:19.0
May 14 13:15:18 ephraim kernel: hda: Enabling Ultra DMA 4
May 14 13:15:18 ephraim kernel: usb-ohci.c: USB continue:
usb-01:18.0 from host wakeup
May 14 13:15:18 ephraim kernel: usb-ohci.c: USB continue:
usb-01:19.0 from host wakeup
May 14 13:15:18 ephraim kernel: adb: starting probe task...
May 14 13:15:18 ephraim pmud[271]: system awake again
May 14 13:15:18 ephraim pmud[271]: running /etc/power/pwrctl wakeup
battery
May 14 13:15:18 ephraim pwrctl: no function for PMU 12
May 14 13:15:20 ephraim kernel: adb devices: [2]: 2 c4 [3]: 3 1 [7]:
7 1f
May 14 13:15:20 ephraim kernel: keybdev.c: Removing keyboard: input1
May 14 13:15:20 ephraim kernel: ADB keyboard at 2, handler 1
May 14 13:15:20 ephraim kernel: Detected ADB keyboard, type ISO,
swapping keys.
May 14 13:15:20 ephraim kernel: event1: Event device for input1
May 14 13:15:20 ephraim kernel: keybdev.c: Adding keyboard: input1
May 14 13:15:20 ephraim kernel: input1: ADB HID on ID 2:2.c4
May 14 13:15:20 ephraim kernel: event2: Event device for input2
May 14 13:15:20 ephraim kernel: input2: ADB HID on ID 7:7.1f
May 14 13:15:20 ephraim kernel: ADB mouse at 3, handler set to 4
(trackpad)
May 14 13:15:20 ephraim kernel: event3: Event device for input3
May 14 13:15:20 ephraim kernel: mouse1: PS/2 mouse device for input3
May 14 13:15:20 ephraim kernel: input3: ADB HID on ID 3:3.01
May 14 13:15:20 ephraim kernel: adb: finished probe task...
May 14 13:15:38 ephraim su: (to nobody) root on none
May 14 13:15:38 ephraim PAM-unix2[820]: session started for user
nobody, service su

if you're interested, i can provide another excerpt of the box
falling asleep after waking.
you don't happen to have some good places for printk's to zero in on
the problem, have you ?
i'd be glad to put some in, but i could never work out for myself
where.

regards,

jörn



--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://icem-www.folkwang-hochschule.de/~nettings/
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
