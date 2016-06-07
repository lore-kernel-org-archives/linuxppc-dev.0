Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rP8jW0h1JzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 21:39:11 +1000 (AEST)
Message-ID: <1465299544.16285.3.camel@ellerman.id.au>
Subject: Re: powerpc/nvram: Fix an incorrect partition merge
From: Michael Ellerman <mpe@ellerman.id.au>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Christophe Jaillet
 <christophe.jaillet@wanadoo.fr>, Hari Bathini
 <hbathini@linux.vnet.ibm.com>,  Paul Mackerras <paulus@samba.org>,
 tglx@linutronix.de, Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 07 Jun 2016 21:39:04 +1000
In-Reply-To: <57550AB2.8090500@linux.vnet.ibm.com>
References: <3rLj4P6Swcz9t6B@ozlabs.org> <57550AB2.8090500@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-06 at 13:31 +0800, xinhui wrote:
> On 2016年06月03日 19:47, Michael Ellerman wrote:
> > On Thu, 2015-10-12 at 07:30:02 UTC, xinhui wrote:
> > > From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> > > 
> > > When we merge two contiguous partitions whose signatures are marked
> > > NVRAM_SIG_FREE, We need update prev's length and checksum, then write it
> > > to nvram, not cur's. So lets fix this mistake now.
> > > 
> > > Also use memset instead of strncpy to set the partition's name. It's
> > > more readable if we want to fill up with duplicate chars .
> > 
> > Does this ever happen in practice? ie. should we backport the fix to stable
> > kernels?
> 
> I did not see that nvram warning in practice. BUT I suggest to backport it to stable kernel. :)
> 
> Let me recall the story. :)
> In past days, I was using pstore to keep some kernel logs. and sometimes I found my own logs and the panic logs did not show.
> pstore use a fixed-address reserved memory In x86 while nvram instead in ppc.
> 
> Then I spent some days to review the nvram codes.
> And worked out three patches to fix all issues that I found in nvram. BUT looks like I only sent out two of them. :)
> I lost the third patch maybe...

OK.

> > Has it always been broken?
> 
> no. after nvram partition corruption hit, all nvram partitions will be erased and re-alloc after the second machine reboot.
> I don't know who does it but i guess it is the firmware. :)

Actually I meant has the code always contained the bug, or was it added recently.

cheers
