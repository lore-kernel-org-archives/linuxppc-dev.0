Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0A0E6DE009
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 12:29:56 +1100 (EST)
Message-ID: <45B9598C.6060805@am.sony.com>
Date: Thu, 25 Jan 2007 17:29:48 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 8/14] ps3: bind interrupt to cpu
References: <45B8188A.5070900@am.sony.com>
	<1169697245.24996.52.camel@localhost.localdomain>
In-Reply-To: <1169697245.24996.52.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> -int ps3_alloc_io_irq(unsigned int interrupt_id, unsigned int *virq);
>> +enum ps3_cpu_binding {
>> +	PS3_BINDING_CPU_0 = 0,
>> +	PS3_BINDING_CPU_1 = 1,
>> +	PS3_BINDING_CPU_ANY = 3,
>> +};
> 
> While this patch might still get in since it actually fixes a problem,
> the normal way of expressing interrupt bindings on linux is via a
> cpumask. I recommend you do that too and update the affinity mask in
> the irq_desc even if you don't provide a set_affinity() callback to
> do runtime change just yet (and maybe never due to HV limitations).

I will look into doing that.

-Geoff
