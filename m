Date: Mon, 26 Aug 2002 11:18:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ocp emac phy wierdness
Message-ID: <20020826011814.GL18818@zax>
References: <20020823071911.GF18818@zax> <3D6528CF.90401@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D6528CF.90401@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 22, 2002 at 11:09:19AM -0700, Armin Kuster wrote:
>
> David,
>
> The whole phy idea back when I did it was modeled after the fec.c driver
> with the thought that at some point we could merge all phy_info structs
> into a common file.  The same idea was applied to the mii routines.  I
> noticed that code/information is duplicated in a few ethernet drivers in
> ppc.  Some of the what you see will be used when we add link support
> driver, some of the 4xx boards with zmii bridges have interrupt
> capability.  The phy implementation is a project that is not completed. :)

By all means share the phy_info structures between ethernet drivers.
That doesn't explain why:
	a) We queue the various phy operations, then process the
queue, rather than just stepping through the commands as soon as
requested.
	b) Why the queue is processed with schedule_task(), rather
than directly inline.

> David Gibson wrote:
>
> >There seems to be a whole lot of stuff related to phy handling with no
> >clear purpose to it.  The table phy_cmd_config appears to be unused,
> >as are the functions mii_queue_config, mii_display_config.
> >
> >Furthermore process_mii_queue() is dispatched through schedule_task(),
> >from mii_queue_schedule().  But the only place that is called is in
> >ppc405_enet_open(), which immediately calls schedule() to wait for the
> >job to be completed.  So what the hell is the point of the
> >schedule_task() rigmarole?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
