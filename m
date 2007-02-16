Return-Path: <johnrose@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25D21DDE24
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 02:54:26 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l1GFrk0I030088
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 10:53:46 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1GFsNWO501918
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 08:54:23 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1GFsM7W021602
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 08:54:23 -0700
Subject: Re: [PATCH 2.6.21-rc1] ehea: dynamic add / remove port
From: John Rose <johnrose@austin.ibm.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200702161606.52789.ossthema@de.ibm.com>
References: <200702141536.28665.ossthema@de.ibm.com>
	<1171491906.30473.3.camel@sinatra.austin.ibm.com>
	<200702161606.52789.ossthema@de.ibm.com>
Content-Type: text/plain
Message-Id: <1171641089.9442.8.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Fri, 16 Feb 2007 09:51:29 -0600
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

Hi-

Sounds good.  A couple of questions/comments:

> I think it is not necessary to have a special entry/kobject for each logical
> port. I suggest we use SET_NETDEV_DEV to create links to all ethernet devices
> that represent each a logical port. This should be in sync with all other 
> ethernet drivers. Port attributes like the "logical port id" that might be 
> need by the userspace application can be added to the net:ethX entry
> (link created with SET_NETDEV_DEV) as additional attributes. 

As we develop the userspace tool, we are finding a need to know the
following for each logical port:

1) the linux interface/device (a symlink would do this)
2) the logical port number - were you suggesting communicating this
through the name of the symlink, or in the directory of the symlink
target?
3) the open firmware path for the logical port.  This is typically
communicated through a sysfs attribute file "devspec", but we can't do
this without a new kobject for the port.

> > 
> > Second, the probe and remove functions do not communicate whether an add
> > or remove was successful.  Combine this with the lack of port
> > information in the adapter sysfs directory, and the userspace tool has
> > no way of verifying a dynamic add/remove.
> 
> True. I suggest we return error codes (-EIO / -EINVAL) in case the adding
> or removing of ports fails. This is possible as we know instantly if the
> operation failed or not. It is a synchronus operation.

Sounds good.

Thanks!
John
