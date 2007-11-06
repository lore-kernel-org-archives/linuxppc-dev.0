Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 1A374DDE21
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 05:26:59 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so303424and
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Nov 2007 10:26:57 -0800 (PST)
Message-ID: <fa686aa40711061026w21fc69f2t185b807160f5c469@mail.gmail.com>
Date: Tue, 6 Nov 2007 11:26:57 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <fa686aa40711061026i64f3022eh3bb820f645b9220e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
	<20071106182953.3c1a57e3@hyperion.delvare>
	<4730A617.9040502@freescale.com>
	<20071106191039.37cd7053@hyperion.delvare>
	<fa686aa40711061026i64f3022eh3bb820f645b9220e@mail.gmail.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/6/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 11/6/07, Jean Delvare <khali@linux-fr.org> wrote:
> > Hi Scott,
> >
> > On Tue, 06 Nov 2007 11:36:23 -0600, Scott Wood wrote:
> > > Jean Delvare wrote:
> > > >>>> We might as well just use i2c_new_device() instead of messing around
> > > >>>> with bus numbers.  Note that this is technically no longer platform
> > > >>>> code, so it's harder to justify claiming the static numberspace.
> > > >>> I was allowing control of the bus number with "cell-index" and
> > > >>> i2c_add_numbered_adapter().
> > > >>> Should I get rid of this and switch to i2c_add_adapter()?
> > > >> Yes.
> > > >
> > > > No! If you don't call i2c_add_numbered_adapter() then new-style i2c
> > > > clients will never work on your i2c adapter.
> > >
> > > I thought that was what i2c_new_device() was for?
> >
> > Sorry, I've not been completely clear. Yes, you can use
> > i2c_new_device() on an adapter that has been added with
> > i2c_add_adapter(). However, this requires that you have a reference to
> > that i2c_adapter, which is usually not the case with system-wide I2C
> > buses. Embedded platforms would rather use i2c_add_numbered_adapter(),
> > give a list of chips to i2c_register_board_info() and let i2c-core
> > instantiate them. i2c_new_device was primarily meant for multimedia
> > adapters.
>
> *Some* embedded platforms would rather use i2c_add_numbered_adapter().  :-)
>
> On powerpc, and other platforms which have a device tree, we don't

Specifically; an OF style device tree.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
