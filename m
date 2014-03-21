Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E8A52C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Mar 2014 08:16:45 +1100 (EST)
Message-ID: <1395436593.12479.379.camel@snotra.buserror.net>
Subject: Re: [PATCH 9/9] powerpc/pm: support deep sleep feature on T1040
From: Scott Wood <scottwood@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 21 Mar 2014 16:16:33 -0500
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6E40C4@AcuExch.aculab.com>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-9-git-send-email-chenhui.zhao@freescale.com>
 <1394586624.13761.132.camel@snotra.buserror.net>
 <20140312055755.GA17203@pek-khao-d1.corp.ad.wrs.com>
 <1394646185.13761.145.camel@snotra.buserror.net>
 <20140313074613.GD26692@pek-khao-d1.corp.ad.wrs.com>
 <1394835987.12479.119.camel@snotra.buserror.net>
 <20140316045801.GA32188@pek-khao-d1.corp.ad.wrs.com>
 <1395184734.12479.250.camel@snotra.buserror.net>
 <20140320114735.GD10182@pek-khao-d1.corp.ad.wrs.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F6E33AE@AcuExch.aculab.com>
 <1395353279.12479.335.camel@snotra.buserror.net>
 <063D6719AE5E284EB5DD2968C1650D6D0F6E40C4@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 'Kevin Hao' <haokexin@gmail.com>, Chenhui Zhao <chenhui.zhao@freescale.com>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-03-21 at 09:21 +0000, David Laight wrote:
> From: Scott Wood [mailto:scottwood@freescale.com]
> > On Thu, 2014-03-20 at 11:59 +0000, David Laight wrote:
> > > I tried to work out what the 'twi, isync' instructions were for (in in_le32()).
> > > The best I could come up with was to ensure a synchronous bus-fault.
> > > But bus faults are probably only expected during device probing - not
> > > normal operation, and the instructions will have a significant cost.
> > >
> > > Additionally in_le32() and out_le32() both start with a 'sync' instruction.
> > > In many cases that isn't needed either - an explicit iosync() can be
> > > used after groups of instructions.
> > 
> > The idea is that it's better to be maximally safe by default, and let
> > performance critical sections be optimized using raw accessors and
> > explicit synchronization if needed, than to have hard-to-debug bugs due
> > to missing/wrong sync.  A lot of I/O is slow enough that the performance
> > impact doesn't really matter, but the brain-time cost of getting the
> > sync right is still there.
> 
> Hmmm....
> 
> That might be an excuse for the 'sync', but not the twi and isync.

That might be true if I/O is always cache inhibited and guarded, in
which case I think we can rely on that to ensure that the load has
completed before we do things like wrtee or rfi.  In any case, I'd want
to hear Ben's explanation.

> I was setting up a dma request (for the ppc 83xx PCIe bridge) and
> was doing back to back little-endian writes into memory.
> I had difficulty finding and including header files containing
> the definitions for byteswapped accesses I needed.
> arch/powerpc/include/asm/swab.h contains some - but I couldn't
> work out how to get it included (apart from giving the full path).
> 
> In any case you need to understand when synchronisation is
> required - otherwise you will get it wrong.
> Especially since non-byteswapped accesses are done by direct
> access.

Yes, it's bad that rawness combines the lack of byteswapping with the
lack of synchronization.  Ideally the raw accessors would also come in
big and little endian form, plus a native endian form if it's really
needed.

-Scott
