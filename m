Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id E4D211A0D66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 06:10:34 +1100 (AEDT)
Date: Thu, 19 Feb 2015 14:10:28 -0500 (EST)
Message-Id: <20150219.141028.571019196212537944.davem@davemloft.net>
To: joseph@codesourcery.com
Subject: Re: [PATCH RFC] Update kernel math-emu code from current glibc soft-fp
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.DEB.2.10.1502191835490.22905@digraph.polyomino.org.uk>
References: <alpine.DEB.2.10.1502061719210.27832@digraph.polyomino.org.uk>
 <20150219.132122.204795202277130266.davem@davemloft.net>
 <alpine.DEB.2.10.1502191835490.22905@digraph.polyomino.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kkojima@rr.iij4u.or.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joseph Myers <joseph@codesourcery.com>
Date: Thu, 19 Feb 2015 18:40:34 +0000

> On Thu, 19 Feb 2015, David Miller wrote:
> 
>> From: Joseph Myers <joseph@codesourcery.com>
>> Date: Fri, 6 Feb 2015 17:25:29 +0000
>> 
>> > * On SPARC, comparisons now use raw unpacking (this should not in fact
>> >   change how the emulation behaves, just make it more efficient).
>> 
>> I did a sparc64 test build and it failed like so:
 ...
> Please try this patch on top of the previous one.  The way abort is 
> redefined in the kernel code doesn't work for one place using it in an 
> expression; this patch changes a comma expression to a statement 
> expression.  This didn't appear in my powerpc testing because the powerpc 
> emulation never uses FP_FROM_INT; I'm not sure how Kaz's sh testing 
> avoided the problem appearing there.
> 
> diff --git a/include/math-emu/op-common.h b/include/math-emu/op-common.h
> index b9f5e1a..8c059c3 100644
> --- a/include/math-emu/op-common.h
> +++ b/include/math-emu/op-common.h

That fixes the build for 64-bit sparc, thanks Joseph.

I'll try to do some functional testing now.
