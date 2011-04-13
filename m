Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 47FDFB6FCE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 22:27:59 +1000 (EST)
Date: Wed, 13 Apr 2011 14:27:51 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Revert 737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?
Message-ID: <20110413122751.GA21050@iram.es>
References: <20110406204327.GA11148@iram.es>
	<1302185075.24704.143.camel@thor.local>
	<20110411133128.GA24344@iram.es>
	<1302535963.24704.268.camel@thor.local>
	<20110412113033.GA16649@iram.es>
	<1302608770.27054.36.camel@thor.local>
	<20110412120055.GA7995@iram.es>
	<1302629362.15520.25.camel@thor.local>
	<20110413075943.GA27996@iram.es>
	<1302696736.15520.63.camel@thor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1302696736.15520.63.camel@thor.local>
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Dave Airlie <airlied@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2011 at 02:12:16PM +0200, Michel Dänzer wrote:
> On Mit, 2011-04-13 at 09:59 +0200, Gabriel Paubert wrote: 
> > On Tue, Apr 12, 2011 at 07:29:22PM +0200, Michel Dänzer wrote:
> > > On Die, 2011-04-12 at 14:00 +0200, Gabriel Paubert wrote:
> > > > On Tue, Apr 12, 2011 at 01:46:10PM +0200, Michel Dänzer wrote:
> > > > > > 
> > > > > > With no_wb=1 the driver goes a bit further but the X server ends
> > > > > > up in an infinite ioctl loop and the logs are: 
> > > > > 
> > > > > Which ioctl does it loop on? Please provide the Xorg.0.log file as well.
> > > > 
> > > > From memory, the code was 0x64, which is DRM_RADEON_GEM_WAIT_IDLE.
> > > 
> > > Note that it's normal for this ioctl to be called every time before the
> > > GPU accessible pixmap memory is accessed by the CPU. Unless the ioctl
> > > always returns an error, this may not indicate a problem on its own. 
> > 
> > It seems to be an infinite loop, always returning EINTR because
> > of regular SIGALRM delivery.
> 
> That does sound like the GPU locks up. Do you get any messages in dmesg
> about lockups and attempts to reset the GPU at any time?

No.

	Gabriel
