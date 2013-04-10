Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5BE9A2C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 15:30:02 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 10 Apr 2013 15:21:00 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6A271357804A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 15:29:56 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3A5TLxi52035764
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 15:29:21 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3A5TPYJ009471
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 15:29:26 +1000
Message-ID: <1365571759.10616.11.camel@ThinkPad-T5421>
Subject: Re: [RFC PATCH powerpc] try secondary hash before BUG in
 kernel_map_linear_page()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 10 Apr 2013 13:29:19 +0800
In-Reply-To: <20130410022107.GA15929@concordia>
References: <1361784575.3001.5.camel@ThinkPad-T5421.cn.ibm.com>
 <20130410022107.GA15929@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-04-10 at 12:21 +1000, Michael Ellerman wrote:
> On Mon, Feb 25, 2013 at 05:29:35PM +0800, Li Zhong wrote:
> > This patch tries to fix following issue when CONFIG_DEBUG_PAGEALLOC
> > is enabled:
> > 
> > [  543.075675] ------------[ cut here ]------------
> > [  543.075701] kernel BUG at arch/powerpc/mm/hash_utils_64.c:1239!
> > [  543.075714] Oops: Exception in kernel mode, sig: 5 [#1]

Hi Michael, 

Thanks for the review.

> So the issue is that kernel_map_linear_page() doesn't try the secondary
> hash slot.

It seems so.

> > The code is borrowed from that in __hash_page_huge().
> 
> It is, and in fact there is another copy in hash_low_64.S - in assembler.
> 
> So I think we should at least try and keep ourselves to two
> implementations, one in asm and one in C. So can you split it out into a
> helper routine called by both kernel_map_linear_page() and
> __hash_page_huge() ?

OK, I'll try to update it as you suggested. 

Thanks, Zhong

> cheers
> 
