To: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: debugging using bdi2000, unable to proceed. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 18 Apr 2003 17:13:24 +0530."
             <3E9FE4DC.8040704@tataelxsi.co.in>
Date: Fri, 18 Apr 2003 16:51:17 +0200
Message-Id: <20030418145122.6C0B6C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Om,

in message <3E9FE4DC.8040704@tataelxsi.co.in> you wrote:
>
> > Don't do this. Build a PPCBoot image as usual using the mkimage tool,
> > and use PPCboot to download and start the kernel. Use the BDI2000 for
> > debugging only.
> Hi,
> We tried loading a ppcboot image of linux kernel and ramdisk referring
> the document and
> http://lists.linuxppc.org/linuxppc-embedded/200108/msg00188.html.
> What we did is,
> power up both bdi2k and target.
> We got ppcboot prompt on the serial console.
> Setup the bdi2000 using serial connection from the host (using bdisetup
> executable) telnet to bdi2000. bdi2000 picks up the configuration file
> and configures target and itself. in host, ppc_82xx-gdb <path to
> vmlinux> put breakpoint at start_kernel

This sequence is wrong.  _First_  configure  and  boot  the  BDI2000.
Connect  to  the  BDI2000 over telnet. Type "reset" and "go" to start
PPCBoot.

Use PPCBoot to load the kernel etc.

_Then_ "halt" with the BDI2000, set any  breakpoints  you  need,  and
continue  execution  ("go").  The use "bootm" in PPCBoot to start the
kernel.

> Now ideally we should be able to give bootm <image loc> <ramdisk loc>
> from ppcboot. but bdi2k holds the target in debug mode. In this state we
> are unable to enter any command into ppcboot prompt.

This is because the init sequence of  the  BDI2000  will  reset  your
board.  Didn't  you  see  this  from  the  output? The BDI2000 prints
readable messages - read and try to understand them.

> I think there is some configuration that we need to change in the bdi
> supplied file like bdimode and breakmode. Is it so? I cannot think of
> any other reason.

The reason is pilot error.



Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All I ask is a chance to prove that money can't make me happy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
