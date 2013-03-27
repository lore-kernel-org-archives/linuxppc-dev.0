Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB12A2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 09:43:01 +1100 (EST)
Received: from mail212-tx2 (localhost [127.0.0.1])	by
 mail212-tx2-R.bigfish.com (Postfix) with ESMTP id E7FBC9002A7	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 22:42:56 +0000 (UTC)
Received: from TX2EHSMHS013.bigfish.com (unknown [10.9.14.235])	by
 mail212-tx2.bigfish.com (Postfix) with ESMTP id DD122B00049	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 22:42:54 +0000 (UTC)
Date: Wed, 27 Mar 2013 15:25:59 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EBB71C@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Mar 26 22:21:04 2013)
Message-ID: <1364415959.31930.16@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/26/2013 10:21:04 PM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, March 27, 2013 1:36 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Gala Kumar-B11780; =20
> linuxppc-dev@lists.ozlabs.org;
> > Zhao Chenhui-B35336; Li Yang-R58472
> > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
> >
> > On 03/25/2013 10:27:24 PM, Wang Dongsheng-B40534 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Saturday, March 23, 2013 6:11 AM
> > > > To: Wang Dongsheng-B40534
> > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > linuxppc-dev@lists.ozlabs.org;
> > > > Zhao Chenhui-B35336; Li Yang-R58472
> > > > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup =20
> support
> > > >
> > > > On 03/22/2013 12:46:24 AM, Wang Dongsheng-B40534 wrote:
> > > > > Under what case is unsafe, please make sense.
> > > >
> > > > char buffer[1] =3D { '5' };
> > > > write(fd, &buffer, 1);
> > > >
> > > > What comes after that '5' byte in the pointer you pass to =20
> kstrtol?
> > > >
> > > The buffer is userspace. It will fall in the kernel space.
> > > Kernel will get a free page, and copy the buffer to page.
> > > This page has been cleared before copy to page.
> > > The page has already have null-terminated.
> >
> > It doesn't allocate a whole page, it uses kmalloc (not kzalloc!).  =20
> Even
> > if kzalloc were used, a larger user buffer could be the exact size =20
> of the
> > region that was allocated.
> >
> > See memdup_user() in mm/util.c
> >
> Did you miss something?
> See fill_write_buffer() in fs/sysfs/file.c. It's used =20
> get_zeroed_page()...

OK, I was looking at fs/sysfs/bin.c which is something slightly =20
different.

fill_write_buffer() forces the size to be no more than "PAGE_SIZE - 1" =20
so we know there's a terminator.

Perhaps kernel/rtmutex-tester.c and kernel/time/clocksource.c are =20
similarly confused?

-Scott=
