Subject: Re: 2.4.x swim3 performance problem on PM4400 identified
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <16004.27866.270601.561756@gargle.gargle.HOWL>
References: <16004.27866.270601.561756@gargle.gargle.HOWL>
Content-Type: text/plain
Message-Id: <1048866579.12125.15.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 28 Mar 2003 16:49:39 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-03-28 at 16:40, Mikael Pettersson wrote:
> With 2.4 kernels, writes to floppy are about a factor of 10 slower
> on my PowerMac 4400 than they are with 2.2 kernels.
>
> The cause for this is a poll-loop in swim3.c which doesn't exist
> in the 2.2 version. The patch below reverts that change, and
> restores floppy write performance to 2.2 levels. I've built many
> boot floppies with this modified driver w/o any problems.

That's interesting. I'll look into more details and post
a patch for my next -ben kernel release. Thanks for taking
the time to investigate.

> --- linux-2.4.21-pre6/drivers/block/swim3.c.~1~	Wed Aug  7 00:52:20 2002
> +++ linux-2.4.21-pre6/drivers/block/swim3.c	Fri Mar 28 16:02:17 2003
> @@ -679,10 +679,14 @@
>  			break;
>  		dr = fs->dma;
>  		cp = fs->dma_cmd;
> +#if 0	/* This causes massive performance problems for my PM4400. /Mikael */
>  		/* We must wait a bit for dbdma to complete */
>  		for (n=0; (in_le32(&dr->status) & ACTIVE) && n < 1000; n++)
>  			udelay(10);
>  		DBDMA_DO_STOP(dr);
> +#else	/* This is from 2.2 and it works much better for my PM4400. /Mikael */
> +		st_le32(&dr->control, RUN << 16);
> +#endif
>  		out_8(&sw->intr_enable, 0);
>  		out_8(&sw->control_bic, WRITE_SECTORS | DO_ACTION);
>  		out_8(&sw->select, RELAX);
>
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
