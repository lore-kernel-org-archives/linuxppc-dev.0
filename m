Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A33E3DDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 22:47:37 +1100 (EST)
Message-Id: <051D5D14-4CD9-4138-879A-23DA2B02AB7F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1237528109.25062.568.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v2] powerpc: Add support for CoreInt delivery of
	interrupts on MPIC
Date: Fri, 20 Mar 2009 06:47:31 -0500
References: <1236784730-616-1-git-send-email-galak@kernel.crashing.org>
	<1237528109.25062.568.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 20, 2009, at 12:48 AM, Benjamin Herrenschmidt wrote:

> On Wed, 2009-03-11 at 10:18 -0500, Kumar Gala wrote:
>> CoreInt provides a mechansim to deliver the IRQ vector directly
>> into the core on an interrupt (via the SPR EPR) rather than having
>> to go IACK on the PIC.  This is suppose to provide an improvment
>> in interrupt latency by reducing the time to get the IRQ vector.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> * Fixed MPIC_GREG_GCONF_COREINT flag to be 0x60000000 as per spec  
>> and pointed about by Dave
>
> Are you sure ? That's 2 bits ...

Yeah.  We expanded the mode field to two bits (mask would be 0x60000000)

0x00 = pass through (interrupts routed to IRQ0)
0x01 = Mixed mode
0x10 = reserved
0x11 = External proxy / coreint

- k
