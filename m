Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 62CA5B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 00:27:02 +1000 (EST)
Message-Id: <B8DF32A0-C1A9-4DC3-A642-4081636917A0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "wilbur.chan" <wilbur512@gmail.com>
In-Reply-To: <e997b7420907260834v5923326ele5af13713622c366@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: Question about head_fsl_booke.S
Date: Mon, 27 Jul 2009 09:26:54 -0500
References: <e997b7420907260834v5923326ele5af13713622c366@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 26, 2009, at 10:34 AM, wilbur.chan wrote:

> e500  , in  head_fsl_booke.S
>
> We know,the first two steps are:
>
> 1) invalidate all entries except  the entry we are in
>
> 2) setup a temp mapping and jump to it  respectively:
>
>
>
>         tlbwe
>
>         bl  1f
>     1:  mflr r9
>         rlwimi  r7,r9,0,20,31
>         addi r7, r7,24
>         mtspr   SPRN_SRR0,r7
>         mtspr   SPRN_SRR1,r6
>         rfi
>        /*  jump to 0-4k .
>         question1:   Why not this 'rfi' did not caused jumping  into
> 4k-8k , or 10k-14k ,    etc ?     */

I'm not sure what version of this code you are referencing but it sets  
up a mapping in the alternate address space and jumps to the same EPN.

>
>
>         li r6,0
>
>
>
> question2:  We know that, it is not allowed  the two entrys having the
> same EPN value,so, when setting up a temp entry which ranged from
> 0-4k, is it possible that , this
> range(0-4k)  may conflit with the entry we are executed in now?

Its not allowed for two entries to have the same VA (or conflicting  
VAs) its perfectly find to have the same EPN.  We use the address  
space bit of the VA to ensure we don't conflict.

- k
