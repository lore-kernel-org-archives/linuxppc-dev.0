Date: Tue, 02 Mar 2004 13:44:15 -0800
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: ml300 system init very slow
In-reply-to: <20040302173411.50777.qmail@web21113.mail.yahoo.com>
To: Lou Rickard <lou_rickard@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <4045002F.1020905@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <20040302173411.50777.qmail@web21113.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lou,

make sure you don't have a mismatch between
arch/ppc/platforms/xilinx_ocp/xparameters_ml300.h and your system.mhs
especially when looking at the interrupt signals and defines. If you
made changes to xparameters_ml300.h you might want to rebuild the kernel
completely:
$ make clean dep bzImage modules.

Besides that I assume that you use a recent kernel (eg. the one in
MVL3.1) and EDK (vs. V2PDK) as a development tool kit.

- Peter


Lou Rickard wrote:

>And as the kernel boots, it loads an improved serial
>module stored on the root filesystem, which works
>fine?  Would that explain why it works fine with
>module support turned on, but doesn't work well with
>module support turned off (and hence stuck using the
>serial module that is built into the kernel)?
>
>~lr
>
>--- "VanBaren, Gerald (AGRE)"
><Gerald.VanBaren@smiths-aerospace.com> wrote:
>
>
>>Just in case nobody answered yet (I didn't see an
>>answer), the problem 99.9999% certainty is that your
>>serial interrupts are not interrupting so the kernel
>>is polling for serial I/O.  This is a fallback
>>operation with REALLY LONG timeouts.  The symptoms
>>are REALLY SLOW console interaction == your
>>symptoms.  Your follow-up message indicates the
>>problem is in your serial driver module.
>>
>>gvb
>>
>>
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
