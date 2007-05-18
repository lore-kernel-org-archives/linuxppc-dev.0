Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2ABBDDDF54
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 10:45:55 +1000 (EST)
Message-ID: <464CF73D.9050505@garzik.org>
Date: Thu, 17 May 2007 20:45:49 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] gianfar: Add I/O barriers when touching buffer descriptor
	ownership.
References: <20070516200659.GA23548@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070516200659.GA23548@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> The hardware must not see that is given ownership of a buffer until it is
> completely written, and when the driver receives ownership of a buffer,
> it must ensure that any other reads to the buffer reflect its final
> state.  Thus, I/O barriers are added where required.
> 
> Without this patch, I have observed GCC reordering the setting of
> bdp->length and bdp->status in gfar_new_skb.  Hardware reordering
> was also theoretically possible.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> I've added the requested comments to the source code about
> the use of eieio().  Jeff, please consider for 2.6.22, as it
> fixes a bug that has been observed.
> 
>  drivers/net/gianfar.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)

applied
