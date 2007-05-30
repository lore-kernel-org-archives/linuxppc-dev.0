Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE90FDE009
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 10:43:24 +1000 (EST)
In-Reply-To: <20070529234655.GA32367@lixom.net>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
	<1180425900.19517.136.camel@localhost.localdomain>
	<9C7D27C7-674E-44B7-A975-69B2E85AB8F2@kernel.crashing.org>
	<1180474353.19517.190.camel@localhost.localdomain>
	<20070529234655.GA32367@lixom.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <16FB57DB-8E02-4F7D-A7B5-BF9719A61BC6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 19:43:05 -0500
To: olof@lixom.net (Olof Johansson)
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 6:46 PM, Olof Johansson wrote:

> On Wed, May 30, 2007 at 07:32:33AM +1000, Benjamin Herrenschmidt  
> wrote:
>> On Tue, 2007-05-29 at 08:10 -0500, Kumar Gala wrote:
>>> This is all problematic since some 64-bit implementations may not
>>> guarantee the upper bits are valid when in 32-bit mode.  Look at the
>>> 'Computation Modes' section in the architecture specs 2.03 or
>>> greater
>>> for embedded processors.
>>
>> Yuck. Well, we might need to export a spearate CPU feature bit to
>> indicate that it's the case then.
>
> No need for a new bit, you should be able to key off of PPC_FEATURE_64
> && !PPC_FEATURE_BOOKE.

Nope, the architecture allows embedded to behave like server parts  
and support the full 64-bit registers.  We really should have a new  
feature bit so that if someone has an implementation of an embedded  
part that supports the functionality, they get the benefit.

- k
