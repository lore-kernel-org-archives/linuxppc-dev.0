To: "Keith Outwater" <Keith_Outwater@mvis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with I2C reads 
In-Reply-To: Message from "Keith Outwater" <Keith_Outwater@mvis.com>
   of "Fri, 02 Aug 2002 13:36:13 MST." <668950F487446B4FB0CEAE9760FD2D620BE6B3@taurus.primary.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Aug 2002 16:27:51 +1000
Message-ID: <22922.1028528871@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2 Aug 2002 13:36:13 -0700, "Keith Outwater" <Keith_Outwater@mvis.com> writes:
>I am trying to talk to an I2C device (Analog Devices AD9888) using the
>MPC860 CPM I2C interface from userland.

You should probably state which kernel and i2c driver you are using - there are
a lot of different versions around.

Your message indicates you are using some version of the "drivers/i2c" code, and
that you have correctly surmised the method to use (I2C_RDWR ioctl).

The first thing you should do is to run the command "cat /proc/bus/i2c" and
locate the entry for your i2c bus ("i2c-0" in your case). The second column
should be either "i2c" or "smbus/i2c", which indicates that the algo driver
supports the "master_xfer" routine, which is what the I2C_RDWR ioctl ends up
calling.

But if you are using the old "8xx" algo driver that is in the vanilla 2_4_devel
source, all the "master_xfer" routine does is call write or read in sequence
depending on the message struct.

>I tried using the ioctl() interface and passed I2C_RDWR to try to
>suppress the stop command between messages, but it does not seem to work
>(checked it on a scope).

Show us some code fragments - what you need is an array of 2 i2c_msg structs
the first with the register address (or "sub-address" in i2c speak) to write,
and the second with the same i2c address and the I2C_M_RD flag set (and with the
buf and len set to valid values).

By the way, there really should be an I2C_M_NOSTOP flag which mirrors the
I2C_M_NOSTART flag - at the moment you just have to assume that you don't
want a stop, otherwise why didn't you just call write followed by read.
I guess this is a reasonable assumption.

>I looked at the ioctl() handler for I2C_RDWR and it was not clear to me
>whether that particular ioctl option should work with a write-read
>sequence or not.  As far as I can tell it does not work.

Depends which driver you are using. I tried to implement this in my version of
the driver, but having no need for it, I never tested it. The vanilla
i2c-algo-8xx.c algorithm driver doesn't support this.

>I looked for other ways to do this, but found nothing.

You found the correct way.

>Has anyone used I2C like this before? Any hints or suggestions?

Try my i2c-algo-cpm.c and i2c-cpm.c drivers - they work as loadable modules (but
unfortunately this needs a patch to commproc.c). This stuff was posted to the
list a while ago, but hasn't made it in yet because it has to go via the i2c
people and I haven't gotten around to it yet. I know of at least one person
who has used it on the 8xx, although not in the way you want. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
