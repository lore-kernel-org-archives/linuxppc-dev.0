Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLMDY2zbTzDvy9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 15:23:25 +1100 (AEDT)
Date: Sat, 19 Nov 2016 15:23:18 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/13] powerpc/64: Provide functions for accessing POWER9
 partition table
Message-ID: <20161119042318.GG29462@fergus.ozlabs.ibm.com>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-3-git-send-email-paulus@ozlabs.org>
 <a08edf29-2d09-0482-f870-18c8b44ace47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a08edf29-2d09-0482-f870-18c8b44ace47@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 19, 2016 at 11:45:52AM +1100, Balbir Singh wrote:
> > +#ifdef CONFIG_PPC_BOOK3S_64
> > +void mmu_partition_table_init(void)
> > +{
> > +	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
> > +
> > +	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
> 
> This should be 36 (12 + 24)

True, though for P9, PATB_SIZE_SHIFT has to be 16.

The BUILD_BUG_ON_MSG is probably not really necessary - I just moved
this code from elsewhere.

Paul.
