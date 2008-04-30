Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49D39DE1C7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 18:02:52 +1000 (EST)
Message-Id: <EDF2E889-4B04-42A8-8D93-E04B35162661@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1209537128.18023.225.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
Date: Wed, 30 Apr 2008 03:02:47 -0500
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
	<18455.37613.709102.30668@cargo.ozlabs.ibm.com>
	<73CD5806-5CE4-40A7-957B-8F164E26FAFB@kernel.crashing.org>
	<1209537128.18023.225.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 1:32 AM, Benjamin Herrenschmidt wrote:
>
> On Tue, 2008-04-29 at 18:52 -0500, Kumar Gala wrote:
>> On Apr 29, 2008, at 4:28 PM, Paul Mackerras wrote:
>>> Kumar Gala writes:
>>>
>>>> We need to have unique transfer_to_handler paths for each exception
>>>> level
>>>> that is supported.  We need to use the proper xSRR0/1 depending on
>>>> which
>>>> exception level the interrupt was from.  The macro conversion  
>>>> lets up
>>>> templatize this code path.
>>>
>>> It seems to me that this implies you are assuming that you will  
>>> never
>>> ever get a synchronous normal interrupt such as a TLB miss while you
>>> are in a critical or machine check handler.
>>
>> Grr.. one more thing to fix :)
>>
>>> Wouldn't it be better and safer to have the exception prolog for
>>> critical interrupts save SRR0/1 in the stack frame, and have the
>>> prolog for machine checks save SRR0/1 and CSRR0/1 likewise?
>>
>> If we do this I guess we can use SRR0/1 regardless of which level we
>> came from.
>
> Also consider saving/restoring MAS

got that.  Does 40x/44x have anything similar we need to save/restore?
