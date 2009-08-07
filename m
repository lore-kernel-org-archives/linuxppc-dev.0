Return-Path: <dk@uw.no>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DD03FB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 16:45:24 +1000 (EST)
Received: from in.cluded.net (in.cluded.net [195.159.98.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ja.vu", Issuer "mail.ja.vu" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A9AABDDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 16:45:23 +1000 (EST)
Message-ID: <4A7BCAF1.5070605@uw.no>
Date: Fri, 07 Aug 2009 06:34:25 +0000
From: "Daniel K." <dk@uw.no>
MIME-Version: 1.0
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 1/3] arch/powerpc: Add kmalloc NULL tests
References: <Pine.LNX.4.64.0908062203380.19100@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.0908062203380.19100@ask.diku.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kernel-janitors@vger.kernel.org, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Julia Lawall wrote:
> --- a/arch/powerpc/sysdev/fsl_rio.c
> +++ b/arch/powerpc/sysdev/fsl_rio.c
> @@ -1057,6 +1057,10 @@ int fsl_rio_setup(struct of_device *dev)
>  			law_start, law_size);
>  
>  	ops = kmalloc(sizeof(struct rio_ops), GFP_KERNEL);
> +	if (!ops) {
> +		rc = -ENOMEM;
> +		goto err_ops;
> +	}
>  	ops->lcread = fsl_local_config_read;
>  	ops->lcwrite = fsl_local_config_write;
>  	ops->cread = fsl_rio_config_read;
> @@ -1064,6 +1068,10 @@ int fsl_rio_setup(struct of_device *dev)
>  	ops->dsend = fsl_rio_doorbell_send;
>  
>  	port = kzalloc(sizeof(struct rio_mport), GFP_KERNEL);
> +	if (!port) {
> +		rc = -ENOMEM;
> +		goto err_port;
> +	}
>  	port->id = 0;
>  	port->index = 0;
>  
> @@ -1071,7 +1079,7 @@ int fsl_rio_setup(struct of_device *dev)
>  	if (!priv) {
>  		printk(KERN_ERR "Can't alloc memory for 'priv'\n");
>  		rc = -ENOMEM;
> -		goto err;
> +		goto err_priv;
>  	}
>  
>  	INIT_LIST_HEAD(&port->dbells);
> @@ -1169,13 +1177,15 @@ int fsl_rio_setup(struct of_device *dev)
>  
>  	return 0;
>  err:
> -	if (priv)
> -		iounmap(priv->regs_win);
> -	kfree(ops);
> +	iounmap(priv->regs_win);
> +err_priv:
>  	kfree(priv);
> +err_port:
>  	kfree(port);
> +err_ops:
> +	kfree(ops);
>  	return rc;

There seems to be a goto-off-by-one error here.

If xxxx = kxalloc() fails, you goto err_xxxx, and do a kfree(xxxx) where xxxx is
already proven to be NULL.

Is there a reason for this that eludes me?


I'd expect that last hunk to look something like

@@ -1169,13 +1177,15 @@ int fsl_rio_setup(struct of_device *dev)
 
 	return 0;
 err:
-	if (priv)
-		iounmap(priv->regs_win);
-	kfree(ops);
+	iounmap(priv->regs_win);
 	kfree(priv);
+err_priv:
 	kfree(port);
+err_port:
+	kfree(ops);
+err_ops:
 	return rc;
 }


Daniel K.
