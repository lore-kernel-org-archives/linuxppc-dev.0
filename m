Date: Fri, 19 Oct 2001 10:24:14 -0700
From: Till Straumann <Till.Straumann@TU-Berlin.de>
Subject: Re: IRDA/IRCOMM on a TiBook patch (UPDATED)
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org, linux-irda@pasta.cs.uit.no
Message-id: <3BD061BE.680BEF25@TU-Berlin.de>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <3BCC104D.B5770ADE@TU-Berlin.de> <1003453347.24371.912.camel@pismo>
 <3BCFCA2C.CACD571B@TU-Berlin.de> <1003500642.4732.451.camel@pismo>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> On Fri, 2001-10-19 at 08:37, Till Straumann wrote:
> >
> > Michel Dänzer wrote:
> > >
> > > On Tue, 2001-10-16 at 12:47, Till Straumann wrote:
> > >
> > > > I (and I believe other people as well) had problems
> > > > setting up IRDA/IRCOMM on a TiBook / 2.4.12-benh and
> > > > older 2.4 series kernels [on powerpc].
> > > >
> > > > As far as I could find out there are several problems:
> > > >
> > > > 1) There seems to be a timing problem when opening
> > > >    the irda port which prevents it from being properly
> > > >    initialized.
> > > >
> > > >    When I run "irattach /dev/ttyS1 -s 1", my Nokia 8890
> > > >    is never discovered. However, when I issue a 'cat /dev/ttyS1',
> > > >    prior to starting irattach (i.e. by opening the device
> > > >    [and holding it open until irattach starts]),
> > > >    things are properly initialized
> > > >    and discovery works. Putting 'mdelay(100);' somewhere
> > > >    in macserial.c:rs_open() does the job. However, I have
> > > >    not yet figured out what exactly causes the problem.
> > > >    A user space work-around involves patching irattach.c
> > > >
> > > > 2) There is an endianness bug. A possible solution is attached.
> > >
> > > Your patch seems to be missing a bit (in qos.c IIRC) though.
> >
> > What is it missing? Please, be a little bit more verbose :-)
>
> The same thing you're doing for the other files, i.e. replace param->pv.b
> by param->pv.b.ll and param->pv.s by param->pv.s.l . The build fails for
> that file otherwise.
>

Oops - thanks for pointing this out. I had fixed it but forgotten to
keep
the original version and therefore, the patch generator  missed that
one...

> I'm talking about net/irda/qos.c BTW.
>
> > > > 3) When applying 1) and 2), IRCOMM works provided that
> > > >    /proc/sys/net/irda/max_baud_rate is clamped to 57600.
> > > >    Apparently, there is another problem in 'macserial.c' where speeds
> > > >    higher than 57600 are treated especially.
> > >
> > > Have you managed to do anything 'real' yet? I tried your patch, and it
> > > does seem to improve things, irdadump seems to show data from my Palm,
> > > but I haven't succeeded to synchronize yet.
> > >
> >
> > Sure - I can open a modem connection to my cellphone and issue any AT
> > command I want. However, I have to take care of all of the three issues
> > mentioned. (I.e. use patched irattach, use patched kernel and
> > echo 57600 > /proc/sys/net/irda/max_baud_rate).
>
> I have done the latter two and used cat to work around the first. I see
> something with irdadump but none of the pilot sync tools work. I'm
> afraid they're broken on PPC yet. :(

Hmm - I still have one of the old PalmPilot devices without irda. What
exactly
do you see with irdadump? (Forgive me the stupid question: you have set
PILOT_PORT to /dev/ircomm0, right?)

--Till

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
