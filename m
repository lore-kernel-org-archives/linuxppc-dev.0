Message-ID: <3AF29648.575843F4@iiic.ethz.ch>
Date: Fri, 04 May 2001 13:45:12 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Daniel Berlin <dan@cgsoftware.com>
Cc: Uwe Steinmann <steinm@majestix.fernuni-hagen.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: IRDA support
References: <20010503102914.A4411@gehtnix.fernuni-hagen.de> <8766fianez.fsf@dynamic-addr-83-177.resnet.rochester.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Berlin wrote:
>
> Uwe Steinmann <steinm@majestix.fernuni-hagen.de> writes:
>
> > short question. Do any of the recent kernels support IRDA on a
> > Pismo?
> Nope.
>
> > If no, what needs to be done to make it work?
>
> Get it to actually turn it on properly, i would imagine.
> it times out trying to send the setup bytes, or something like this.

Yep, here's what I get running irattach when I replace the 'goto out' by break
in irda_setup():

PowerMac Z8530 serial driver version 2.0
tty00 at 0xc9a1c020 (irq = 22) is a Z8530 ESCC (cobalt modem)
tty01 at 0xc9a23000 (irq = 23) is a Z8530 ESCC (IrDA)
irda_setup timed out on 1st byte
irda_setup 1st byte = ff
irda_setup timed out on 2nd byte
irda_setup 2nd byte = ff (4f)
irda_setup timed out on 1st byte
irda_setup 1st byte = ff
irda_setup timed out on 2nd byte
irda_setup 2nd byte = ff (51)


Hope this is meaningful to the people familiar with that code...

I saw comments in macserial.c that it should work on older G3 PowerBooks, can
anyone confirm that? What about iMacs?


I'd really love to get this working for HotSync...


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
