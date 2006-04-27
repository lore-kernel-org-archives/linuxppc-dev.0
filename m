Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 794B567A0E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 08:55:23 +1000 (EST)
In-Reply-To: <20060427114828.GC32127@wohnheim.fh-wedel.de>
References: <4450A1AD.7040506@de.ibm.com>
	<20060427114828.GC32127@wohnheim.fh-wedel.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6C0D7610-D6A3-43CC-9327-926948167D43@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/16] ehca: event queue
Date: Fri, 28 Apr 2006 00:55:10 +0200
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +	if (ret != H_SUCCESS) {
>
> Common convention is to return 0 on success and -ESOMETHING on eror.
> You might want to follow that and remove H_SUCCESS from the complete
> code.

This return code doesn't come from anywhere within the kernel, though.
If we change this, we should get rid of _every_ #define bladibla 0
Do we want that?  (I do ;-) )

>> +		if (!(vpage = ipz_qpageit_get_inc(&eq->ipz_queue))) {
>
> I personally despise assignments in conditionals.  Not sure if this is
> documented in CodingStyle, but IME most kernel hackers tend to dislike
> it as well.

In this case it's obvious; put it on a separate line.


Segher
