Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD5F6DDF07
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jun 2008 02:07:51 +1000 (EST)
Message-Id: <81690AB9-9D0A-4CB4-8A0A-B0D8653FECE7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1214004193.8011.184.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH][WIP][RFC] powerpc: fixup lwsync at runtime
Date: Sat, 21 Jun 2008 11:07:41 -0500
References: <Pine.LNX.4.64.0806201131040.17834@blarg.am.freescale.net>
	<1214004193.8011.184.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 20, 2008, at 6:23 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2008-06-20 at 11:36 -0500, Kumar Gala wrote:
>> This is a work in progress towards make lwsync fixed up at  
>> runtime.  The
>> patch is based (requires) the module refactoring patch.  Some of  
>> this code
>> should be reworked based on the code patching work from Michael.   
>> Also,
>> ppc64 and vdso support needs a bit of cleaning up.
>>
>> Some questions:
>> * How do we determine at runtime if we need to convert sync to  
>> lwsync.
>> This is simliar to cpu_feature but has the issue that cpu_feature  
>> is about
>> either having code in or not.
>>
>> * Do we simplify the section of fixup information and remove the  
>> mask and
>> value since we don't use them and they double the size of the section
>
> Remind me why we want to do that ? ie. can't we just use lwsync
> unconditionally ? It's supposed to degrade to sync on CPUs that don't
> support it, or is that broken on some parts ?

I believe its broken on e500v1/v2.  However I'll double check.

- k
