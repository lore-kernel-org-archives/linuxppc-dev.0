Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC708DDFE5
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 15:31:45 +1000 (EST)
In-Reply-To: <OFD102D897.20376982-ON862572EB.000F677F-862572EB.000FF942@us.ibm.com>
References: <OFD102D897.20376982-ON862572EB.000F677F-862572EB.000FF942@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BE207C16-E909-43B1-AA2B-BBC9E026F300@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Wed, 30 May 2007 00:31:32 -0500
To: Steve Munroe <sjmunroe@us.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 9:54 PM, Steve Munroe wrote:

>
> Kumar Gala <galak@kernel.crashing.org> wrote on 05/29/2007 07:43:05  
> PM:
>
>>
>> On May 29, 2007, at 6:46 PM, Olof Johansson wrote:
>>
>>> On Wed, May 30, 2007 at 07:32:33AM +1000, Benjamin Herrenschmidt
>>> wrote:
>>>> On Tue, 2007-05-29 at 08:10 -0500, Kumar Gala wrote:
>>>>> This is all problematic since some 64-bit implementations may not
>>>>> guarantee the upper bits are valid when in 32-bit mode.  Look  
>>>>> at the
>>>>> 'Computation Modes' section in the architecture specs 2.03 or
>>>>> greater
>>>>> for embedded processors.
>>>>
>>>> Yuck. Well, we might need to export a spearate CPU feature bit to
>>>> indicate that it's the case then.
>>>
>>> No need for a new bit, you should be able to key off of  
>>> PPC_FEATURE_64
>>> && !PPC_FEATURE_BOOKE.
>>
>> Nope, the architecture allows embedded to behave like server parts
>> and support the full 64-bit registers.  We really should have a new
>> feature bit so that if someone has an implementation of an embedded
>> part that supports the functionality, they get the benefit.
>>
> When such exists we can add a bit, until then we can wait. The current
> 32-bit AT_HWCAP is almost full. so we should not allocate bits on
> speculation.

Understandable.. dare I ask about a few of the current AT_HWCAPs we  
do have:

#define PPC_FEATURE_POWER4              0x00080000
#define PPC_FEATURE_POWER5              0x00040000
#define PPC_FEATURE_POWER5_PLUS         0x00020000
#define PPC_FEATURE_ARCH_2_05           0x00001000
#define PPC_FEATURE_PA6T                0x00000800
#define PPC_FEATURE_POWER6_EXT          0x00000200

What exactly are we using these for?  Can we not use platform for  
some of these?

- k
