From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14761.39952.597917.43823@argo.linuxcare.com.au>
Date: Mon, 28 Aug 2000 09:54:08 +1100 (EST)
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patches for 2.4.0-test7
In-Reply-To: <Pine.LNX.4.10.10008271823320.3745-100000@opal.biophys.uni-duesseldorf.de>
References: <39A8379C.E4EBB33A@wanadoo.fr>
	<Pine.LNX.4.10.10008271823320.3745-100000@opal.biophys.uni-duesseldorf.de>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:

> That would have been me - I still claim that keeping adbmouse working for
> backwards compatibility would be a good thing, but my word doesn't carry
> much weight.
>
> The adbmouse driver only relies on the keyboard driver for mouse button
> emulation. At least in 2.2.17, it won't interfere with the new input code,
> I haven't tried 2.4.0 yet.

The way it is at the moment in the linuxppc_2_3 bk tree and in my
rsync tree, you have 3 choices:

1. use mac_keyb.c/adbmouse.c and don't have the input layer at all
2. use the input layer for USB devices and mac_keyb.c/adbmouse.c for
   ADB keyboard and mouse
3. use the input layer for both USB and ADB devices.

The adbmouse driver references some external variables which are
declared in mac_keyb.c.  If there is really a need to have adbmouse.c
in the system without mac_keyb.c, we can probably work out a way to
allow that, but I don't see the need.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
