Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65A2D1A033E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 00:02:44 +1100 (AEDT)
Message-ID: <1427202157.1125.0.camel@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc/tm: Abort syscalls in active transactions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 25 Mar 2015 00:02:37 +1100
In-Reply-To: <5510E77F.1020903@linux.vnet.ibm.com>
References: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
 <6ebcb9f982f7cb100aef954cd7dc6a6081cd9134.1426740212.git.sam.bobroff@au1.ibm.com>
 <550BE2AB.2050604@linux.vnet.ibm.com>
 <1427162659.28572.3.camel@ellerman.id.au>
 <5510E77F.1020903@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Sam Bobroff <sam.bobroff@au1.ibm.com>,
 matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-24 at 09:56 +0530, Anshuman Khandual wrote:
> On 03/24/2015 07:34 AM, Michael Ellerman wrote:
> > On Fri, 2015-03-20 at 14:34 +0530, Anshuman Khandual wrote:
> >> On 03/19/2015 10:13 AM, Sam Bobroff wrote:
> >>> This patch changes the syscall handler to doom (tabort) active
> >>> transactions when a syscall is made and return immediately without
> >>> performing the syscall.
> >>>
> >>> Currently, the system call instruction automatically suspends an
> >>> active transaction which causes side effects to persist when an active
> >>> transaction fails.
> >>>
> >>> This does change the kernel's behaviour, but in a way that was
> >>> documented as unsupported. It doesn't reduce functionality because
> >>> syscalls will still be performed after tsuspend. It also provides a
> >>> consistent interface and makes the behaviour of user code
> >>> substantially the same across powerpc and platforms that do not
> >>> support suspended transactions (e.g. x86 and s390).
> >>>
> >>> Performance measurements using
> >>> http://ozlabs.org/~anton/junkcode/null_syscall.c
> >>> indicate the cost of a system call increases by about 0.5%.
> >>
> >> Performance test results verified which shows an improvement of
> >> around ~0.52% with the patch compared to without it.
> >>
> >> [With patch]		null_syscall:     757.59 cycles     100.00%
> >> [Without patch]]	null_syscall:     753.66 cycles     100.00%
> > 
> > No that's a performance *decrease* with the patch applied. ?
> 
> Micheal, thats true. The cycle counts are more with patch being applied.
> Here are some more results on mainline.

Right, more cycles == worse :)

But it's not much more so we'll merge it.

cheers
