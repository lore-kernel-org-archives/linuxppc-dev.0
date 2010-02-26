Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id D4B9AB7C98
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 11:53:32 +1100 (EST)
Received: by gyf1 with SMTP id 1so1532858gyf.15
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 16:53:30 -0800 (PST)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <20100225174935.GA32370@oksana.dev.rtsoft.ru>
References: <4B6C2488.3060403@ge.com> <4B865176.7080806@ge.com>
	<4B86A97E.6050509@ge.com> <20100225165141.GA9686@oksana.dev.rtsoft.ru>
	<20100225174935.GA32370@oksana.dev.rtsoft.ru>
Date: Thu, 25 Feb 2010 19:53:30 -0500
Message-ID: <7d1d9c251002251653n6473f01ex2d43933ec6aa010b@mail.gmail.com>
Subject: Re: Gianfar driver failing on MPC8641D based board
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martyn Welch <martyn.welch@ge.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Sandeep Gopalpet <Sandeep.Kumar@freescale.com>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2010 at 12:49 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Feb 25, 2010 at 07:51:41PM +0300, Anton Vorontsov wrote:
>> On Thu, Feb 25, 2010 at 04:46:54PM +0000, Martyn Welch wrote:
>> [...]
>> > > nfs: server 192.168.0.1 not responding, still trying
>> > >
>> >
>> > Further testing has shown that this isn't restricted to warm reboots, it
>> > happens from cold as well. In addition, the exact timing of the failure
>> > seems to vary, some boots have got further before failing.
>>
>> Unfortunately I don't have any 8641 boards near me, so I can't
>> debug this myself. Though, I tested gianfar on MPC8568E-MDS with
>> 2.6.33 kernel, and it seems to work just fine.
>>
>> I see you use SMP. Can you try to turn it off? If that will fix
>> the issue, then it'll be a good data point.
>>
>> Meanwhile, I'll try SMP kernel on MPC8568 (UP), and let you
>> know the results.
>
> Nope, no luck. Can't trigger the issue. :-/
> Tested with NFS boot, TCP and UDP netperf tests.

I was able to reproduce it on an 8641D and bisected it down to this:

-----------
commit a3bc1f11e9b867a4f49505ecac486a33af248b2e
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Tue Nov 10 14:11:10 2009 +0000

    gianfar: Revive SKB recycling

    Before calling gfar_clean_tx_ring() the driver grabs an irqsave
    spinlock, and then tries to recycle skbs. But since
    skb_recycle_check() returns 0 with IRQs disabled, we'll never
    recycle any skbs.

    It appears that gfar_clean_tx_ring() and gfar_start_xmit() are
    mostly idependent and can work in parallel, except when they
    modify num_txbdfree.

    So we can drop the lock from most sections and thus fix the skb
    recycling.
-----------

...which probably explains why you weren't seeing it on non-SMP.
I'd imagine it would show up on any of the e500mc boards too.

I'd done a rev-list on gianfar.[ch] from 32 to 33-rc1, and then
cherry-picked those onto a 32 baseline to reduce the scale of
the bisection, but I don't think that should impact the final
result I got in any meaningful way.

Paul.
