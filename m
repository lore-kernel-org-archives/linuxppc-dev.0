Message-ID: <D73A25AA6E54D511AD74009027B1110F3C035A@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Patrick Mahoney'" <pmahoney@8d.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mpc8xx - power save modes - PIT
Date: Fri, 11 Oct 2002 09:15:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In the 850 user manual I found the following to describe the SCCR[DNFH].
"Division factor high frequency. Sets the VCOOUT frequency division factor
for general system
clocks to be used in normal mode. In normal mode, the MPC850 automatically
switches to the
DFNH frequency. To select the DFNH frequency, load this Þeld with the divide
value and clear
CSRC. A loss-of-lock condition does not occur when this Þeld is changed.
This Þeld is cleared by a power-on or hard reset."

You have the following code.
imp->im_clkrst.car_plprcr |= 1<<21;		// plprcr[csrc]=1

It seems like it should be cleared, not set.




-----Original Message-----
From: Patrick Mahoney [mailto:pmahoney@8d.com]
Sent: Thursday, October 10, 2002 4:47 PM
To: Steven Blakeslee
Subject: Re: mpc8xx - power save modes - PIT


I therefore conclude that the register MSB is in the variable
LBS. Thats always goot to know! :) Thanks for the tip...

... but i still lose my console when i switch eith power mode or clock
divider. Ex:

    /* Normal high mode
     * clock divider set to 2
     * (sccr[dfnh]=110)
     */
    imp = (immap_t *)IMAP_ADDR;
    imp->im_clkrst.car_sccr &= ~(0x7<<5);
    imp->im_clkrst.car_sccr |= 0x1<<5;

Would you happen to know why?
Thanks again,


Pat Mahoney



On Thu, Oct 10, 2002 at 04:20:34PM -0400, Steven Blakeslee wrote:
> The line
> imp->im_clkrst.car_plprcr |= 1<<21;
> seems to be incorrect.  This line sets bit 10.  If you are setting
> plprcr[csrc] you would do the following
> imp->im_clkrst.car_plprcr |= 0x80;
>
> The line
> imp->im_clkrst.car_plprcr &= ~(0x3<<22);
> seems to be incorrect.  This line clears 9 and 8.  If you want to clear
> PLPRCR[LPM] you would do the following
> imp->im_clkrst.car_plprcr &= ~(0x100 | 0x200);
>
>
>
> -----Original Message-----
> From: Patrick Mahoney [mailto:pmahoney@8d.com]
> Sent: Thursday, October 10, 2002 3:40 PM
> To: Steven Blakeslee
> Subject: Re: mpc8xx - power save modes - PIT
>
>
> That was supposed to be:
>
>     /* Normal low mode
>      */
>     imp = (immap_t *)IMAP_ADDR;
>     imp->im_clkrstk.cark_plprcrk = ~KAPWR_KEY;
>     imp->im_clkrstk.cark_plprcrk = KAPWR_KEY;
>     imp->im_clkrst.car_plprcr |= 1<<21;
>     imp->im_clkrst.car_plprcr &= ~(0x3<<22);
>
> Sorry bout that.
> Thanks again,
>
>
> Pat Mahoney
>
>
> On Thu, Oct 10, 2002 at 03:33:19PM -0400, Patrick Mahoney wrote:
> > Hi Steven,
> >
> > In my module's init_module function, i do:
> >
> >     /* Normal low mode
> >      * ref: p. 14-21 of mpc850 ref book.
> >      */
> >     imp = (immap_t *)IMAP_ADDR;
> >     imp->im_clkrstk.cark_sccrk = ~KAPWR_KEY;	// unlock the
> >     imp->im_clkrstk.cark_sccrk = KAPWR_KEY;	// 	register key
> >     imp->im_clkrst.car_plprcr |= 1<<21;		// plprcr[csrc]=1
> >     imp->im_clkrst.car_plprcr &= ~(0x3<<22);	// PLPRCR[LPM]=00
> >
> > Did you succeed in toggling between power modes?
> >
> > Thanks for your support.
> > Best regards,
> >
> >
> > Pat Mahoney
> >
> > On Thu, Oct 10, 2002 at 03:19:58PM -0400, Steven Blakeslee wrote:
> > > What are you doing to put the processor into low power mode?  What
> registers
> > > are you changing?
> > >
> > >
> > > -----Original Message-----
> > > From: Patrick Mahoney [mailto:pmahoney@8d.com]
> > > Sent: Thursday, October 10, 2002 2:35 PM
> > > To: linuxppc-embedded@lists.linuxppc.org
> > > Subject: mpc8xx - power save modes - PIT
> > >
> > >
> > >
> > > Hello pple,
> > >
> > > My setup: MPC850 on a RPXlite_dw board.
> > >
> > > My problem:
> > >
> > > I am trying toggle between power saving modes and evaluate the current
> > > drops with an ampermeter.
> > >
> > > I succeeded in switching to several power modes, but each time i
> > > switch, my serial connection dies, even if i switch to the  'normal
> > > low mode', which is supposed to keep all functionnalities  present.
> > >
> > > I am looking to use the PIT to automatically bring back the chip to
> > > normal full power mode.
> > >
> > > I tried the following:
> > >
> > >       init_timer(&timer);
> > >       timer.expires=1000;
> > >       timer.function=timer_handler;
> > >       add_timer(&timer);
> > >
> > > without success. The kernel oops'es everytime. Ive been browsing the
> > > kernel sources, but have yet to see where the PIT was
> > > initialized/used.
> > >
> > > Would anyone have successfully used the several power modes of the
> > > mpc850 (or equivalent) through linux 2.4? If so, is there any code
> > > snippet available?
> > >
> > > Also, do you have any idea as to why the serial connection dies? Is it
> > > a uart syncing -type problem?
> > >
> > > Best regards,
> > >
> > >
> > > Pat Mahoney
> > >

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
