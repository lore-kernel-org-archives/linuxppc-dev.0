Date: Tue, 15 Feb 2000 09:41:33 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: UART driver problem
Message-ID: <Pine.LNX.4.21.0002150923400.11610-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Marcus!

You have fixed uart.c before me (thanks to everybody who pointed it out
for me!), but your arguments were probably not quite convincing, and this
may be the reason why your patch has not yet been applied.

You write:

> Strangely enough drivers/char/serial.c is broken as well in standard
> kernels. The only difference is that there the copy_from_user() will
> appear to always succeed instead of always failing...

drivers/char/serial.c is not broken!

copy_from_user(to, from, len) returns len if it fails and 0 if it
succeeds. Now let's look into drivers/char/serial.c, function rs_write():

c -= copy_from_user(tmp_buf, buf, c);
if (!c) {
        if (!ret)
                ret = -EFAULT;
        break;
}

If copy_from_user succeeds then it returns 0 and c doesn't change. If
copy_from_user fails then it returns the value equal to c. Then c becomes
zero and the function terminates. If no data have been transferred so far,
the result code becomes -EFAULT

Indeed, this code is written in a confusing way, but it is not broken.
Anyway, I don't think that arch/ppc/8xx_io/uart.c should use this style.

Thus your patch is both correct and complete, i.e. it fixes only broken
things. I believe it should be applied both to the 2.2.x and 2.3.x
branches. It is already applied to the version used by my company.

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
