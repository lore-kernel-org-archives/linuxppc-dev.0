Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id B31861A0725
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 23:57:46 +1000 (AEST)
Subject: Re: memcpy regression
To: Michal Sojka <sojkam1@fel.cvut.cz>
References: <871teeux4w.fsf@steelpick.2x.cz>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <55E9A354.6070600@c-s.fr>
Date: Fri, 4 Sep 2015 15:57:40 +0200
MIME-Version: 1.0
In-Reply-To: <871teeux4w.fsf@steelpick.2x.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 04/09/2015 15:33, Michal Sojka a écrit :
> Dear Christophe,
>
> my MPC5200-based system stopped booting recently. I bisected the problem
> to your commit below. If I revert that commit (on top of
> 807249d3ada1ff28a47c4054ca4edd479421b671 = v4.2-6663-g807249d), my
> system boots again.
>
>

Do you use mainline code only, or do you have home-made code ?

memcpy() is not supposed to be used on non-cacheable memory.
memcpy_toio() is the function to use when copying to non-cacheble area.

When I submitted the patch, I looked for erroneous use of memcpy() and 
memset().
I found one wrong use of memset() that I changed to memset_io() but I 
didn't find any misuse of memcpy().
But I may have missed one.

Christophe
