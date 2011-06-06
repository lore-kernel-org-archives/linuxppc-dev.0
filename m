Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 3EE8BB6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jun 2011 02:04:05 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>,
 Deepak Saxena <dsaxena@linaro.org>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Date: Mon, 6 Jun 2011 18:03:58 +0200
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106061742.01974.arnd@arndb.de> <4DECF6B3.5020700@freescale.com>
In-Reply-To: <4DECF6B3.5020700@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106061803.58531.arnd@arndb.de>
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

On Monday 06 June 2011, Timur Tabi wrote:
> Arnd Bergmann wrote:
> > Sorry, I misread your first sentence above. I thought you said that you prefer
> > drivers/firmware over virt/fsl. drivers/misc is definitely the wrong
> > place for this, please choose a better one. Maybe drivers/virt/ ?
> 
> I'll be more than happy to go with the consensus, but I don't think it makes
> sense to create a new directory just for this one, limited-use driver.  You're
> the only person who's complained about drivers/misc.  I'm pretty sure that if I
> put it in drivers/virt, I'll get more complaints.
> 
> I still don't understand what's wrong with drivers/misc, especially since my
> driver registers as a "misc" driver.

I basically think that drivers/misc is wrong for most of the stuff that is
already in there, either because the drivers actually fit into a subsystem
together with other drivers or because they contain rather horrible code.

The idea that drivers using misc_register belong into drivers/misc is a
common misconception. Traditionally they go to drivers/char, which would
still be a better choice, and most "misc" drivers are actually part of a
proper subsystem, while most drivers in drivers/misc don't have a character
device interface.

When we talked about the situation of drivers/misc and drivers/char at
one of the recent conferences, a broad consensus was that they are in
need of a maintainer, which I foolishly signed up for. Deepak wanted
to send an update to the MAINTAINERS file for this (I guess I can do
that too, since he must have forgotten about it), but the main idea is
that I'm there to say no to any driver that someone tries to add there,
unless there are really good reasons why it is actually a good place
to live for that driver.

	Arnd
