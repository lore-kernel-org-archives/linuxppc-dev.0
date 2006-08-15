Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F3369679E2
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 17:40:11 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7F7e6up091354
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 07:40:06 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7F7fwRS067158
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 08:41:58 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7F7e6Op024934
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 08:40:06 +0100
Date: Tue, 15 Aug 2006 09:39:59 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 1/7] ehea: interface to network stack
Message-ID: <20060815073959.GB6922@osiris.boeblingen.de.ibm.com>
References: <44E0A4CC.4090705@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44E0A4CC.4090705@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +int __init ehea_module_init(void)
> +{
> +	int ret = -EINVAL;
> +
> +	EDEB_EN(7, "");
> +
> +	printk(KERN_INFO "IBM eHEA Ethernet Device Driver (Release %s)\n",
> +	       DRV_VERSION);
> +
> +
> +	ret = ibmebus_register_driver(&ehea_driver);
> +	if (ret) {
> +		EDEB_ERR(4, "Failed registering eHEA device driver on ebus");
> +		return -EINVAL;
> +	}
> +
> +	EDEB_EX(7, "");
> +	return 0;
> +}

Function should be static and could be shortened to the single line

return ibmebus_register_driver(&ehea_driver);

, I guess :)
