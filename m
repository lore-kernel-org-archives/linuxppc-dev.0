Mime-Version: 1.0
Message-Id: <p06020400bc00582c1d91@[192.168.0.23]>
In-Reply-To: <1070760204.12497.23.camel@gaston>
References: 
 <Pine.LNX.4.44.0312061309230.260-100000@kaiso.biophysics.mcw.edu>
 <1070760204.12497.23.camel@gaston>
Date: Sat, 13 Dec 2003 10:34:47 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: error compiling bttv
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Actually, looking as his errors, I think what he needs is
>CONFIG_I2C_ALGOBIT = y

Indeed.

I'm working on building the bttv driver. That hint solved the compile
error. But apparently had I built the bttv driver first, it would
have patched the kernel thusly.

I'm now getting one slight oddity though that I'm not experienced
enough to solve.

The procedure, as I see it, is to download the bttv source (0.9.12)
and run make, make install. This appears to patch the kernel, but
also installs modules. So then, since the kernel was patched, it
appears that I have to rebuild the kernel (and for good measure I do
make modules modules_install as well). But then, it's not clear to me
if I have to make the bttv stuff again.

The order or necessity of which steps is confusing to me. But I went
round and round enough to make it all build, with one small problem:
when I do make install_modules (part of the kernel build), I get

depmod *** Unresolved symbols in /lib/modules/[kernel]/v4l2/video-buf.o
depmod     clear_user_page

And when I do make install (bttv build) I get

depmod *** Unresolved symbols in /lib/modules/[kernel]/v4l2/video-buf.o


These are of course both the result of the depmod -a step. I don't
understand modules well, but IIRC unresolved symbols happen when
there is some other module that is not being loaded. Before I hit up
the bttv maintainer or the v4l2 list, does anyone who has done this
have hints? Any clues on the importance of the clear_user_page
message?


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
