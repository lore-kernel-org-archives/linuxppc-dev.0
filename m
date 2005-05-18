Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9DAFC679F4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 02:19:22 +1000 (EST)
In-Reply-To: <55497ec3de50301c9f568be24ed3edac@embeddededge.com>
References: <55497ec3de50301c9f568be24ed3edac@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <96c735b4d1269864b56c84c72a8a4ac3@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 18 May 2005 11:19:15 -0500
To: "Dan Malek" <dan@embeddededge.com>
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


On May 18, 2005, at 9:14 AM, Dan Malek wrote:

>
>
> On May 18, 2005, at 6:21 AM, Eugene Surovegin wrote:
>
> > This patch fixed CONFIG_TASK_SIZE handling on 44x.
>
> Paul suggested to me and I've been contemplating changing
>  the page table management on PowerPC to something similar
>  to other platforms.=A0 At first, I was only going to do this on 8xx,
>  but I think I'll do it for PowerPC in general so all boards can
>  take advantage if they choose to do so.
>
> Other ports populate the user page tables with the kernel pmd
>  entries upon kernel faults, then we don't have to distinguish
>  among page tables during the TLB exceptions.=A0 I'm hoping we
>  can populate the init page table entries at boot time, and then
>  everyone will inherit them, eliminating all faults unless the kernel
>  vmalloc space grows to need a new pmd entry.

I'm a bit concerned about this in the future.  On Book-E parts we may=20
end up actually utilizing the address space bit to provide a true 4G/4G=20=

split.  I understand the current pain in doing this today.  I just want=20=

you to be aware of what the future might bring.

>  This would be a generic solution to selecting task size, among
>  other advanced memory mapping options.
>
> I'll keep you posted.

While we wait on this I think getting Eugene's patch is worth while.

- kumar
