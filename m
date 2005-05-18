Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59A57679FA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 02:48:57 +1000 (EST)
In-Reply-To: <96c735b4d1269864b56c84c72a8a4ac3@freescale.com>
References: <55497ec3de50301c9f568be24ed3edac@embeddededge.com>
	<96c735b4d1269864b56c84c72a8a4ac3@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e8a895753d8d591cb5ca167c3a50000e@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 18 May 2005 12:48:57 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix CONFIG_TASK_SIZE handling on 44x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 18, 2005, at 12:19 PM, Kumar Gala wrote:

> I'm a bit concerned about this in the future.  On Book-E parts we may 
> end up actually utilizing the address space bit to provide a true 
> 4G/4G split.

I've contemplated the 4G/4G split and we have discussed this for years.
This is why I kept the separate kernel/user page table lookup in the TLB
miss handlers.

This was always lost to the Linux "efficiency" argument due to the 
mapping
operations required for accessing user space from the kernel.  I don't
remember Book E inventing alternate address space options as m68k
does, and without them it will be lots of kernel modifications to 
support
this.  I suspect most of them will be under the "...to_from_user ..." 
functions
and macros, but there are other places in the kernel where the
mapping is assumed.

>  I understand the current pain in doing this today.  I just want you 
> to be aware of what the future might bring.

As I said, the changes aren't required to be implemented by anyone,
it all depends how you choose to write the tlb management functions
for a particular processor.  The infrastructure will be there to choose
either method.  Until we actually have totally separate kernel and
user VM spaces, you may as well take advantage of the performance
improvement.

> While we wait on this I think getting Eugene's patch is worth while.

That's fine, it was just an opportunity for me to post the message.

Thanks.


	-- Dan
