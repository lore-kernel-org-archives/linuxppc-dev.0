Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 786A12C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 10:53:02 +1000 (EST)
Message-ID: <1377564760.3819.91.camel@pasglop>
Subject: Re: [PATCH] powerpc/hvsi: increase handshake timeout from 200ms to
 400ms.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
Date: Tue, 27 Aug 2013 10:52:40 +1000
In-Reply-To: <1377543212-20432-1-git-send-email-ebs@ebshome.net>
References: <1377543212-20432-1-git-send-email-ebs@ebshome.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-26 at 11:53 -0700, Eugene Surovegin wrote:
> This solves a problem observed in kexec'ed kernel where 200ms timeout is
> too short and bootconsole fails to initialize. Console did eventually
> become workable but much later into the boot process.
> 
> Observed timeout was around 260ms, but I decided to make it a little bigger
> for more reliability.
> 
> This has been tested on Power7 machine with Petitboot as a primary
> bootloader and PowerNV firmware.

Thanks !

I've been carrying a patch like that in my test stuff, the only reason I
hadn't merged it yet was that I though there might be a problem under
the hood, such as us maybe not actually polling the FSP fast enough or
something, but so far it looks like it's just slow to respond.

Cheers,
Ben.

> Signed-off-by: Eugene Surovegin <surovegin@google.com>
> ---
>  drivers/tty/hvc/hvsi_lib.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvsi_lib.c b/drivers/tty/hvc/hvsi_lib.c
> index 3396eb9..ac27671 100644
> --- a/drivers/tty/hvc/hvsi_lib.c
> +++ b/drivers/tty/hvc/hvsi_lib.c
> @@ -341,8 +341,8 @@ void hvsilib_establish(struct hvsi_priv *pv)
>  
>  	pr_devel("HVSI@%x:   ... waiting handshake\n", pv->termno);
>  
> -	/* Try for up to 200s */
> -	for (timeout = 0; timeout < 20; timeout++) {
> +	/* Try for up to 400ms */
> +	for (timeout = 0; timeout < 40; timeout++) {
>  		if (pv->established)
>  			goto established;
>  		if (!hvsi_get_packet(pv))
