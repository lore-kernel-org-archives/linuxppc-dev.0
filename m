Return-Path: <johnrose@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87C80DDD07
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 04:28:08 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1KHS5cu029146
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 12:28:05 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1KHS5LS308164
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 10:28:05 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1KHS4Re028445
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 10:28:04 -0700
Subject: Re: [PATCH 2.6.21-rc1] ibmebus: Support dynamic addition
	and	removal of adapters
From: John Rose <johnrose@austin.ibm.com>
To: Joachim Fenkes <FENKES@de.ibm.com>
In-Reply-To: <OFF5C27801.F7BCD37B-ON85257285.0001F062-85257285.00028E7E@de.ibm.com>
References: <OFF5C27801.F7BCD37B-ON85257285.0001F062-85257285.00028E7E@de.ibm.com>
Content-Type: text/plain
Message-Id: <1171992306.22669.5.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Tue, 20 Feb 2007 11:25:06 -0600
Cc: Paul Mackerras <pmac@au1.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
	External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	Me Notes <johnrose@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> If the probe operation succeeds, the respective device will show up 
> beneath
> /sys/bus/ibmebus/devices.

This approach is not particularly synchronous.  Take the case of an add
failure: how long would an application wait before deciding that the new
device is not going to appear?

It might be preferable to have the write to the probe function fail. 
For example, if we can't find the device node, return -EINVAL or
something.

> This is already taken care of by of_device_register().

If we are scrapping the use of of_device for ibmebus devices, can we
still create a devspec file for OF correlation purposes?

Thanks-
John
