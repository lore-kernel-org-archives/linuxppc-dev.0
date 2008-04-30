Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B157DE1B4
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 18:01:02 +1000 (EST)
Message-Id: <C602E314-8EDB-497F-9E3D-E7FECFE600A4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18455.59014.305281.949578@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
Date: Wed, 30 Apr 2008 03:00:56 -0500
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
	<18455.37613.709102.30668@cargo.ozlabs.ibm.com>
	<73CD5806-5CE4-40A7-957B-8F164E26FAFB@kernel.crashing.org>
	<18455.59014.305281.949578@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2008, at 10:24 PM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>>> Wouldn't it be better and safer to have the exception prolog for
>>> critical interrupts save SRR0/1 in the stack frame, and have the
>>> prolog for machine checks save SRR0/1 and CSRR0/1 likewise?
>>
>> If we do this I guess we can use SRR0/1 regardless of which level we
>> came from.
>
> That's the idea.  I actually thought the booke exception prologs
> already did that, but it seems I'm wrong.
>
> What sort of things do you expect critical and machine-check handlers
> to be needing to do?

It varies on the parts but remember critical level can be anything  
from watchdog, critical input (equivalent of external input, but at  
the critical level), and debug.  So there is a pretty wide set of  
possibility.

- k
