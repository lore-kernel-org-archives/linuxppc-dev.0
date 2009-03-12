Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3B085DE10C
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 21:46:16 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2CAhXPY019454
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 04:43:33 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2CAk974207484
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 04:46:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2CAk85n032567
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 04:46:09 -0600
Date: Thu, 12 Mar 2009 06:45:43 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
Message-ID: <20090312104543.GB3788@zod.rchland.ibm.com>
References: <49B58779.9040905@lebon.org.ua> <200903120905.11542.sr@denx.de>
	<1236845549.7086.86.camel@pasglop> <200903120924.13378.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200903120924.13378.sr@denx.de>
Cc: lebon@lebon.org.ua, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 12, 2009 at 09:24:13AM +0100, Stefan Roese wrote:
>On Thursday 12 March 2009, Benjamin Herrenschmidt wrote:
>> On Thu, 2009-03-12 at 09:05 +0100, Stefan Roese wrote:
>> > Both is possible. Older U-Boot versions only passed the bd_t struct to
>> > the kernel. For those U-Boot's the wrapper is needed. More recent U-Boot
>> > versions support passing a device-tree blob to the kernel. U-Boot patches
>> > the correct memory size in this blob.
>> >
>> > As a matter of fact, I never used the wrapper before. U-Boot supports
>> > passing the device-tree blob to Linux since quite some time now.
>>
>> Yes, that's also how I use it on canyonlands... now, the wrapper could
>> probably be used to look at the bd_t anyways, no ?
>
>Sure.

Do newer U-Boot versions pass both the dtb and the bd_t?  If not, the wrapper
would have to look for one, then the other and not get confused.

>> Either get the mem 
>> size from there or some flag or version in there can indicate if it's
>> been "fixed".
>
>I don't think that we have some flag and/or version information in the bd_info 
>struct. And extending this struct doesn't sound like a good idea to me.

Yeah, we've already had some issues pop up in the past where the bd_t wasn't
correct for a board in the U-Boot version that shipped with it (like the acadia
boards).  There's not much that can be done to fix it.

josh
