Return-Path: <skaiser.uci@gmail.com>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.191])
	by ozlabs.org (Postfix) with ESMTP id 4670CDDF7B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 05:13:42 +1100 (EST)
Received: by gv-out-0910.google.com with SMTP id p33so681988gvf.14
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 11:13:40 -0700 (PDT)
Message-ID: <47D6CBA0.9030303@gmail.com>
Date: Tue, 11 Mar 2008 11:12:48 -0700
From: Steve Kaiser <skaiser.uci@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: wait_event_interruptible does not wake_up
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Can I ask you kernel gurus here for some advice?  I am using Linux 
2.4.25 on an Freescale MPC5200B IceCube development board.

I have some trouble waking a user process sent to sleep with 
wait_event[_interruptible].  99% of the time it works fine, but 
sometimes when I call wake_up(), my user process does not wake up.  I 
can see whats happening by toggling LEDs on the board, and watching with 
an oscilloscope.

<-- 50ms -->
      ______     _____
|___|      |___|       LED1 (low active)
_____  _________  ___
      ||         ||     LED4 (low active)

       ^ user thread is finshed here, and goes back to sleep
      ^ user thread is woke up here
     ^ interrupt tasklet finishes here
^ interrupt tasklet starts here

With some testing and hair pulling, I have discovered exactly when (but 
not why) this failure to wake_up happens.  If I install a 10ms kernel 
timer task, and the task occurs while my hardware interrupt service 
tasklet is happening (I feel maybe exactly when it is calling wake_up 
but not sure), that's when the wake_up always fails.

If I eliminate the asynchronous nature of the hardware interrupt, and 
simulate the hardware interrupt by installing a 10ms kernel timer task, 
using the task to toggling an I/O line that I jumper over to the 
hardware interrupt input, then everything works great.  The wake_up() 
never fails with this synchronous configuration.

Anybody heard of such a thing?  Any advice is very welcome.  Here's more 
details and code if you have a spare moment to read:

My very small user program is put to sleep by a driver with 
wait_event_interruptable() when the user program calls device_write(). 
I want the user program to sleep until my hardware is ready.  The 
hardware will interrupt when ready, every 50ms or so.  The hardware is a 
64k word FIFO memory chip, and the interrupt is it's half-full flag 
(latched with flip flop), but that doesn't matter.

When the driver recognizes the hardware interrupt, it should burst a 
chunk of data out to the hardware FIFO, and then wake the user program. 
  The user program writes a new chunk of data to the driver, and gets 
put to sleep again.  The driver holds the data in kobuf, all ready in 
preparation for the next hardware interrupt.

This all works perfectly well-- 99.99% of the time.  But every once in a 
while, the user process does not awake.  My interrupt tasklet recognized 
the interrupt, did call wake_up() for sure, but the process simply did 
not wake up.  Sometimes the process wakes up an arbitrary time later-- 
hundreds of milliseconds sometimes.  The interrupt service tasklet 
otherwise seems to be working reliably, as on the oscilloscope I can see 
the effects of it clearing a hardware flip-flop perfectly every time, 
and this is the call right before wake-up().

I copy below some of the code which may explain things better.  Maybe my 
error is obvious and dumb and if so, I am happy.  Maybe my approach is 
wrong?

Steve Kaiser


static u32 kobuf[FIFO_DEPTH][2];	// output DAC buffer

static int wrq = 0; 	// user sleeps until hdw fifo is half empty
static DECLARE_WAIT_QUEUE_HEAD(WriteQ);

static void gpio_irq_handler (int, void*, struct pt_regs *);
static void gpio_tasklet_handler( unsigned long );
static DECLARE_TASKLET(gpio_tasklet,gpio_tasklet_handler,0);


/* ----------------------------------------------------------------------
	device_open		device_read		device_ioctl
	device_release		device_write		device_poll
---------------------------------------------------------------------- */
static ssize_t device_write (struct file *filp,
	const char *buff,	// the user buffer to copy from
	size_t count,		// user requested nbytes
	loff_t * f_pos)		// offset in the file
{
size_t len = count;

	// wait for interrupt to make room for data and wake us up
	wrq = 1;  wait_event_interruptible(WriteQ,!wrq);

	// format of user buffer is uint[FIFO_DEPTH][2],
	// where for MPC5200, sizeof(uint) = 4, or 8 bytes per element
	if ( copy_from_user(kobuf,buff,len) )
		return -EFAULT;

return len;
}

/* ----------------------------------------------------------------------
	gpio_irq_handler: called on every gpio interrupt
---------------------------------------------------------------------- */
static void gpio_irq_handler( int irq,
	void *dev_id, struct pt_regs *regs )
{
struct mpc5xxx_gpio *pgpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;

	// check GPIO Simple Interrupt Status Register
	if (pgpio->sint_istat & GSI2) {

		// clear only GSI2 Status read-write-clear bit
		// '=' instead oft '|=' to leave other bits unchanged
		pgpio->sint_istat = GSI2;

		// GSI2 Interrupt has occured.  schedule some work
		tasklet_schedule(&gpio_tasklet);
	}
}
static void gpio_tasklet_handler( unsigned long data )
{
unsigned int	i;
unsigned int	*buf;

	// refill hardware output FIFOs, assuming they are half empty
	buf = &kobuf[0][0];
	for ( i = 0; i < FIFO_HALFDEPTH; i++ ) {
		outl(*buf++,ioaddr);		// left
		outl(*buf++,ioaddr + 8);	// right
	}

	// pulse the hardware flip-flop clear pin,
	// allows hardware to assert another irq when fifo is half empty
	hdwrctrl &= ~kHdwrIrqAck;  outl(hdwrctrl,ioaddr + 4);
	hdwrctrl |= kHdwrIrqAck;  outl(hdwrctrl,ioaddr + 4);

	// wake up user program thread
	if ( wrq ) { wrq = 0;  wake_up(&WriteQ); }

}
