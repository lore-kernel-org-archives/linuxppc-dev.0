Date: Wed, 12 Nov 2003 09:00:48 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: common config fails to open /dev/console
Message-ID: <20031112080048.GA6165@suse.de>
References: <20031111211016.GA9623@suse.de> <1068602414.13217.25.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1068602414.13217.25.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Wed, Nov 12, Benjamin Herrenschmidt wrote:

> On Wed, 2003-11-12 at 08:10, Olaf Hering wrote:
> > I got this oops with the attached config. it dies in init_dev() because
> > driver->ttys contains NULL.
> >
> > sys_open -> filp_open -> dentry_open -> chrdev_open -> tty_open -> init_dev
> >
> > maybe pmac_zilog doesnt play well together with the 8250, or it doesnt
> > initalize everything correctly.
>
> Sure, pmac_zilog doesn't play well with 8250, but shouldn't cause such
> a crash. What machine is it btw ? Can you send me a fix for pmac_feature
> not detecting the model properly ?

I think the bug is that the detection is still in progress, see
http://bugme.osdl.org/show_bug.cgi?id=1529

Its a 7200/90. 'compatible' contains
AAPL,7300
MacRISC

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
