Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 66F8067BAF
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 22:23:10 +1000 (EST)
Date: Mon, 21 Aug 2006 14:17:08 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: booting with BootX corrupts memory
Message-ID: <20060821121708.GA28713@aepfle.de>
References: <1155096025.3813.6.camel@plutonium.opasia.dk>
	<1155873732.5803.16.camel@localhost.localdomain>
	<20060818070113.GA28088@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060818070113.GA28088@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, Niels Kristian Bech Jensen <nkbj@mail.tele.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2006 at 09:01:13AM +0200, Olaf Hering wrote:

> On Fri, Aug 18, 2006 at 02:02:12PM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2006-08-09 at 06:00 +0200, Niels Kristian Bech Jensen wrote:
> > >  On Tue, Aug  1, Olaf Hering wrote:
> > > 
> > > > Booting an old Mac with BootX corrupts memory, the kernel seldom gets
> > > > into init. Even the built-in initramfs archive gets corrupted. So far I
> > > > havent figured out where the corruption starts. The only data point so
> > > > far is that a passed initrd gets overwritten with stuff that looks like
> > > > part of the device-tree after the call to free_area_init_node() from
> > > > paging_init(). Perhaps the virtual/real address mapping isnt handled
> > > > correctly.
> > > 
> > > > This is broken since at least 2.6.15, 2.6.14 dies very early, 2.6.13 was
> > > > still ok.
> > > 
> > > > Symptoms differ, depending on used .config and wether an initrd is passed.
> > > 
> > > I think I've been hit by this bug on my beige G3 running Ubuntu Edgy.
> > > 
> > > When booting with initrd the boot process stops before any kernel output (CONFIG_BOOTX_TEXT is not enabled).
> > > Booting without initrd works fine - at least until it cannot find the root filesystem driver. ;-)
> > 
> > Does this patch helps ?
> 
> No, now I dont even get console= output on serial console.

It doesnt work on a 7200, butit works on a beige G3.
But later it locks up in 'PM: Adding info for No Bus:target0:0',
after mesh init. This one is likely unrelated.
