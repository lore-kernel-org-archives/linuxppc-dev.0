Subject: RE: Problems with I2C reads 
Date: Mon, 5 Aug 2002 10:39:02 -0700
Message-ID: <668950F487446B4FB0CEAE9760FD2D620BE6B5@taurus.primary.local>
From: "Keith Outwater" <Keith_Outwater@mvis.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Murray -
Thanks for the info!  Yes, I think that having an I2C_M_NOSTOP option
would do what I want, but that option is not available in the kernel I'm
using.


>
> You should probably state which kernel and i2c driver you are
> using - there are
> a lot of different versions around.

I'm using a 2.4.x kernel snapshot from Denx's CVS.
Wolfgang, can you comment on your kernel's I2C driver?

>
> Your message indicates you are using some version of the
> "drivers/i2c" code, and
> that you have correctly surmised the method to use (I2C_RDWR ioctl).
>
> The first thing you should do is to run the command "cat
> /proc/bus/i2c" and
> locate the entry for your i2c bus ("i2c-0" in your case). The
> second column
> should be either "i2c" or "smbus/i2c", which indicates that
> the algo driver
> supports the "master_xfer" routine, which is what the
> I2C_RDWR ioctl ends up
> calling.

I checked, and it's plain old "i2c"

>
> But if you are using the old "8xx" algo driver that is in the
> vanilla 2_4_devel
> source, all the "master_xfer" routine does is call write or
> read in sequence
> depending on the message struct.
>
> >I tried using the ioctl() interface and passed I2C_RDWR to try to
> >suppress the stop command between messages, but it does not
> seem to work
> >(checked it on a scope).
>
> Show us some code fragments - what you need is an array of 2
> i2c_msg structs
> the first with the register address (or "sub-address" in i2c
> speak) to write,
> and the second with the same i2c address and the I2C_M_RD
> flag set (and with the
> buf and len set to valid values).

Here's the code:

typedef struct {
	struct i2c_msg	*msgs;
	int  nmsgs;
} msgset_t;

extern int i2c_fd;

int
i2c_test(void)
{
	msgset_t			msgset;
	struct	i2c_msg		msg[2];
	char				msg_buf0[2], msg_buf1[2];

	msgset.msgs = msg;
	msgset.nmsgs = 2;

	msg[0].addr = AD9888_I2C_ADDR;
	msg[0].flags = 0;
	msg[0].len = 1;
	msg[0].buf = msg_buf0;

	msg[1].addr = AD9888_I2C_ADDR;
	msg[1].flags = I2C_M_RD;
	msg[1].len = 1;
	msg[1].buf = msg_buf1;

	msg_buf0[0] = 0x1;
	msg_buf1[0] = AD9888_I2C_ADDR;

	set_i2c_slave_address(AD9888_I2C_ADDR);
	ioctl(i2c_fd,I2C_RDWR,&msgset);
	printf("0x%x\n", msg_buf1[0]);
	return 1;
}

msg_buf1[0] is not being updated by the read.  Using a scope I can see
that the AD9888 acks the write but not the read.  There is a stop
interted between the write and the read.

>
> By the way, there really should be an I2C_M_NOSTOP flag which
> mirrors the
> I2C_M_NOSTART flag - at the moment you just have to assume
> that you don't
> want a stop, otherwise why didn't you just call write
> followed by read.
> I guess this is a reasonable assumption.

I grepped the kernel source and there is no I2C_M_NOSTOP flag.  That
seems to be the problem; what I really need is a write followed by a
read without a stop in between.  The sop is causing the chip to ignre
thre read cycle (i.e. not geneate an ack).

>
> >I looked at the ioctl() handler for I2C_RDWR and it was not
> clear to me
> >whether that particular ioctl option should work with a write-read
> >sequence or not.  As far as I can tell it does not work.
>
> Depends which driver you are using. I tried to implement this
> in my version of
> the driver, but having no need for it, I never tested it. The vanilla
> i2c-algo-8xx.c algorithm driver doesn't support this.
>
> >I looked for other ways to do this, but found nothing.
>
> You found the correct way.
>
> >Has anyone used I2C like this before? Any hints or suggestions?
>
> Try my i2c-algo-cpm.c and i2c-cpm.c drivers - they work as
> loadable modules (but
> unfortunately this needs a patch to commproc.c). This stuff
> was posted to the
> list a while ago, but hasn't made it in yet because it has to
> go via the i2c
> people and I haven't gotten around to it yet. I know of at
> least one person
> who has used it on the 8xx, although not in the way you want. Cheers!
>
> Murray...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
