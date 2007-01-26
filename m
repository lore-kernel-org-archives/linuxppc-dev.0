Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89A84DE056
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 18:37:32 +1100 (EST)
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90106334E77@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D90106334E77@EMPBEDEX.empirix.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <17DE1287-B02B-4724-A7DF-5C6704ACDC80@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8548E w/ 4 Gig of DDR SDRAM 
Date: Fri, 26 Jan 2007 01:36:32 -0600
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 25, 2007, at 4:53 PM, Morrison, Tom wrote:

> Firstly, excuse my ignorance, I have looked at the archives to see
> if there was any mention of a subject like this - but I could NOT
> find a relevant one - so I ask forgiveness if I missed a thread
> discussing this - and/or if this is a real newbie question!

It's what the list is for.  I do say I think you're the first person  
to post asking about 4G if memory on an 85xx.

> I have MPC8548E with 4 Gig of DDR SDRAM.
>
> I am trying to figure out how to configure the MPC8548 & its
> Local Access Windows (and ?? what else) for 4 Gig of DDR SDRAM.
>
> I know traditionally, SDRAM starts at '0', and I believe that
> Linux is expecting some of the physical memory at this a low
> memory location?

That's correct, we expect at least 64M (maybe less) at 0.

> So, I am in a dilemma - I don't want to waste some DDR RAM by
> also overlapping internal MPC8548 configuration registers
> that are located near the top of the lowest 4 GIG memory area...
>
> So Can I:
>
>  1) Split the definition for the DDR Local Access Windows into 2  
> pieces
>      a) 2 GIG (starting at 0x0)
>      b) 2 Gig above (starting at 0x1_0000_0000)?
>
>                    Or
>
> 2) Configure the LAW/MMU in a fashion before I load/boot Linux
>     to use DDR at (a Local Access Window of) 0x1_0000_0000?

In theory you could do either, however in practice I think #1 is your  
best bet.  This way the 2G @ 0x0 looks to linux like normal memory  
and you don't have to play any tricks (or find assumptions we have  
about being at 0).

However, by splitting memory like this you will probably need to look  
at getting SPARSEMEM on 85xx.  I don't really have any idea on what's  
involved here.

How do you plan on using the 4G of memory?

- k
