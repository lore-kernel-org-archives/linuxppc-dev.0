Return-Path: <jimix@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45C1F67A3A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 22:47:00 +1000 (EST)
In-Reply-To: <17561.56593.481580.556093@cargo.ozlabs.ibm.com>
References: <E1FtBvP-00026H-TC@kmac.watson.ibm.com>
	<17561.56593.481580.556093@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C468730C-7E39-4B17-869D-CB2BA802A709@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH] Don't access HID registers if running on a Hypervisor.
Date: Wed, 21 Jun 2006 22:35:28 -0400
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 21, 2006, at 7:58 PM, Paul Mackerras wrote:

> Jimi Xenidis writes:
>
>> The following patch avoids accessing Hypervisor privilege HID
>> registers when running on a Hypervisor (MSR[HV]=0).
>
> Why?  Aren't the writes defined to be no-ops when not in hypervisor
> mode?

The write are no-ops but look at the instructions required to be  
around the write for some of them.
I believe read may have performance issues as well.

I juts think its good practice and as Xell and newer processes come  
along we may want to start using the PACA(?) rather then peeking at  
the msr all the time.

-JX
