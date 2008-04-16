Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1FEDBDE282
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 13:52:26 +1000 (EST)
Message-Id: <8F634002-7BF7-4B6F-BB88-CDCCEE2AA4A1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Gutson Daniel-ADG035 <daniel.gutson@motorola.com>
In-Reply-To: <0539F2514A979C4B9386FF81809203FF016B6540@ct11exm66.ds.mot.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: io_block_mapping & ioremap question
Date: Tue, 15 Apr 2008 22:52:19 -0500
References: <0539F2514A979C4B9386FF81809203FF016B6540@ct11exm66.ds.mot.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 11:25 AM, Gutson Daniel-ADG035 wrote:
> Hi,
> 	I'm doing some work on 2.6.10, and got this problem:
> - there are some io_block_mapping calls in the setup_io_mapping
> callback, that use the BATs, and passing same va and pa each one.
> Problem arises later when vmallocs gets a a pointer within the mapped
> ranges. In other words, seems like the VMM is not aware of the BATs
> mapping.
>
> So what I did is: called first ioremap and then io_block_mapping in  
> the
> callback thus not hardcoding the va, something like:
> 	va = ioremap(pa, size);
> 	io_block_mapping(pa, va, size);
>
> Questions:
> 	1) Is it right?
> 	2) Should I unmap that address sometime later? (i.e. after
> mem_init_done).

You should look at getting ride of your io_block_mapping calls as  
we've removed that in new kernels.

However, ioremap() should work properly in that it should lookup the  
address you are mapping via p_mapped_by_bats().

- k
