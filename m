Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Sat, 24 Jul 2004 09:07:46 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: different device file name when relocating SMC1?
Message-ID: <Pine.LNX.4.60.0407240816340.11139@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


      working with the latest 2.4.25 kernel tree from denx (sorry, i know
everyone else is keen on 2.6, but we do have a project to maintain), i
have a baseline kernel config for our 850DE board with SMC1 UART, and
no networking configured in yet.  i just wanted to test the simple
relocation of SMC1 *in* *preparation* for adding ethernet on SCC3, so
i added the ucode patches to shift SMC1 (that was the only change in
the kernel config), and a couple of us moved over the patches from the
old uart.c file as best we could.

      with just this change, all we now get at boot time is:

Linux/PPC load: console=ttyS0,9600 rw root=/dev/ram0
Uncompressing Linux...done.
Now booting the kernel

... and hang ...

      so, simple question -- until now, we've identified the console as
ttyS0, and it's worked fine.  does relocation require referring to the
console with a different device file name?  i (vaguely) recall /dev
entries with names like cpmuart0 or something like that.  given
relocation, should i be using something other than "ttyS0"?

      (chances are, of course, we have to mess with uart.c a bit longer to
see what's different between the two 2.4 kernel trees, but i thought
i'd ask if it could be something this simple.)

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
