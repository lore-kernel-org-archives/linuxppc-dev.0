Return-Path: <jschopp@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 259FCDDDF2
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 04:33:37 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7TIYuhR021687
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 14:34:56 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7TIXWU3585804
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 14:33:32 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7TIXWRj021107
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 14:33:32 -0400
Message-ID: <46D5BBFA.5060200@austin.ibm.com>
Date: Wed, 29 Aug 2007 13:33:30 -0500
From: jschopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 2.6.23] ibmebus: Prevent bus_id collisions
References: <200708291815.18197.fenkes@de.ibm.com>
In-Reply-To: <200708291815.18197.fenkes@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Paul Mackerras <pmac@au1.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Nathan Lynch <ntl@pobox.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	len = strlen(dn->full_name + 1);
> +	bus_len = min(len, BUS_ID_SIZE - 1);
> +	memcpy(dev->ofdev.dev.bus_id, dn->full_name + 1
> +	       + (len - bus_len), bus_len);
> +	for (i = 0; i < bus_len; i++)
> +		if (dev->ofdev.dev.bus_id[i] == '/')
> +			dev->ofdev.dev.bus_id[i] = '_';
>  
>  	/* Register with generic device framework. */
>  	if (ibmebus_register_device_common(dev, dn->name) != 0) {

What happens when the full name is > 31 characters?  It looks to me that it 
will be truncated, which takes away the uniqueness guarantee.

There must be an individual property that is guaranteed to be unique and 
less than 32 characters.  How about "ibm,my-drc-index"?  That looks like a 
good candidate.
