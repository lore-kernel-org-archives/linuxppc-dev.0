From: Benjamin Herrenschmidt <bh40@calva.net>
To: Joseph Garcia <jpgarcia@execpc.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: switching consoles
Date: Tue, 18 Jul 2000 23:50:51 +0200
Message-Id: <20000718215051.22873@192.168.1.10>
In-Reply-To: <3974CA79.C5F0AB2B@execpc.com>
References: <3974CA79.C5F0AB2B@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>i'd think that it would be more likely the nvram resetting.  But PMU is
>actually
>on ADB.  as far as i know, all direct pmu ioctls (battery query, etc)
are sent
>to /dev/adb, while interpreted ioctls (like sleep) are sent to /dev/pmu,
which
>is why /dev/pmu features need kernel support and vary from system to system.

Well, in fact, it's exactly the opposite ;)

The PMU is a replacement for Cuda on older machines, and is actually a
microcontroller that, among other things, the the ADB controller of the
machine. When you send PMU commands via /dev/adb, those are passed to the
PMU driver by the ADB layer, and such commands are directly sent to the
PMU. ADB commands are, however, encapsulated in specific PMU commands.

I've done some hacking on MacOS today and found that the Fn key behaviour
can apparently be triggered by setting an ADB register of the keyboard.

If you write 0xc6 0x01 to register 1 of the keyboard, the Fx keys will be
real function keys by default and Fn will trigger the control buttons.
Write 0xc6 00 to revert the behaviour to default.

So a userland tool can be easily hacked using the trackpad tool source as
an example, you have to find the keyboard instead of the trackpad (device
with default and current address 2 should always work on PowerBook and
iBook ADB) and then do the register write of a 2 bytes message
(0xc6 0x01). I can't try this now, but if someone wants to look at it...

>The noodle-scratcher in this is the fact that the keyboard's F-key setting is
>maintained post-sleep, while trackpad tapping is always reset.  both
being ADB
>devs reset upon wake, id think it would get reset.  there could be
>something we
>are missing.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
