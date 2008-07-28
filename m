Return-Path: <dave@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A9A2DE372
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 06:09:59 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6SK9tZq024761
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 16:09:55 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6SK9tXM176466
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 14:09:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6SK9sI3023158
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 14:09:55 -0600
Subject: Re: [PATCH 1/5 V2] Align stack boundaries based on personality
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Eric Munson <ebmunson@us.ibm.com>
In-Reply-To: <6061445882ce9574999bf343eeb333be02a1afa6.1216928613.git.ebmunson@us.ibm.com>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
	<6061445882ce9574999bf343eeb333be02a1afa6.1216928613.git.ebmunson@us.ibm.com>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 13:09:53 -0700
Message-Id: <1217275793.23502.35.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-28 at 12:17 -0700, Eric Munson wrote:
> 
> +static unsigned long personality_page_align(unsigned long addr)
> +{
> +       if (current->personality & HUGETLB_STACK)
> +#ifdef CONFIG_STACK_GROWSUP
> +               return HPAGE_ALIGN(addr);
> +#else
> +               return addr & HPAGE_MASK;
> +#endif
> +
> +       return PAGE_ALIGN(addr);
> +}
...
> -       stack_top = PAGE_ALIGN(stack_top);
> +       stack_top = personality_page_align(stack_top);

Just out of curiosity, why doesn't the existing small-page case seem to
care about the stack growing up/down?  Why do you need to care in the
large page case?

-- Dave
