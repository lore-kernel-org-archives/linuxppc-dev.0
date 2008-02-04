Return-Path: <ossthema@de.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A760DDF24
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 02:24:39 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m14FOZR9244216
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 15:24:35 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m14FOZ7G5062716
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 15:24:35 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m14FOV5S012437
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Feb 2008 15:24:32 GMT
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH 2/2] ehea: add memory remove hotplug support
Date: Mon, 4 Feb 2008 16:24:30 +0100
References: <200802041404.49960.ossthema@de.ibm.com>
	<1202136362.7672.5.camel@concordia>
In-Reply-To: <1202136362.7672.5.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802041624.31228.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 04 February 2008 15:46, Michael Ellerman wrote:
> On Mon, 2008-02-04 at 14:04 +0100, Jan-Bernd Themann wrote:
> > Add memory remove hotplug support

> > @@ -3559,6 +3578,10 @@ int __init ehea_module_init(void)
> >  	if (ret)
> >  		ehea_info("failed registering reboot notifier");
> >  
> > +	ret = register_memory_notifier(&ehea_mem_nb);
> > +	if (ret)
> > +		ehea_info("failed registering memory remove notifier");
> > 
> >  	ret = crash_shutdown_register(&ehea_crash_handler);
> >  	if (ret)
> >  		ehea_info("failed registering crash handler");
> 
> You don't do anything except print a message if the registration fails.
> What happens when someone tries to remove memory but the memory notifier
> wasn't registered properly? Bang?

In case the registration fails and somebody tries to free memory:
- Driver will not remove the affected memory from the eHEA memory region
  --> Firmware (phyp) can not free that memory (as marked as used)
  --> Therefore the removed memory could not be used in an other partition

It makes sense to allow the driver to work anyway. Having no ethernet
would not really be a good alternative.

Regards,
Jan-Bernd
