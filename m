Message-Id: <200007200919.KAA12257@hyperion.valhalla.net>
Date: Thu, 20 Jul 2000 10:19:54 +0100
Subject: Re: problems about __cli() 
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Rolf,

 Thu, Jul 20, 2000, Rolf Liu wrote:
> I am currently compiling the kernel 2.2.13.
> A problem occours, it said the "__cli() is not defined".
> I wonder where the __cli() is defined in the kernel tree, which file is it
> in ?
> thanks a  lot.

(at 2.2.17preZZ - any reason for using 2.2.13?)

Where "your-kernel-foo-bar" is the source tree you are working with:

__cli() is defined in:

/usr/src/your-kernel-foo-bar/include/asm-ppc/system.h

asm-ppc is symlinked to /usr/src/your-kernel-foo-bar/include/asm by the
build process.

the function is implemented in:

/usr/src/your-kernel-foo-bar/arch/ppc/kernel/misc.S

It is *vital* to make sure that there is a symlink named 'linux' in /usr/src
that points to your /usr/src/your-kernel-foo-bar/ because there are symlinks
in /usr/include that expect to use this to find the build-specific headers.

hope this helps,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
