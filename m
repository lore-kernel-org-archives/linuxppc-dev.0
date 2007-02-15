Return-Path: <johnrose@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AD069DDEA2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 04:08:27 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1FH8NFE028685
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 12:08:23 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1FH8MiK486812
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:08:22 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1FH81m5018718
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:08:01 -0700
Subject: Re: [PATCH 2.6.21-rc1] ehea: dynamic add / remove port
From: John Rose <johnrose@austin.ibm.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <1171491906.30473.3.camel@sinatra.austin.ibm.com>
References: <200702141536.28665.ossthema@de.ibm.com>
	<1171491906.30473.3.camel@sinatra.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1171559098.20758.70.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Thu, 15 Feb 2007 11:04:58 -0600
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

> Second, the probe and remove functions do not communicate whether an add
> or remove was successful.  Combine this with the lack of port
> information in the adapter sysfs directory, and the userspace tool has
> no way of verifying a dynamic add/remove.

One way to communicate a return code is by making the sysfs interface
file read/write, and having the read callback give a return code.  For
an example of this, you can look at drivers/pci/rpadlpar_sysfs.c and
rpadlpar_core.c.

It would still be nice to have some way from the adapter sysfs directory
to list/examine logical ports.  Symlinks would work, but it would be
even nicer to have a new kobject per port with attribute files for
logical id, state, etc.
