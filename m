Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AAA872C007E
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2012 23:48:11 +1100 (EST)
Message-ID: <1352897279.23412.22.camel@pasglop>
Subject: Re: [PATCH] TTY: hvc_console, fix port reference count going to
 zero prematurely
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jiri Slaby <jslaby@suse.cz>
Date: Wed, 14 Nov 2012 23:47:59 +1100
In-Reply-To: <50A36844.7080207@suse.cz>
References: <20121114081547.GA573@bloggs.ozlabs.ibm.com>
 <50A36844.7080207@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, gregkh@linuxfoundation.org,
 Paul Mackerras <paulus@samba.org>, anton@samba.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-11-14 at 10:45 +0100, Jiri Slaby wrote:

> > This fixes it by removing the extra kref_put() and tty_kref_put() calls.
> 
> Oh yeah. Thanks.
> 
> Acked-by: Jiri Slaby <jslaby@suse.cz>

So who's merging it ?

Cheers,
Ben.

> > Signed-off-by: Paul Mackerras <paulus@samba.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/tty/hvc/hvc_console.c |    7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> > index a5dec1c..13ee53b 100644
> > --- a/drivers/tty/hvc/hvc_console.c
> > +++ b/drivers/tty/hvc/hvc_console.c
> > @@ -424,7 +424,6 @@ static void hvc_hangup(struct tty_struct *tty)
> >  {
> >  	struct hvc_struct *hp = tty->driver_data;
> >  	unsigned long flags;
> > -	int temp_open_count;
> >  
> >  	if (!hp)
> >  		return;
> > @@ -444,7 +443,6 @@ static void hvc_hangup(struct tty_struct *tty)
> >  		return;
> >  	}
> >  
> > -	temp_open_count = hp->port.count;
> >  	hp->port.count = 0;
> >  	spin_unlock_irqrestore(&hp->port.lock, flags);
> >  	tty_port_tty_set(&hp->port, NULL);
> > @@ -453,11 +451,6 @@ static void hvc_hangup(struct tty_struct *tty)
> >  
> >  	if (hp->ops->notifier_hangup)
> >  		hp->ops->notifier_hangup(hp, hp->data);
> > -
> > -	while(temp_open_count) {
> > -		--temp_open_count;
> > -		tty_port_put(&hp->port);
> > -	}
> >  }
> >  
> >  /*
> > 
> 
> 
