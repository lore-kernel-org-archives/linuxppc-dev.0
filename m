Message-ID: <3CE1A20E.1020708@pacbell.net>
Date: Tue, 14 May 2002 16:47:26 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: John Tyner <jtyner@cs.ucr.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] fix ibm ocp ifconfig oops (for real this time)
References: <Pine.LNX.4.30.0205141628280.29257-101000@hill.cs.ucr.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Tyner wrote:
> Here is a shorter patch that actually works. Please disregard my last one.
>
> --- drivers/net/ibm_ocp/ibm_ocp_enet.c	Tue May 14 16:24:17 2002
> +++ drivers/net/ibm_ocp/ibm_ocp_enet.c	Tue May 14 16:25:58 2002
> @@ -244,14 +244,11 @@
>  		fep = (struct fec_enet_private *) EMAC_DEV(ocpdev);
>  		emacp = (emac_t *) EMAC_DEV(paddr);
>  	} else {
> -		if ((emac_driver =
> -		     ocp_alloc_dev(sizeof (struct fec_enet_private))) == NULL)
> -			return -ENOMEM;
> +		emac_driver = ( struct ocp_driver *)dev->priv;
>  		strcpy(emac_driver->name, "emac");
>  		emac_driver->type = EMAC;
>  		/* this returns the next emac number */
>  		if ((emac_num = ocp_register(emac_driver)) >= 0) {
> -			dev->priv = (void *) emac_driver;
>  			emac_driver->priv_index = dev->ifindex;
>  			emacp =
>  			    (emac_t *) ((struct ocp_driver *) dev->priv)->paddr;
> @@ -676,6 +673,10 @@
>  		dev->set_multicast_list = &ppc405_enet_set_multicast_list;
>  		dev->do_ioctl = &fec_enet_ioctl;
>  		emac_dev[curr_emac] = dev;
> +
> +		if ((dev->priv =
> +		     ocp_alloc_dev(sizeof (struct fec_enet_private))) == NULL)
> +			return -ENOMEM;
>  	}
>
>  	for (i = 0; i < NMII - 1; i++)
>

Thanks,

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
