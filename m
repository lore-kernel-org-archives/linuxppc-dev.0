Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wNwdG0XZGzDqR1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 00:35:44 +1000 (AEST)
Date: Thu, 11 May 2017 10:35:38 -0400 (EDT)
Message-Id: <20170511.103538.1094530388932292836.davem@davemloft.net>
To: mhocko@kernel.org
Cc: pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 borntraeger@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170511080537.GE26782@dhcp22.suse.cz>
References: <20170510145726.GM31466@dhcp22.suse.cz>
 <20170510.111943.1940354761418085760.davem@davemloft.net>
 <20170511080537.GE26782@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Hocko <mhocko@kernel.org>
Date: Thu, 11 May 2017 10:05:38 +0200

> Anyway, do you agree that doing the struct page initialization along
> with other writes to it shouldn't add a measurable overhead comparing
> to pre-zeroing of larger block of struct pages?  We already have an
> exclusive cache line and doing one 64B write along with few other stores
> should be basically the same.

Yes, it should be reasonably cheap.
