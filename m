To: "Keith Outwater" <Keith_Outwater@mvis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with I2C reads 
In-Reply-To: Message from "Keith Outwater" <Keith_Outwater@mvis.com>
   of "Mon, 05 Aug 2002 10:39:02 MST." <668950F487446B4FB0CEAE9760FD2D620BE6B5@taurus.primary.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Aug 2002 14:59:53 +1000
Message-ID: <24408.1028609993@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 5 Aug 2002 10:39:02 -0700, "Keith Outwater" <Keith_Outwater@mvis.com> writes:
>
>Murray -
>Thanks for the info!  Yes, I think that having an I2C_M_NOSTOP option
>would do what I want, but that option is not available in the kernel I'm
>using.

No, my comment was that for completeness there should be an I2C_M_NOSTOP flag,
but it isn't necessary because you simply assume that if you provide a set of
i2c_msg's which consists of a write followed by a read, it is assumed that you
don't want the STOP in between them. This is how I interpreted things in my
version of the driver.

>I checked, and it's plain old "i2c"

I'm not sure about the "plain old" - but "i2c" is enough for it to work, as
long as your "algo" driver supports the transfers as I outlined above.

>Here's the code:

The code looks correct to me. If you try my version of the driver, posted to
this list recently, it should at least attempt to do the right thing. The
stock standard linuxppc_2_4_devel driver/i2c/i2c-algo-8xx.c will not do what
you want - it will simply do a write followed by a read, with a STOP in
between.

>msg_buf1[0] is not being updated by the read.  Using a scope I can see
>that the AD9888 acks the write but not the read.  There is a stop
>interted between the write and the read.

Looks like Wolfgang's code base has the original "i2c-algo-8xx.c" algo driver.

>I grepped the kernel source and there is no I2C_M_NOSTOP flag.  That
>seems to be the problem; what I really need is a write followed by a
>read without a stop in between.  The sop is causing the chip to ignre
>thre read cycle (i.e. not geneate an ack).

See comment above - the NOSTOP is assumed in my version of the driver. If you
want to think about it another way, the stock standard 8xx algo driver assumes
that you want a STOP between the messages, and my version assumes the opposite.
Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
