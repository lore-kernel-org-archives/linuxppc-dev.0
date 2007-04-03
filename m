Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 488B5DDF11
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 02:18:00 +1000 (EST)
Date: Tue, 3 Apr 2007 11:19:38 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 12/19] PCI: rpaphp: remove rpaphp_set_attention_status()
Message-ID: <20070403161938.GO8423@localdomain>
References: <20070403002629.GI4922@austin.ibm.com>
	<20070403004446.C25AA3A65C@topology.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403004446.C25AA3A65C@topology.austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> 
> The rpaphp_set_attention_status() routine seems to be a wrapper
> around a single rtas call. Abolish it.

...

>  static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
>  {
> -	int retval = 0;
> +	int rc;
>  	struct slot *slot = (struct slot *)hotplug_slot->private;
>  
>  	down(&rpaphp_sem);
>  	switch (value) {
>  	case 0:
> -		retval = rpaphp_set_attention_status(slot, LED_OFF);
> -		hotplug_slot->info->attention_status = 0;
> -		break;
>  	case 1:
> -	default:
> -		retval = rpaphp_set_attention_status(slot, LED_ON);
> -		hotplug_slot->info->attention_status = 1;
> -		break;
>  	case 2:
> -		retval = rpaphp_set_attention_status(slot, LED_ID);
> -		hotplug_slot->info->attention_status = 2;
> +		break;
> +	default:
> +		value = 1;
>  		break;
>  	}
>  	up(&rpaphp_sem);
> -	return retval;
> +
> +	rc = rtas_set_indicator(DR_INDICATOR, slot->index, value);
> +	if (!rc)
> +		hotplug_slot->info->attention_status = value;
> +
> +	return rc;

You're changing the locking behavior here -- you've moved the
rtas_set_indicator and the modification of
hotplug_slot->info->attention_status outside of the code which holds
rpaphp_sem.

P.S.  Should rpaphp_sem be changed to a mutex?
