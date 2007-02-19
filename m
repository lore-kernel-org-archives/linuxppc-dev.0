Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 17C31DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 02:33:11 +1100 (EST)
Message-ID: <45D9C32C.7030706@am.sony.com>
Date: Mon, 19 Feb 2007 07:33:00 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC 2/3] zImage: SMP hold
References: <45D7A910.60702@am.sony.com>
	<17880.61499.932513.926761@cargo.ozlabs.ibm.com>
In-Reply-To: <17880.61499.932513.926761@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Geoff Levand writes:
> 
>> +void smp_secondary_hold(unsigned int cpu_id)
>> +{
>> +	while(!smp_secondary_entry)
>> +		(void)0;
> 
> Using a barrier() here rather than making smp_secondary_entry volatile
> would be better, I think.
> 
> Also, what's the lifetime of this code after smp_secondary_entry is
> set, i.e. how do we know the kernel running on the primary cpu will
> wait for the secondary cpus to have got through this code into the
> kernel before it reuses this memory for something else?

I was thinking the most (only?) reliably way is to do it from inside the kernel.
Once inside, the primary waits for all secondaries to enter before proceeding.
That's why I didn't have anything here.  There is already a mechanism in the
kernel with __secondary_hold_acknowledge, but I don't yet know if it does
exactly what is needed.  Do you see any trouble with this?

-Geoff
