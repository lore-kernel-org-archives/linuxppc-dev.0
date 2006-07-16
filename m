Return-Path: <jimix@watson.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2752767B78
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jul 2006 12:10:09 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6G2A6xX012446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 22:10:06 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6G2A6DR151734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 20:10:06 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6G2A5dA024011
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 20:10:05 -0600
In-Reply-To: <1152911297.23037.109.camel@localhost.localdomain>
References: <4CE0FC89-084F-42E8-8E3B-8D2C41AC06F2@watson.ibm.com>
	<1152911297.23037.109.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <28C15305-BE9F-4EE7-93A2-437EAEA7B886@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: Kexec initial registers
Date: Sat, 15 Jul 2006 22:10:04 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 14, 2006, at 5:08 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2006-07-14 at 12:02 -0400, Jimi Xenidis wrote:
>> This is what I have so far:
>>
>>    r3: address of device tree blob
>>    r4: address that kernel was loaded
>>    r5: not OF (=0)
>
> Correct and that's all that should be needed
>
>>    r13: local_paca address (0?)
>
> You shouldn't have to care about r13 at all, it should be set by the
> kernel before it's used. If not, please let us know as that means  
> there
> is a bug :)

Not! 99.99% :)
When loading a kernel under Xen using kexec we set r1-r5 and set all  
other GPRS to all 5's (cuz we can) with CONFIG_PPC_EARLY_DEBUG=y and  
all hell breaks loose in the first printk()/DBG() from early_setup()  
for:
   kernel/printk.c:506
   506		spin_lock_irqsave(&logbuf_lock, flags);

where is access local_paca.

I think everyone else (ot just the sane ones) just sets all GPRS to 0

-JX
