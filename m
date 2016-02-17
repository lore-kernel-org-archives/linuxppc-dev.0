Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B7241A029A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 19:23:50 +1100 (AEDT)
Date: Wed, 17 Feb 2016 19:23:47 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Fix BUG_ON() reporting in real mode on powerpc
Message-ID: <20160217082347.GA19495@fergus.ozlabs.ibm.com>
References: <1455684191.3089.3.camel@gmail.com>
 <20160217045606.GA19276@oak.ozlabs.ibm.com>
 <1455693365.3089.8.camel@gmail.com>
 <56C42954.3000801@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56C42954.3000801@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2016 at 01:33:32PM +0530, Anshuman Khandual wrote:
> On 02/17/2016 12:46 PM, Balbir Singh wrote:
> >> > It might be a little better to do this:
> >> > 
> >> > 		bugaddr = regs->nip;
> >> > 		if (REGION_ID(bugaddr) == 0 && !(regs->msr & MSR_IR))
> >> > 			bugaddr += PAGE_OFFSET;
> >> > 
> >> > It is possible to execute from addresses with the 0xc000... on top in
> >> > real mode, because the CPU ignores the top 4 address bits in real
> >> > mode.
> > Good catch! Thank you
> > 
> > Changelog:
> >      Don't add PAGE_OFFSET blindly, check if REGION_ID is 0
> 
> Cant we use USER_REGION_ID directly ?

If we use USER_REGION_ID then the reader needs to know that the user
region is region 0 to understand the code.  Thus I think it is clearer
to use REGION_ID(bugaddr) == 0.  Whether or not the address is a user
region address is not really relevant to the question of whether it's
a physical address being accessed directly in real mode vs. a kernel
virtual address, which is what we're trying to determine.

Paul.
