Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A3A1DDE17
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 09:52:21 +1000 (EST)
Message-Id: <73CD5806-5CE4-40A7-957B-8F164E26FAFB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18455.37613.709102.30668@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
Date: Tue, 29 Apr 2008 18:52:17 -0500
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
	<18455.37613.709102.30668@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2008, at 4:28 PM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> We need to have unique transfer_to_handler paths for each exception  
>> level
>> that is supported.  We need to use the proper xSRR0/1 depending on  
>> which
>> exception level the interrupt was from.  The macro conversion lets up
>> templatize this code path.
>
> It seems to me that this implies you are assuming that you will never
> ever get a synchronous normal interrupt such as a TLB miss while you
> are in a critical or machine check handler.

Grr.. one more thing to fix :)

> Wouldn't it be better and safer to have the exception prolog for
> critical interrupts save SRR0/1 in the stack frame, and have the
> prolog for machine checks save SRR0/1 and CSRR0/1 likewise?

If we do this I guess we can use SRR0/1 regardless of which level we  
came from.

- k
