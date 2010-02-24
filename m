Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.221])
	by ozlabs.org (Postfix) with ESMTP id 672F3B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Feb 2010 06:42:50 +1100 (EST)
Received: from neli.hopto.org (unknown [88.159.215.98])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id B8BC6687EF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Feb 2010 20:15:21 +0100 (CET)
Received: from conroe.local ([90.0.0.126] ident=micha)
	by neli.hopto.org with esmtp (Exim 4.69)
	(envelope-from <micha@neli.hopto.org>) id 1NkMhd-0007Fv-8T
	for linuxppc-dev@lists.ozlabs.org; Wed, 24 Feb 2010 20:15:21 +0100
Message-ID: <4B857AC1.7020907@neli.hopto.org>
Date: Wed, 24 Feb 2010 20:15:13 +0100
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/7] RapidIO: Add switch locking during discovery
References: <20100224152050.GB13661@kaneng01.tundra.com>
In-Reply-To: <20100224152050.GB13661@kaneng01.tundra.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
> +				/* Attempt to acquire device lock */
> +				rio_mport_write_config_32(port, destid,
> +							  hopcount,
> +							  RIO_HOST_DID_LOCK_CSR,
> +							  port->host_deviceid);
> +				rio_mport_read_config_32(port, destid, hopcount,
> +					RIO_HOST_DID_LOCK_CSR, &result);
> +				while (result != port->host_deviceid) {

It's better to abstract the locking of a device into a new function,
rio_lock_device / rio_unlock_device.

Then you can use those in rio_get_route_entry and rio_add_route_entry.

> @@ -1027,6 +1090,13 @@ int __devinit rio_disc_mport(struct rio_
> +
> +		/* Read DestID assigned by enumerator */
> +		rio_local_read_config_32(mport, RIO_DID_CSR,
> +					 &mport->host_deviceid);
> +		mport->host_deviceid = RIO_GET_DID(mport->sys_size,
> +						   mport->host_deviceid);
> +

This fixes something else, should be a separate patch.

Regards, Micha
