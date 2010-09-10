Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id B03CBB70D4
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Sep 2010 04:28:19 +1000 (EST)
Received: by pwj9 with SMTP id 9so1610827pwj.15
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 11:28:18 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 10 Sep 2010 12:28:15 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: =?iso-8859-1?Q?Andr=E9?= Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: How to define an I2C-to-SPI bridge device ?
Message-ID: <20100910182815.GH11284@angua.secretlab.ca>
References: <1283502979.17812.22.camel@swa-m460>
	<20100903120858.GA19380@oksana.dev.rtsoft.ru>
	<4C84D334.6060008@matrix-vision.de>
	<c843f864-2a5a-4146-bd95-13c2fb91f430@email.android.com>
	<1284106293.2267.42.camel@swa-m460>
	<20100910173706.GD11284@angua.secretlab.ca>
	<1284142484.2152.18.camel@swa-e6500>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1284142484.2152.18.camel@swa-e6500>
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>,
	DevTreeDiscuss <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 10, 2010 at 08:14:44PM +0200, André Schwarz wrote:
> > > At first I thought about registering 4 SPI busses representing the 4 cs#
> > > lines and hide the cs# generation from the user. This would make
> > > multiple cs# assertions for a single write impossible which is a very
> > > useful feature.
> > 
> > The SPI subsystem doesn't directly support this use-case.  If you want
> > to do this, then assign another chip select number for the purpose of
> > enabling multiple CS lines at once... and be careful which drivers you
> > allow to be bound to the oddball CS number.  The in-kernel drivers
> > certainly don't support this use-case, and care must be taken to
> > ensure only one device is writing to the input line at a time.
> > 
> > What specific hardware do you need this feature for?
> 
> We have a board with multiple parallel video transmitters connected to
> an FPGA. Video timing and general parameters are always the same and
> there are quite a lot of settings to write during init/mode change.
> 
> Doing this in parallel will speed things up significantly.

Yeah; Then I would handle it as a separate cs# and map it to enabling
multiple CS lines at a time.

> BTW: would "drivers/misc" be a proper location ?
> Who's supposed to pick that driver up and on what list shall I post it
> for review ?

You should cc spi-devel-general, and feel free to cc me.  drivers/misc
would probably be an okay place for it to live; but if it only appears
on a single machine, then it may make more sense in
arch/*/<board-directory>.  What arch or SoC is this running on?

g.
