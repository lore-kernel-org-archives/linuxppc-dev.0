Return-Path: <dmitry.torokhov@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.200])
	by ozlabs.org (Postfix) with ESMTP id 92F4967A7E
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jan 2005 02:22:23 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id a41so829915rng
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 07:22:19 -0800 (PST)
Message-ID: <d120d500050128072268a5c2f0@mail.gmail.com>
Date: Fri, 28 Jan 2005 10:22:18 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20050128145511.GA29340@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de>
	<d120d50005012806435a17fe98@mail.gmail.com>
	<20050128145511.GA29340@suse.de>
Cc: linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Reply-To: dtor_core@ameritech.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 28 Jan 2005 15:55:11 +0100, Olaf Hering <olh@suse.de> wrote:
> On Fri, Jan 28, Dmitry Torokhov wrote:
> 
> > On Fri, 28 Jan 2005 14:58:27 +0100, Olaf Hering <olh@suse.de> wrote:
> > > On Fri, Jan 28, Olaf Hering wrote:
> > >
> > > >
> > > > My IBM RS/6000 B50 locks up with 2.6.11rc1, it dies in atkbd_init():
> > >
> > > It fails also on PReP, not only on CHRP. 2.6.10 looks like this:
> > >
> > > Calling initcall 0xc03bc430: atkbd_init+0x0/0x2c()
> > > atkbd.c: keyboard reset failed on isa0060/serio1
> > > atkbd.c: keyboard reset failed on isa0060/serio0
> > >
> >
> > So it could not reset it even before, but it was not getting stuch
> > tough... What about passing atkbd.reset=0?
> 
> I will try that.
> Adding a printk after the outb() fixes it as well.

Fixes as in "it reports that reset fails" again or it resets the
keyboard cleanly and works fine?

> Do you have a version of that i8042 delay patch for 2.6.11-rc2-bk6?
> Maybe it will help.
> 

No I don't, and I don't think you need all of it. What happens if you
edit drivers/input/serio/i8042.c manually and stick udelay(7); in
front of calls to i8042_write_data() in i8042_kbd_write() and
i8042_aux_write()?

-- 
Dmitry
