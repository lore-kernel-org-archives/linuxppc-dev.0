Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4CB44DDE23
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 14:29:06 +1000 (EST)
In-Reply-To: <20070731115047.8b88cb78.sfr@canb.auug.org.au>
References: <Pine.LNX.4.64.0707250147150.9086@blarg.am.freescale.net>
	<20070731115047.8b88cb78.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F9BA2E55-0ACE-444E-8A05-D0AC0D52369F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Attempt at addressing head*.S for modpost warnings
Date: Mon, 30 Jul 2007 23:29:59 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 30, 2007, at 8:50 PM, Stephen Rothwell wrote:

> Hi Kumar,
>
> [sorry for the slow reply]
>
> On Wed, 25 Jul 2007 01:49:04 -0500 (CDT) Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> Paul said you were looking into this issue as well.  Wanted to  
>> post what I
>> did on ppc32/e500 as a start for you to look at.  I think the  
>> other ppc32
>> head*.S can follow the same pattern if we like this.  However,  
>> wasn't sure
>> how to do _ENTRY() for ppc64.
>
> What I have done so far is to put some peices of the asm code into
> the .text.init.refok section (see the _INIT_STATIC macro in asm/ 
> ppc_asm.h
> in the current kernel).  I was hoping to separate some of the asm  
> into a
> new file (init_64.S) that would contain this and other code in
> the .init.text section.  That is currently not working (ld crashed on
> me :-)).
>
> Even if you create a .text.head, you will need to teach modpost  
> about it.

Modpost is already aware of .text.head.  Its used on x86 and a few  
other archs today.

- k
