Subject: Re: MATSHITADVD-ROM SR-8176
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: AMANO Kazuhiro <haa13142@jnb.odn.ne.jp>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1012763434.29823.13.camel@dozo>
References: <20020203155250172.VDPS.18601.t-mta3.odn.ne.jp@mta3.odn.ne.jp>
	<1012763434.29823.13.camel@dozo>
Content-Type: text/plain; charset=ISO-8859-1
Date: 03 Feb 2002 23:31:13 +0100
Message-Id: <1012775473.18215.19572.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Son, 2002-02-03 at 20:10, Bastien Nocera wrote:
>
> On Sun, 2002-02-03 at 15:52, AMANO Kazuhiro wrote:
> >
> > I'm in trouble with MATSHITA DVD-ROM SR-8176 drive on iBook2
> >  under kernel-2.4.18-pre7-ben0.
> >
> > First problem is in audio CD play. I'm using xmms-cdread-0.14a, but
> > I cannot get track list of CD and cannot play.
> >
> > To solve this problem, I made a tiny patch:
> > --- linux/drivers/ide/ide-cd.c-ORIG	Mon Jan 28 20:20:31 2002
> > +++ linux/drivers/ide/ide-cd.c	Sun Feb  3 22:03:42 2002
> > @@ -2644,7 +2644,8 @@
> >  	 * but they do support reading TOC & audio datas
> >  	 */
> >  	if (strcmp (drive->id->model, "MATSHITADVD-ROM SR-8187") == 0 ||
> > -	    strcmp (drive->id->model, "MATSHITADVD-ROM SR-8186") == 0)
> > +	    strcmp (drive->id->model, "MATSHITADVD-ROM SR-8186") == 0 ||
> > +	    strcmp (drive->id->model, "MATSHITADVD-ROM SR-8176") == 0)
> >  		CDROM_CONFIG_FLAGS (drive)->audio_play = 1;
> >
> >  #if ! STANDARD_ATAPI
>
> Blimey! All this time this little patch was the thing missing ?

I have an SR-8174, and audio grabbing etc. also works. Maybe we can
assume it works with any Matsushita DVD-ROM drive, or at least the
SR-81xx series?


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
