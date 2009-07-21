Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1A5CAB7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 10:23:53 +1000 (EST)
Subject: Re: Simple question about powerpc kernel source.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: HongWoo Lee <hongwoo7@gmail.com>
In-Reply-To: <4A6508AD.6090207@gmail.com>
References: <4A643219.3070004@gmail.com> <1248084158.30899.8.camel@pasglop>
	<4A6508AD.6090207@gmail.com>
Content-Type: text/plain
Date: Tue, 21 Jul 2009 10:23:46 +1000
Message-Id: <1248135826.30899.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-07-21 at 09:15 +0900, HongWoo Lee wrote:
> First, I aleady understood about @highest, @higher, @h and @l. 
> For now, what I want to know is about "##" in the below code. 
> 
> #define LOADADDR(rn,name)           \
>     lis     rn,name##@highest;      \
>     ori     rn,rn,name##@higher;    \
>     rldicr  rn,rn,32,31;            \
>     oris    rn,rn,name##@h;         \
>     ori     rn,rn,name##@l
> 
> And I don't want to ask every detail. 
> So I want to know the manual or document which describes the detail. 

Well, it's just concatenation...

Ie, if you do LOADADDR(rn, .myfunction) it will turn to

   lis     rn,.myfunction@highest;
   ori     rn,rn,.myfunction@higher;
   rldicr  rn,rn,32,31;
   oris    rn,rn,.myfunction@h;
   ori     rn,rn,.myfunction@l
> 
Which means putting the address of .myfunction into register rn.

Cheers,
Ben.
