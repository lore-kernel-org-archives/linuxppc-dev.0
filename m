Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5FF73DDFAD
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 02:11:21 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1GFBFOv090962
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 15:11:15 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1GFBFDZ1740814
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 16:11:15 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1GFBEXY004840
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 16:11:15 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: [PATCH 2.6.21-rc1] ehea: dynamic add / remove port
Date: Fri, 16 Feb 2007 16:06:52 +0100
References: <200702141536.28665.ossthema@de.ibm.com>
	<1171491906.30473.3.camel@sinatra.austin.ibm.com>
In-Reply-To: <1171491906.30473.3.camel@sinatra.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200702161606.52789.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <RAISCH@de.ibm.com>,
	Marcus Eder <MEDER@de.ibm.com>, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I agree with most points. Here the new design proposal:

On Wednesday 14 February 2007 23:25, John Rose wrote:
> Hi-
> 
> A few high level comments, then some really insignificant ones.
> 
> First, is there a reason why we shouldn't have a sysfs entry/kobject for
> each logical port?  How is it possible to determine, from the adapter
> sysfs directory, the current number of ports for that adapter?  A port
> sysfs directory could include attributes like the OF path to the port,
> the state of the port, etc etc.

I think it is not necessary to have a special entry/kobject for each logical
port. I suggest we use SET_NETDEV_DEV to create links to all ethernet devices
that represent each a logical port. This should be in sync with all other 
ethernet drivers. Port attributes like the "logical port id" that might be 
need by the userspace application can be added to the net:ethX entry
(link created with SET_NETDEV_DEV) as additional attributes. 
Thus we have a simple and consistent way to determine 
all currently available network interfaces (logical ports) and its
corresponding IDs.

> 
> Second, the probe and remove functions do not communicate whether an add
> or remove was successful.  Combine this with the lack of port
> information in the adapter sysfs directory, and the userspace tool has
> no way of verifying a dynamic add/remove.

True. I suggest we return error codes (-EIO / -EINVAL) in case the adding
or removing of ports fails. This is possible as we know instantly if the
operation failed or not. It is a synchronus operation.


> 
> +		ehea_info("%s -> logial port id #%d",
> 
> Spelling :)
true, fixed

> 
>  	if (port_setup_ok)
> -		ret = 0;	/* At least some ports are setup correctly */
> +		return 0;	/* At least some ports are setup correctly */
>  	else
> -		ret = -EINVAL;
> +		return -EINVAL;
> 
> The else is unnecessary.

agreed, fixed

> 
>  static int __devexit ehea_remove(struct ibmebus_dev *dev)
>  {
>  	struct ehea_adapter *adapter = dev->ofdev.dev.driver_data;
>  	u64 hret;
>  	int i;
> 
> -	for (i = 0; i < adapter->num_ports; i++)
> +	for (i = 0; i < EHEA_MAX_PORTS; i++)
>  		if (adapter->port[i]) {
>  			ehea_shutdown_single_port(adapter->port[i]);
>  			adapter->port[i] = NULL;
>  		}
> 
> Else break?
no break wanted here as "remove_port" might cause situations where
not all currently available ports are in a row

Regards,
Jan-Bernd
