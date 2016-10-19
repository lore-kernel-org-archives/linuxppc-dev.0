Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szFvg2SVmzDt1d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 13:17:35 +1100 (AEDT)
In-Reply-To: <1476180904-19466-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kda@linux-powerpc.org, jstancek@redhat.com
Subject: Re: powerpc/mm/hash64: Fix might_have_hea() check
Message-Id: <3szFvg0GZwz9sBr@ozlabs.org>
Date: Wed, 19 Oct 2016 13:17:34 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-10 at 10:15:04 UTC, Michael Ellerman wrote:
> In commit 2b4e3ad8f579 ("powerpc/mm/hash64: Don't test for machine type
> to detect HEA special case") we changed the logic in might_have_hea()
> to check FW_FEATURE_SPLPAR rather than machine_is(pseries).
> 
> However the check was incorrectly negated, leading to crashes on
> machines with HEA adapters, such as:
> 
>   mm: Hashing failure ! EA=0xd000080080004040 access=0x800000000000000e current=NetworkManager
>       trap=0x300 vsid=0x13d349c ssize=1 base psize=2 psize 2 pte=0xc0003cc033e701ae
>   Unable to handle kernel paging request for data at address 0xd000080080004040
>   Call Trace:
>     .ehea_create_cq+0x148/0x340 [ehea] (unreliable)
>     .ehea_up+0x258/0x1200 [ehea]
>     .ehea_open+0x44/0x1a0 [ehea]
>     ...
> 
> Fix it by removing the negation.
> 
> Fixes: 2b4e3ad8f579 ("powerpc/mm/hash64: Don't test for machine type to detect HEA special case")
> Cc: stable@vger.kernel.org # v4.8+
> Reported-by: Denis Kirjanov <kda@linux-powerpc.org>
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/08bf75ba852ef8304a84b6a030466b

cheers
