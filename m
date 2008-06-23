Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0AA49DE31A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 01:02:43 +1000 (EST)
Message-Id: <DEF3CE1C-9101-42AA-9F68-768A6D12C00C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1214094036.8011.192.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH][WIP][RFC] powerpc: fixup lwsync at runtime
Date: Mon, 23 Jun 2008 10:02:27 -0500
References: <Pine.LNX.4.64.0806201131040.17834@blarg.am.freescale.net>
	<1214004193.8011.184.camel@pasglop>
	<81690AB9-9D0A-4CB4-8A0A-B0D8653FECE7@kernel.crashing.org>
	<1214094036.8011.192.camel@pasglop>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 21, 2008, at 7:20 PM, Benjamin Herrenschmidt wrote:

> On Sat, 2008-06-21 at 11:07 -0500, Kumar Gala wrote:
>>
>>> Remind me why we want to do that ? ie. can't we just use lwsync
>>> unconditionally ? It's supposed to degrade to sync on CPUs that
>> don't
>>> support it, or is that broken on some parts ?
>>
>> I believe its broken on e500v1/v2.  However I'll double check.

e500v1/v2 treat lwsync as a illop.

> An option is that if you get a program check instead, you can "fixup"
> the sync from the exception too...


We could.  However it just feels a bit dirty to illop in the kernel  
and fix it up.

Plus, I think David Woodhouse had some ideas about being able to  
generate a single SMP/no-SMP kernel image like x86 apparently does  
with some form of run time fixup.  It would seem that was be in the  
same realm as the lwsync fixup I'm looking at.

- k
