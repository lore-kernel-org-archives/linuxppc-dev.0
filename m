Message-ID: <39BD8145.E1ECEF7@m2tech.co.nz>
Date: Tue, 12 Sep 2000 13:05:09 +1200
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: Paolo Scaffardi <arsenio@tin.it>
CC: embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Console output to framebuffer device: how?
References: <001501c01c0a$ce17f0a0$0a00010a@paoloweb>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paolo Scaffardi wrote:

> I wrote a framebuffer device that i included in the kernel, but i dont know
> how to redirect the output of the console to my framebuffer device instead
> of the serial console.
>
> During the startup the kernel initializes the framebuffer correctly, and
> says:
>
> "Console: switching to frame buffer device"
>
> but nothing happens on it and the output is given only to serial console.
>
> What should i do to make it work correctly, now?

try adding the boot argument "console=tty0", this should make the main
console
the framebuffer.. if you want to output some text just to test it, try:

echo "this is a test" > /dev/tty1

then you can change to this virtual terminal with the command:

chvt 1

(you should already be default on terminal 1)...  if you are wanting the
framebuffer to be the main console, you may have to set up a dummy
console,
check the pmac_setup.c file for details on setting this up.. (ie.
conswitchp =
&dummycon)..

hope this can help,

ben

--
/\\------------------------------------------------------------------
ben.bodley/.m2technologyltd.nz/.benb@m2tech.co.nz/.64.9.4448307ext130

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
