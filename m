Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by ozlabs.org (Postfix) with ESMTP id 383A42C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 20:33:41 +1100 (EST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MUC008RWFV70YN0@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 08 Oct 2013 18:33:38 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/legacy_serial: fix incorrect placement of
 __initdata tag
Date: Tue, 08 Oct 2013 11:33:29 +0200
Message-id: <2241214.NPvmYhqHCQ@amdc1032>
In-reply-to: <20131008035623.GA31666@concordia>
References: <35419229.o6Cv8JYbpg@amdc1032> <1600459.LJx7sBeEJs@amdc1032>
 <20131008035623.GA31666@concordia>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, October 08, 2013 02:56:23 PM Michael Ellerman wrote:
> On Thu, Oct 03, 2013 at 01:51:27PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday, October 01, 2013 04:13:25 PM Michael Ellerman wrote:
> > > On Mon, Sep 30, 2013 at 03:11:42PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > __initdata tag should be placed between the variable name and equal
> > > > sign for the variable to be placed in the intended .init.data section.
> > > 
> > > I see lots of other occurences of that in arch/powerpc. Why not send a
> > > single patch to update them all?
> > 
> > The other occurences while not following the preferred kernel coding style
> > are (probably) working OK with gcc. This particular occurence just doesn't
> > work as it should.
> 
> Why would the other occurrences work but not this one?

Because gcc seems to generate the correct code for things like i.e. this one:

struct of_device_id __initdata legacy_serial_parents[]

but not for ones like this:

struct __initdata of_device_id legacy_serial_parents[]

> Regardless, why don't we just do a single patch to clean them all up to
> match coding style and (probably) do what they're intended.

Because:

- fixing this occurence changes runtime, fixing others won't

- there were no such request from powerpc Maintainers

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
