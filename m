Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 47E581A0393
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 09:51:46 +1100 (AEDT)
Date: Thu, 26 Mar 2015 16:00:20 -0700 (PDT)
Message-Id: <20150326.160020.1865957868633778207.davem@davemloft.net>
Subject: Re: Generic IOMMU pooled allocator
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150326004342.GB4925@oc0812247204.ltc.br.ibm.com>
References: <1427162890.4770.307.camel@kernel.crashing.org>
 <20150323.221508.1178754097347144400.davem@davemloft.net>
 <20150326004342.GB4925@oc0812247204.ltc.br.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org,
 sowmini.varadhan@oracle.com, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: cascardo@linux.vnet.ibm.com
Date: Wed, 25 Mar 2015 21:43:42 -0300

> On Mon, Mar 23, 2015 at 10:15:08PM -0400, David Miller wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Date: Tue, 24 Mar 2015 13:08:10 +1100
>> 
>> > For the large pool, we don't keep a hint so we don't know it's
>> > wrapped, in fact we purposefully don't use a hint to limit
>> > fragmentation on it, but then, it should be used rarely enough that
>> > flushing always is, I suspect, a good option.
>> 
>> I can't think of any use case where the largepool would be hit a lot
>> at all.
> 
> Well, until recently, IOMMU_PAGE_SIZE was 4KiB on Power, so every time a
> driver mapped a whole 64KiB page, it would hit the largepool.

We don't plan to ever use 64KB page size on sparc64, so I think we're
safe there.

There are many reasons using 64KB pages is really stupid, what you
see here with the IOMMU stuff is just one of many symptoms, but I bet
your powerpc guys are kind of sick of hearing it by now... :-)
