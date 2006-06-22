Return-Path: <jimix@watson.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 042FF679FC
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 20:58:45 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5MAwf1Y012109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 06:58:41 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5MAwq5f101802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 04:58:52 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5MAweQO004785
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 04:58:40 -0600
In-Reply-To: <20060621235156.GA5414@pb15.lixom.net>
References: <E1FtBvP-00026H-TC@kmac.watson.ibm.com>
	<20060621235156.GA5414@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6BBF4F7C-1375-41FF-8D42-43BEC67194CC@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH] Don't access HID registers if running on a Hypervisor.
Date: Thu, 22 Jun 2006 06:58:01 -0400
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 21, 2006, at 7:51 PM, Olof Johansson wrote:

> On Wed, Jun 21, 2006 at 07:15:55PM -0400, Jimi Xenidis wrote:
>>
>> The following patch avoids accessing Hypervisor privilege HID
>> registers when running on a Hypervisor (MSR[HV]=0).
>
> I'm curious, why is this causing problems now?
Every once in a while I run Xen on one of our simulators thats is  
sensitive to this code that does this.
First time we hit it (a while ago) we discovered that mtsdr1 was used  
(even though a no-op)

> JS20 has been running
> that code with a hypervisor since a long time back.

970s consider this a no-op (I believe an expensive one) especially  
when you consider some of the synchronization issues around the mtspr  
HIDx.
And though this is 970 specific code, Cell and future processors,  
will no longer allow writing to to these registers if !(MSR[0]=1 &&  
MSR[PR]=0)

-JX
