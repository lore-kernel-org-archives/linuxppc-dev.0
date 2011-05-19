Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 433EDB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 03:24:36 +1000 (EST)
Date: Thu, 19 May 2011 18:25:51 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 6/7] tty/powerpc: introduce the ePAPR embedded
	hypervisor byte channel driver
Message-ID: <20110519182551.0c06cd10@lxorguk.ukuu.org.uk>
In-Reply-To: <4DD545E4.9090408@freescale.com>
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
	<1305813272-31826-7-git-send-email-timur@freescale.com>
	<20110519153358.5876f310@lxorguk.ukuu.org.uk>
	<4DD545E4.9090408@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 May 2011 11:31:32 -0500
Timur Tabi <timur@freescale.com> wrote:

> Alan Cox wrote:
> > You really also need a hangup method so vhangup() does the right thing
> > and you can securely do logins etc and sessions on your console. As
> > you've got no hardware entangled in this and you already use tty_port
> > helpers the hangup helper will do the work for you.
> 
> So all I need is this?
> 
> static void ehv_bc_tty_hangup(struct tty_struct *ttys)
> {
> 	struct ehv_bc_data *bc = ttys->driver_data;
> 
> 	tty_port_hangup(&bc->port);
> }
> 
> I've noticed that some drivers flush their transmit buffers before calling
> tty_port_hangup(), but some others don't.  Should I do this too?  I don't know
> if hangup should be as quick as possible.

Doesn't matter too much. If you can flush it quickly then do so
