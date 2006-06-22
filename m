Return-Path: <jimix@watson.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C349D679E6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 03:23:36 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5MHNN9f010202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 13:23:24 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5MHNNVc181042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 13:23:23 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5MHNNwV013262
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 13:23:23 -0400
In-Reply-To: <20060622162358.GA13300@pb15.lixom.net>
References: <E1FtBvP-00026H-TC@kmac.watson.ibm.com>
	<17561.56593.481580.556093@cargo.ozlabs.ibm.com>
	<C468730C-7E39-4B17-869D-CB2BA802A709@watson.ibm.com>
	<20060622162358.GA13300@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FB9B346A-5023-4CD8-A921-81ED06F4779C@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH] Don't access HID registers if running on a Hypervisor.
Date: Thu, 22 Jun 2006 13:22:58 -0400
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 22, 2006, at 12:23 PM, Olof Johansson wrote:
>
> Are you aware that this code runs only once per processor during
> boot (and/or during cpu hotplug)? A few extra cycles there won't kill
> anyone.

Hey, I never said it was a hot path, only that it had performance  
issues.
I agree about the a "few extra cycles"

> That being said, not touching the registers makes sense, but I  
> don't buy
> the performance motivation. :-)
>
>> I juts think its good practice and as Xell and newer processes come
>> along we may want to start using the PACA(?) rather then peeking at
>> the msr all the time.
>
> PACA means it's a mfspr + dependent load + test instead of mfmsr +  
> mask,
> right? It'd need benchmarking on several processors to show if it's
> better or not.
>
>
> -Olof
