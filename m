Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
 by ozlabs.org (Postfix) with ESMTP id E48FCB6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 08:30:06 +1000 (EST)
Date: Tue, 05 Jun 2012 15:20:58 -0700 (PDT)
Message-Id: <20120605.152058.828742127223799137.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Fix assmption of end_of_DRAM() returns end
 address
From: David Miller <davem@davemloft.net>
In-Reply-To: <1338934659.7150.113.camel@pasglop>
References: <1338904504-2750-1-git-send-email-bharat.bhushan@freescale.com>
 <1338934659.7150.113.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: bharat.bhushan@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, r65777@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 06 Jun 2012 08:17:39 +1000

> On Tue, 2012-06-05 at 19:25 +0530, Bharat Bhushan wrote:
>> memblock_end_of_DRAM() returns end_address + 1, not end address.
>> While some code assumes that it returns end address.
> 
> Shouldn't we instead fix it the other way around ? IE, make
> memblock_end_of_DRAM() does what the name implies, which is to return
> the last byte of DRAM, and fix the -other- callers not to make bad
> assumptions ?

That was my impression too when I saw this patch.
