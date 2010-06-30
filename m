Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FC89B6F19
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 08:26:49 +1000 (EST)
In-Reply-To: <1277878239.4200.285.camel@pasglop>
References: <20100625095606.GG12443@tyan-ft48-01.lab.bos.redhat.com>
	<57727.84.105.60.153.1277464103.squirrel@gate.crashing.org>
	<20100625111829.GH12443@tyan-ft48-01.lab.bos.redhat.com>
	<1277878239.4200.285.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B03394B1-54FD-43F1-A34A-6E485DBAEB3D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Adjust arch/powerpc inline asms for recent gcc change
Date: Thu, 1 Jul 2010 00:26:53 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jakub Jelinek <jakub@redhat.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>> -		stw%U0%X0 %L2,%1"
>>>> -	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
>>>> +		stw%U1%X1 %L2,%1"
>>>> +	: "=m<>" (*ptep), "=m<>" (*((unsigned char *)ptep+4))
>>>>  	: "r" (pte) : "memory");
>>>
>>> This still isn't correct -- the constraint says that a byte
>>> is written, but the insn changes a word.  Probably should just
>>> be ptep[1] ?
>
> Oops, almost forgot about this. Are you guys shooting a new patch  
> or do
> you want me to do it ?

It's really an independent fix.  Just take Jakub's patch, I'll do one
on top of it?


Segher
