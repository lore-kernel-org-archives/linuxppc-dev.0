Subject: RE:CPM  interrupts raised to early? (was  More I2C stuff,)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 29 Oct 2001 15:07:05 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E3145935E@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

After recovreing few hours of sleep during the weekend I am back to the
I2C stuff.
I was wrong that the interrupt routine was never called (in
i2c-algo-8xx.c). Somehow
cpm_debug > 1 became cpm_debug == 1 to my eyes.
Anyways after incresingddd the debug level, i.e. setting cpm_debug = 2 I
verify that the
interrupt is indead called and that everyting is working perfectly, i.e.
I am reading and
writing to the memory witout errors.
So I lower the debug level again (cpm_debug = 1) and then I am getting
the previous behavior,
i.e. I am unable to read.
So I put debug level to 0 but force a printk() inside the interrupt
handler.
And voila evrything works  perfectly.
Commenting out the printk and putting a small delay in the interrupt
handler (for(i = 0; i <1000 ; i++);)
has the same effect as keeping the printk.

This raises the question:
Is it possible that the CPM is raising the interrupt to early, i.e.
before the bd is filled?
It should not be a cache coherency problem because the bd's are all
decleared volatile.

Thanks,

K.D.

P.S. This is happening on MPC823e.

> -----Original Message-----
> From: Kári Davíðsson
> Sent: 26. október 2001 22:56
> To: Linux Embedded ppc (E-mail)
> Subject: More I2C stuff
>
>
>
> Hi,
>
> I got the I2C stuff working (kind off), i.e. the drivers
> compile and run
> without crashing.
> Writing and reading seem to work, i.e. by looking with scope on the
> signals everyting looks looks normal
> (I have a microchip i2c memory on the i2c bus for testing).
>
> The interrupt handler is never called, so I assume the CPM is never
> raising an I2C interrupt.
> The interrupt handler is installed correctly and the interrupt is
> enabled (verified by looking at
> the CIMR).
>
> But the read method always fails because the bd is not filled in
> properly by the CPM, i.e. BD_SC_EMPTY
> is never cleared and cbd_datalen is always 0.
>
> I could not find any mentioning of any special hardware
> tricks needed to
> be done to get correct behaviour
> of the I2C, but then again the mot.com site seem to be
> seriously broken
> at the moment.
>
> Also If the interrupt handler is never called, should, e.g. the read
> method ever get past the
> interruptable_sleep_on() call? Isn't the the interrupt handler
> (cpm_iic_interrupt) the only one able to
> wake the application by calling wake_up_interruptible()
>
> Anyway,
>
> Pussled, tired and a littlebit annoyed,
>
> K.D.
>
> P.S. The file refered to is drivers/i2x/i2x-algo-8xx.c.
> I am using drivers/i2c/i2c-rpx.c for initialization of bd's and port.
> The kernel is linuxppc_2_4_devel pulled via rsync few days ago (monday
> or tuesday).
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
