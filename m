Message-ID: <3EFC1345.2080108@peak.uklinux.net>
Date: Fri, 27 Jun 2003 10:49:57 +0100
From: Seb James <seb@peak.uklinux.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: i2c interrupt problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm having trouble with an interrupt which is not occurring (as far
as the core is concerned) when I think it should. My processor is an
mpc823e. I'm trying to talk to an i2c bus, and I'm using a devices
driver which I've adapted from i2c-r360.c and which uses i2c-algo-8xx.c
and i2c-core.c. I'm setting up the interrupt as in i2c-r360.c, and
I'm using multilevel interrupts, so the interrupt is set up using
request_8xxirq() like this:

static int ds1307_install_isr(int irq,
                  void (*func)(int, void *, struct pt_regs *),
                  void *data)
{
    /* install interrupt handler */
    debugk("about to request 8xxirq on irq %i.\n", irq);
    request_8xxirq(CPM_IRQ_OFFSET + irq, func, 0, "i2c-ds1307", data);

    return 0;
}

The debugk() line outputs 16 for irq, implying that irq is 0 as
CPM_IRQ_OFFSET is 16 for an mpc8xx in multilevel interrupt mode. Now,
this function is called with setisr, as defined like this:

static struct i2c_algo_8xx_data ds1307_data = {
    setisr: ds1307_install_isr
};

As before, this is done the same way as in i2c-r360 and irq defaults to
0. Can anyone explain why irq is not set explicitly and how this works
with multilevel interrupts? Can anyone think of a possible reason why my
interrupt wouldn't be getting registered? I understand that the CPM can
have multiple interrupts coming in, all of which get mapped to a single
interrupt to the core. How is the vector of the interrupt into the CPM
handled, or rather how do you tell what kind of int you've had if you
get an interrupt to the core from the CPM?

Should irq in the code above be set to something specific for i2c?

Thanks for reading,

best regards,

Seb James.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
