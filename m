From: Benjamin Herrenschmidt <bh40@calva.net>
To: <tom_gall@vnet.ibm.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PowerBook 2000 + Mouse + 2.4.0-test7
Date: Thu, 31 Aug 2000 19:57:48 +0200
Message-Id: <20000831175748.648@mailhost.mipsys.com>
In-Reply-To: <39AE8E35.53F2865@vnet.ibm.com>
References: <39AE8E35.53F2865@vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi All,
>
> quick question, with a 2.4.0-test7 that was fresh as of last Friday.

I don't know for Linus test-7, but I can speak for the current state of
bk 2.4-test8
>
> On my PowerBook 2000, the kernel machine checks when it init's the
>serial ports

You probably have the "legacy" (dumb) serial ports compiled in. The
Macintosh serial ports are a separate option. The ISA bus doesn't exist,
an nobody answer to legacy IO addresses on a mac, thus causing the
machine check.

>and once I redid my config file to remove that support, kernel boots but X no
>longer recognizes the trackpad. (Yet on a 2.2.x series with the ibook
>kernels it
>does)  Is this a known problem?

Get the bk tree. In the "Macintosh Drivers" option, you can either enable
the ADB HID that comes with the input devices, or the old mac_keyb.c
driver. If you are using the mac_keyb.c driver, then you can also select
the old adbmouse.c driver in "Char devices/Mice). This should allow your
current 2.2.x setup to work.

If you want to switch to the new input layer, then enable the ABD HID.
You'll have to create the appropriate /dev entries for, at least, /dev/
input/mice, and change /dev/usbmouse and /dev/mouse to point to it. You
can safely remove /dev/adbmouse. Note that the old adbmouse driver was
BusMouse protocol while the new input layer provides you with PS/2 datas,
like USB mice.

Ben (who is happily running 2.4 on the Pismo powerbook (2000)).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
