Return-Path: <rppt@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kx6l5MfHzF13F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 21:49:03 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8QBeVXE058746
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 07:49:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mr7jax6p0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 07:49:00 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Wed, 26 Sep 2018 12:48:56 +0100
Date: Wed, 26 Sep 2018 14:48:37 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>,
 "David S. Miller" <davem@davemloft.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Greentime Hu <green.hu@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Jonas Bonn <jonas@southpole.se>, Jonathan Corbet <corbet@lwn.net>,
 Ley Foon Tan <lftan@altera.com>, Mark Salter <msalter@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Matt Turner <mattst88@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>,
 Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>,
 Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>,
 Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, nios2-dev@lists.rocketboards.org,
 openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
 uclinux-h8-devel@lists.sourceforge.jp
Subject: Re: [PATCH 02/30] mm: remove CONFIG_NO_BOOTMEM
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-3-git-send-email-rppt@linux.vnet.ibm.com>
 <20180926092239.GK6278@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180926092239.GK6278@dhcp22.suse.cz>
Message-Id: <20180926114836.GD4628@rapoport-lnx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 26, 2018 at 11:22:39AM +0200, Michal Hocko wrote:
> On Fri 14-09-18 15:10:17, Mike Rapoport wrote:
> > All achitectures select NO_BOOTMEM which essentially becomes 'Y' for any
> > kernel configuration and therefore it can be removed.
> 
> git grep suggests that DEFERRED_STRUCT_PAGE_INIT still depends on
> NO_BOOTMEM but I have a vague feeling that I've seen a patch to address
> that. It would be great to have it folded to this one.

Yes, Alexander has already fixed that at [1]

[1] https://lkml.org/lkml/2018/9/25/1073
 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.
