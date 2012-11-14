Return-Path: <jirislaby@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CEC9C2C009A
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2012 20:45:48 +1100 (EST)
Received: by mail-ee0-f42.google.com with SMTP id t10so125796eei.15
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2012 01:45:43 -0800 (PST)
Sender: Jiri Slaby <jirislaby@gmail.com>
Message-ID: <50A36844.7080207@suse.cz>
Date: Wed, 14 Nov 2012 10:45:40 +0100
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] TTY: hvc_console, fix port reference count going to zero
 prematurely
References: <20121114081547.GA573@bloggs.ozlabs.ibm.com>
In-Reply-To: <20121114081547.GA573@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alan@linux.intel.com, anton@samba.org,
 gregkh@linuxfoundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/14/2012 09:15 AM, Paul Mackerras wrote:
> Commit bdb498c20040 "TTY: hvc_console, add tty install" took the port
> refcounting out of hvc_open()/hvc_close(), but failed to remove the
> kref_put() and tty_kref_put() calls in hvc_hangup() that were there to
> remove the extra references that hvc_open() had taken.
> 
> The result was that doing a vhangup() when the current terminal was
> a hvc_console, then closing the current terminal, would end up calling
> destroy_hvc_struct() and making the port disappear entirely.  This
> meant that Fedora 17 systems would boot up but then not display the
> login prompt on the console, and attempts to open /dev/hvc0 would
> give a "No such device" error.
> 
> This fixes it by removing the extra kref_put() and tty_kref_put() calls.

Oh yeah. Thanks.

Acked-by: Jiri Slaby <jslaby@suse.cz>

> Signed-off-by: Paul Mackerras <paulus@samba.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/tty/hvc/hvc_console.c |    7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index a5dec1c..13ee53b 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -424,7 +424,6 @@ static void hvc_hangup(struct tty_struct *tty)
>  {
>  	struct hvc_struct *hp = tty->driver_data;
>  	unsigned long flags;
> -	int temp_open_count;
>  
>  	if (!hp)
>  		return;
> @@ -444,7 +443,6 @@ static void hvc_hangup(struct tty_struct *tty)
>  		return;
>  	}
>  
> -	temp_open_count = hp->port.count;
>  	hp->port.count = 0;
>  	spin_unlock_irqrestore(&hp->port.lock, flags);
>  	tty_port_tty_set(&hp->port, NULL);
> @@ -453,11 +451,6 @@ static void hvc_hangup(struct tty_struct *tty)
>  
>  	if (hp->ops->notifier_hangup)
>  		hp->ops->notifier_hangup(hp, hp->data);
> -
> -	while(temp_open_count) {
> -		--temp_open_count;
> -		tty_port_put(&hp->port);
> -	}
>  }
>  
>  /*
> 


-- 
js
suse labs
