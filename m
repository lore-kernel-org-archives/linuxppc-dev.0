Message-ID: <39AA16ED.58CF5B8F@wanadoo.fr>
Date: Mon, 28 Aug 2000 09:38:21 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patches for 2.4.0-test7
References: <39A8379C.E4EBB33A@wanadoo.fr>
		<Pine.LNX.4.10.10008271823320.3745-100000@opal.biophys.uni-duesseldorf.de> <14761.39952.597917.43823@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> Michael Schmitz writes:
>
> > That would have been me - I still claim that keeping adbmouse working for
> > backwards compatibility would be a good thing, but my word doesn't carry
> > much weight.

> The way it is at the moment in the linuxppc_2_3 bk tree and in my
> rsync tree, you have 3 choices:
>
> 1. use mac_keyb.c/adbmouse.c and don't have the input layer at all
> 2. use the input layer for USB devices and mac_keyb.c/adbmouse.c for
>    ADB keyboard and mouse
> 3. use the input layer for both USB and ADB devices.
>
> The adbmouse driver references some external variables which are
> declared in mac_keyb.c.  If there is really a need to have adbmouse.c
> in the system without mac_keyb.c, we can probably work out a way to
> allow that, but I don't see the need.

While I fully agree with Paul that it is better to impose clear choices
so you need not check for weird interactions between incompatible mouse
drivers, I find Michael's wish for coexisting old and new ADB mouse
drivers understandable:

When I try different kernels, 2.2.x ones without knowledge about the new
input layer, or 2.4.0 ones with or without new input layer switched on,
the different drivers for the ADB *keyboard* don't present any problem
(as long as I choose to work with raw-adb-keycodes). The whole
configuration is in the kernel, and even X works with either keyboard
model.

For the ADB *mouse*, this is quite different: When I want to use a
kernel with the new input layer for the mouse, it is not sufficient to
boot the correspondingly configured kernel. I also have to change a
couple of files in /etc to tell about the new mouse driver, in my case

/etc/devfsd.conf
/etc/sysconfig/mouse
/etc/X11/XF86Config

Then I have to restart devfsd, rm /dev/mouse, and restart gpm. (In this
order, and all this before starting X, of course).

When I go back to a kernel without new input layer, I have to change all
this back. This wouldn't be necessary if drivers for both /dev/adbmouse
and /dev/input/mice could coexist..

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
