Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 2C714DDEBA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 19:13:44 +1100 (EST)
Date: Thu, 8 Feb 2007 09:13:36 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH 0/10] ps3av/fb drivers for 2.6.21
In-Reply-To: <1170882427.2620.293.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0702080910570.6049@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702051624410.18405@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702061559420.14230@pademelon.sonytel.be>
	<1170794953.2620.253.camel@localhost.localdomain>
	<Pine.LNX.4.62.0702070859050.31772@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702071743040.29060@pademelon.sonytel.be>
	<1170882427.2620.293.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 8 Feb 2007, Benjamin Herrenschmidt wrote:
> On Wed, 2007-02-07 at 17:51 +0100, Geert Uytterhoeven wrote:
> > On Wed, 7 Feb 2007, Geert Uytterhoeven wrote:
> > > On Wed, 7 Feb 2007, Benjamin Herrenschmidt wrote:
> > > > > ps3av: Use a kernel thread to handle the actual video mode setting, as this
> > > > > involves some quite big delays.
> > > > 
> > > > The ps3 fbdev already has it's own kernel thread no ? Why use a second
> > > > one ? We could just have the ps3av code keep the delays but be called by
> > > > a thread ?
> > > 
> > > That's another possibility.  And since the screen is blanked during mode
> > > change, there's no need to refresh it, and I may even get rid of the call to
> > > ps3fb_flip_ctl() in ps3av.
> > > 
> > > I'll look into it...
> > 
> > Below's a new patch (take 3).
> > 
> > But it doesn't work well: after each mode change, the old contents of the
> > screen are visible for a (noticable) fraction of a second.
> > Ps3fbd doesn't refresh the screen contents until ps3av_set_video_mode()
> > returns, which is longer than my display needs to sync to the new video mode
> > (this was actually the reason behind the msleep() calls).
> > 
> > I also could not get rid of the calls to ps3fb_flip_ctl() in ps3av, as screen
> > updates have to be disabled while sending other AV packets, too.
> > 
> > So I prefer the previous solution, using a new ps3av kernel thread.
> > Unless anyone has a better solution, of course :-)
> 
> Moving the flip to ps3av ? :-)

Using the same kthread as used for mode setting? Besides moving half of ps3fb
to ps3av, that will give the same problems.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
