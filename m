Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrHwt6lRpzDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 13:24:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Carpenter <dan.carpenter@oracle.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [bug report] Linux-2.6.12-rc2
In-Reply-To: <20160714222224.GA25917@mwanda>
References: <20160714222224.GA25917@mwanda>
Date: Fri, 15 Jul 2016 13:24:11 +1000
Message-ID: <87mvljbn38.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Carpenter <dan.carpenter@oracle.com> writes:

> Hi PPC Devs,
>
> The patch 1da177e4c3f4: "Linux-2.6.12-rc2" from Apr 16, 2005, leads

Might want to special case that one :)

> to the following static checker warning:
>
> 	arch/powerpc/sysdev/ipic.c:783 ipic_set_priority()
> 	error: buffer overflow 'ipic_info' 95 <= 127
...
>
>    773  int ipic_set_priority(unsigned int virq, unsigned int priority)
>    774  {
>    775          struct ipic *ipic = ipic_from_irq(virq);
>    776          unsigned int src = virq_to_hw(virq);
>    777          u32 temp;
>    778  
>    779          if (priority > 7)
>    780                  return -EINVAL;
>    781          if (src > 127)
>                     ^^^^^^^^^
> We cap this at 127
>
>    782                  return -EINVAL;
>    783          if (ipic_info[src].prio == 0)
>                     ^^^^^^^^^^^^^^
> But we only have 95 elements.  Should the array be larger or should
> we >= ARRAY_SIZE(ipic_info) is invalid?

I don't know the code personally, but looking at the history it seems new
interrupts are added manually with specific flags.

So testing against ARRAY_SIZE would be the best fix AFAICS.

cheers
