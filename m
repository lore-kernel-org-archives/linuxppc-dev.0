Return-Path: <dan@embeddedalley.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 1B633679E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 05:42:09 +1000 (EST)
In-Reply-To: <4D8794260B62C940BBA7150CC5EB3BD432D4F4@bosmail.BOS.int.mrv.com>
References: <4D8794260B62C940BBA7150CC5EB3BD432D4F4@bosmail.BOS.int.mrv.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <03A09DFD-FDB7-42A2-9D7D-D3811170BF78@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: kernel 2.6.15: cpm_uart driver broken?
Date: Wed, 19 Apr 2006 15:42:05 -0400
To: Kenneth Poole <kpoole@mrv.com>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 19, 2006, at 3:24 PM, Kenneth Poole wrote:

>
>  		/* get pointer */
> -		cp = cpm2cpu_addr(bdp->cbd_bufaddr);
> +		cp = (unsigned char *)pinfo->mem_addr +
> (bdp->cbd_bufaddr - pinfo->dma_addr);


Ummm, no.  Keep the cpm2cpu_addr() and pass it
some driver data structure pointer so it does the computes,
or better, keep the phys/virt addresses in a handy data
structure you can easily access and work with offsets within
the different address spaces.  The test of addr >= CPM_ADDR
is critically important to early boot and kgdb support
and can't be removed.


> -		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
> +		bdp->cbd_bufaddr = dma_addr;

This kind of initialization is broken, too.  You have to test
that memory address and return the proper space.

Thanks.

	-- Dan
