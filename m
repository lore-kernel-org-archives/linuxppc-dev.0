MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: More I2C stuff
Date: Fri, 26 Oct 2001 22:55:52 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E3145935A@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I got the I2C stuff working (kind off), i.e. the drivers compile and run
without crashing.
Writing and reading seem to work, i.e. by looking with scope on the
signals everyting looks looks normal
(I have a microchip i2c memory on the i2c bus for testing).

The interrupt handler is never called, so I assume the CPM is never
raising an I2C interrupt.
The interrupt handler is installed correctly and the interrupt is
enabled (verified by looking at
the CIMR).

But the read method always fails because the bd is not filled in
properly by the CPM, i.e. BD_SC_EMPTY
is never cleared and cbd_datalen is always 0.

I could not find any mentioning of any special hardware tricks needed to
be done to get correct behaviour
of the I2C, but then again the mot.com site seem to be seriously broken
at the moment.

Also If the interrupt handler is never called, should, e.g. the read
method ever get past the
interruptable_sleep_on() call? Isn't the the interrupt handler
(cpm_iic_interrupt) the only one able to
wake the application by calling wake_up_interruptible()

Anyway,

Pussled, tired and a littlebit annoyed,

K.D.

P.S. The file refered to is drivers/i2x/i2x-algo-8xx.c.
I am using drivers/i2c/i2c-rpx.c for initialization of bd's and port.
The kernel is linuxppc_2_4_devel pulled via rsync few days ago (monday
or tuesday).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
