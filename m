Date: Tue, 14 May 2002 07:57:45 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Firewire Disk Broken in 2.4.19-pre8-ben0 kernel (was working fine with 2.4.18-ben0)
To: billfink@mindspring.com
Cc: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020514004017.2a66ccf2.billfink@mindspring.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E177VJp-00007m-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Shot in the dark....

On  14 May, this message from Bill Fink echoed through cyberspace:
> diff -u ieee1394-022602/hosts.c ieee1394-022702/hosts.c
> --- ieee1394-022602/hosts.c	Sat Feb  9 00:41:40 2002
> +++ ieee1394-022702/hosts.c	Tue Feb 26 15:06:39 2002
> @@ -78,26 +97,39 @@
>          spin_unlock_irqrestore(&hosts_lock, flags);
>  }
>
> +/**
> + * hpsb_alloc_host - allocate a new host controller.
> + * @drv: the driver that will manage the host controller
> + * @extra: number of extra bytes to allocate for the driver
> + *
> + * Allocate a &hpsb_host and initialize the general subsystem specific
> + * fields.  If the driver needs to store per host data, as drivers
> + * usually do, the amount of memory required can be specified by the
> + * @extra parameter.  Once allocated, the driver should initialize the
> + * driver specific parts, enable the controller and make it available
> + * to the general subsystem using hpsb_add_host().
> + *
> + * The &hpsb_host is allocated with an single initial reference
> + * belonging to the driver.  Once the driver is done with the struct,
> + * for example, when the driver is unloaded, it should release this
> + * reference using hpsb_unref_host().
> + *
> + * Return Value: a pointer to the &hpsb_host if succesful, %NULL if
> + * no memory was available.
> + */
> +
>  struct hpsb_host *hpsb_alloc_host(struct hpsb_host_driver *drv, size_t extra)
>  {
>          struct hpsb_host *h;
>
> -        h = kmalloc(sizeof(struct hpsb_host), SLAB_KERNEL);
> +        h = kmalloc(sizeof(struct hpsb_host) + extra, SLAB_KERNEL);
>          if (!h) return NULL;
>          memset(h, 0, sizeof(struct hpsb_host));
                        ^^^^^^^^^^^^^^^^^^^^^^^^
This should probably be sizeof(struct hpsb_host) + extra.

>
> -	/* Drivers usually use this to allocate their private data */
> -	if (extra) {
> -		h->hostdata = kmalloc(extra, SLAB_KERNEL);
> -		if (!h->hostdata) {
> -			kfree(h);
> -			return NULL;
> -		}
> -		memset(h->hostdata, 0, extra);
> -	}
> -
> +	h->hostdata = h + 1;
>          h->driver = drv;
>          h->ops = drv->ops;
> +	h->refcount = 1;
>
>          INIT_LIST_HEAD(&h->pending_packets);
>          spin_lock_init(&h->pending_pkt_lock);

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
