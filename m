Subject: Re: ibook2r2 & strange freeze.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brice Figureau <brice@tincell.com>
Cc: "Linuxppc-Dev@Lists.        " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <B575F872-7771-11D7-BD12-0003939D5F18@tincell.com>
References: <B575F872-7771-11D7-BD12-0003939D5F18@tincell.com>
Content-Type: text/plain
Message-Id: <1051353230.10342.31.camel@gaston>
Mime-Version: 1.0
Date: 26 Apr 2003 12:33:50 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> After several hours of kernel compiling (my ibook is not that fast
> ;-)), I found that the latest working patch is -ben8.
> The first non working is then -ben9.

Great, many thanks. That will help.

Can you try now to put drivers/video/radeonfb.c from -ben8 into
-ben9 (and then -ben10 if it works) and tell me if that helps ?

> I can crash ben9 almost reproductibly and xmon is triggered if that can
> help you (I didn't understand how to use the System.map with xmon to
> decipher the stack trace, but I might send xmon output and my
> System.map).
> Note this might not be the same crash as ben10, because xmon is not
> fired with this kernel, although it seems to crash at the early
> beginning of rc.sysinit (I'm almost sure this is something about the
> fonts).

The system.map thing might not help (if the crash is random), but
basically, you just need to copy System.map next to vmlinux (in
/boot typically) and edit yaboot.conf to add a line

  sysmap=/boot/System.map

after the image=... line (and re-run ybin to install the new yaboot.conf)

With this, xmon will know about symbols. Then, you can use the "t"
command in xmon to get a backtrace.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
