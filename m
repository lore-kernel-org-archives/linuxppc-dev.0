Return-Path: <khalid.aziz@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybGWh6NB2zDqfw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 03:37:20 +1100 (AEDT)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 vADGbIEs012027
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 16:37:18 GMT
Subject: Re: linux-next: Tree for Nov 7
To: Michal Hocko <mhocko@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Joel Stanley <joel@jms.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller
 <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org
References: <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
 <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
 <20171113154939.6ui2fmpokpm7g4oj@dhcp22.suse.cz>
 <20171113160637.jhekbdyfpccme3be@dhcp22.suse.cz>
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <c52fa249-9583-18a2-cbac-28abfb23d5a5@oracle.com>
Date: Mon, 13 Nov 2017 09:35:22 -0700
MIME-Version: 1.0
In-Reply-To: <20171113160637.jhekbdyfpccme3be@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/13/2017 09:06 AM, Michal Hocko wrote:
> OK, so this one should take care of the backward compatibility while
> still not touching the arch code
> ---
> commit 39ff9bf8597e79a032da0954aea1f0d77d137765
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Mon Nov 13 17:06:24 2017 +0100
> 
>      mm: introduce MAP_FIXED_SAFE
>      
>      MAP_FIXED is used quite often but it is inherently dangerous because it
>      unmaps an existing mapping covered by the requested range. While this
>      might be might be really desidered behavior in many cases there are
>      others which would rather see a failure than a silent memory corruption.
>      Introduce a new MAP_FIXED_SAFE flag for mmap to achive this behavior.
>      It is a MAP_FIXED extension with a single exception that it fails with
>      ENOMEM if the requested address is already covered by an existing
>      mapping. We still do rely on get_unmaped_area to handle all the arch
>      specific MAP_FIXED treatment and check for a conflicting vma after it
>      returns.
>      
>      Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> ...... deleted .......
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 680506faceae..aad8d37f0205 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1358,6 +1358,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>   	if (mm->map_count > sysctl_max_map_count)
>   		return -ENOMEM;
>   
> +	/* force arch specific MAP_FIXED handling in get_unmapped_area */
> +	if (flags & MAP_FIXED_SAFE)
> +		flags |= MAP_FIXED;
> +
>   	/* Obtain the address to map to. we verify (or select) it and ensure
>   	 * that it represents a valid section of the address space.
>   	 */

Do you need to move this code above:

         if (!(flags & MAP_FIXED))
                 addr = round_hint_to_min(addr);

         /* Careful about overflows.. */
         len = PAGE_ALIGN(len);
         if (!len)
                 return -ENOMEM;

Not doing that might mean the hint address will end up being rounded for 
MAP_FIXED_SAFE which would change the behavior from MAP_FIXED.

--
Khalid
