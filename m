Message-Id: <5.1.0.14.2.20030304062954.0261de18@falcon.si.com>
Date: Tue, 04 Mar 2003 06:40:51 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: mpc8241/8245 floating point unit
In-Reply-To: <00018963.C22236@avantwave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't have 8241/8245 experience, but I do have 8260 experience (also uses
the 603e core).  Floating point (FPU) works well under linux.

Using floating point in the kernel is severely frowned on, however, because
it takes time, both for the calculations and for additional FPU register
store/restore operations (big speed hit).  IIRC, you need to specially
configure the kernel or modify the kernel because the kernel assumes it
does NOT execute floating point instructions internally and therefore
doesn't save/restore the FPU registers for its internal use (i.e. the
kernel context does not have FPU registers saved/restored, user contexts do
have FPU registers saved/restored).  You don't want to go there unless you
really, really have to and if you think about the problem a bit, I suspect
you will discover you don't have to.

Pretty much any fairly recent gcc compiler should work.

For a very good head start in configuring your environment, see Wolfgang
Denk's Embedded Linux Development Kit (ELDK).
   http://www.denx.de/e/index1.php?main=doc/ELDK/index

gvb


At 09:38 AM 3/4/2003 -0500, ivancheng@avantwave.com wrote:

>Hi,
>
>     We are evaluating the mpc8241/8245 on the floating point unit.  For they
>are based on the 603e core, there is a hardware floating point support.  And
>we are going to cross-compile the kernel and apps in intel platform.  I am
>very interested to know
>
>- whether the FPU is supported in the linux distribution in both user/kernel
>mode.
>- If so, how should I compile for the applicaiton/driver with gcc?
>- , and in which version of gcc does it support?
>
>Thanks very much for any comments.
>
>Ivan Cheng
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
