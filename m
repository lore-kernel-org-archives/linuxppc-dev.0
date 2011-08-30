Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D95CBB6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 04:09:18 +1000 (EST)
Message-ID: <4E5D272B.6000403@freescale.com>
Date: Tue, 30 Aug 2011 13:08:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix xmon for systems without MSR[RI]
References: <1312838739-20660-1-git-send-email-jimix@pobox.com>
	<1314684670.2488.82.camel@pasglop>
In-Reply-To: <1314684670.2488.82.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/30/2011 01:11 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2011-08-08 at 16:25 -0500, Jimi Xenidis wrote:
>> From: David Gibson <dwg@au1.ibm.com>
>>
>> Based on patch by David Gibson <dwg@au1.ibm.com>
>>
>> xmon has a longstanding bug on systems which are SMP-capable but lack
>> the MSR[RI] bit.  In these cases, xmon invoked by IPI on secondary
>> CPUs will not properly keep quiet, but will print stuff, thereby
>> garbling the primary xmon's output.  This patch fixes it, by ignoring
>> the RI bit if the processor does not support it.
>>
>> There's already a version of this for 4xx upstream, which we'll need
>> to extend to other RI-lacking CPUs at some point.  For now this adds
>> BookE processors to the mix.
> 
> Don't freescale one have RI ?

e500mc does.

e500v2 doesn't -- if a machine check happens while MSR[ME]=0, it causes
a checkstop.

-Scott
