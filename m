Return-Path: <ossthema@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 29C4FDDEC2
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 00:49:58 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l1QDnpwP170508
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 13:49:51 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1QDnovb1315048
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 13:49:51 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1QDnfUi024218
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 13:49:41 GMT
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] ehea: Optional TX/RX path optimized for SMP
Date: Mon, 26 Feb 2007 14:43:46 +0100
References: <200702231730.58579.ossthema@de.ibm.com>
	<adairdses3s.fsf@cisco.com>
In-Reply-To: <adairdses3s.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702261443.46791.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

> Also, as far as the approach of using tasklets, I think it would be
> better to use the "fake netdev" approach to continue to use NAPI.
> Basically you create a pseudo-netdev for each receive queue and have
> NAPI handle the polling for you -- you could look for
> drivers/net/cxgb3 for an example of this.
> 
Thanks for pointing us to this solution. We are now building a NAPI version
that makes use of these pseudo-netdev. The fairness amongst other netdevices
should be better this way.

> 
> Why make this a module option that the user has to set?  Are there any
> circumstances when someone wouldn't want "significant performance
> improvements?"  If this approach is just better, then it should just
> replace the old code.
> 

We'll change the default behaviour to multi queue, but we'd like to keep
the option to run in a single queue mode for debug and backward compabilty.

Thanks,

Jan-Bernd & Christoph R.
 
