From: Benjamin Herrenschmidt <bh40@calva.net>
To: Benjamin Herrenschmidt <bh40@calva.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: trackpad
Date: Thu, 13 Jul 2000 01:31:59 +0200
Message-Id: <20000712233159.26202@192.168.1.10>
In-Reply-To: <20000712231905.23171@192.168.1.10>
References: <20000712231905.23171@192.168.1.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>>OK, I've tried it. No function from the trackpad still. I downloaded the
>>sources and recompiled. Still no trackpad. I turned off "Enable new input
>>layer" and make dep'd make clean make vmlinux etc and *still* no trackpad!
>>I'm on the Yellow Dog list, and people are starting to report similar
>>problems with 2000 "Pismo" PowerBooks and these kernels...
>
>What's up if you add "adb_xpmac_compat" to your kernel command line ? It
>works fine on my pismo here.

What I wrote can be a bit confusing. I meant:

 - The new layer will create new devices that mix all mice (including
trackpad) and route them to the new /dev/input/mice device. Of course,
you need to create this device (with mknod) and eventually link /dev/
mouse, /dev/adbmouse and /dev/usbmouse (yes, all 3 of them) to /dev/
input/mice. There are some explanation on how to do that on my page.
Those will output imps2 protocol.

 - The latest kernel (pre10-ben1) will keep the old /dev/adbmouse device
alive. That means that if you don't set /dev/adbmouse to point to the new
/dev/input/mice but instead keep it to it's old major/minor, you'll still
get a busmouse-like device on /dev/adbmouse

 - I also added this new "adb_xpmac_compat" kernel command line option
(at least until Xpmac is fixed). With this, the driver will, by default,
enable sending of ADB mouse moves as fake keycodes to the console, like
MkLinux, in a way compatible with Xpmac. The new driver won't do it any
more unless you use that option or your do

echo "1" >/proc/sys/dev/mac_hid/adb_mouse_sends_keycodes

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
