Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32EDB2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 14:10:02 +1100 (EST)
Received: from mail189-ch1 (localhost [127.0.0.1])	by
 mail189-ch1-R.bigfish.com (Postfix) with ESMTP id 856754400B7	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 03:09:56 +0000 (UTC)
Received: from CH1EHSMHS033.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.249])	by mail189-ch1.bigfish.com (Postfix) with ESMTP id
 3AA7C60045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 03:09:55 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
Date: Thu, 28 Mar 2013 03:09:53 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EBC026@039-SN2MPN1-022.039d.mgd.msft.net>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EBB71C@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Mar 26 22:21:04 2013)
 <1364415959.31930.16@snotra>
In-Reply-To: <1364415959.31930.16@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
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



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, March 28, 2013 4:26 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org;
> Zhao Chenhui-B35336; Li Yang-R58472
> Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
>=20
> On 03/26/2013 10:21:04 PM, Wang Dongsheng-B40534 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Wednesday, March 27, 2013 1:36 AM
> > > To: Wang Dongsheng-B40534
> > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > linuxppc-dev@lists.ozlabs.org;
> > > Zhao Chenhui-B35336; Li Yang-R58472
> > > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
> > >
> > > On 03/25/2013 10:27:24 PM, Wang Dongsheng-B40534 wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Wood Scott-B07421
> > > > > Sent: Saturday, March 23, 2013 6:11 AM
> > > > > To: Wang Dongsheng-B40534
> > > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > > linuxppc-dev@lists.ozlabs.org;
> > > > > Zhao Chenhui-B35336; Li Yang-R58472
> > > > > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup
> > support
> > > > >
> > > > > On 03/22/2013 12:46:24 AM, Wang Dongsheng-B40534 wrote:
> > > > > > Under what case is unsafe, please make sense.
> > > > >
> > > > > char buffer[1] =3D { '5' };
> > > > > write(fd, &buffer, 1);
> > > > >
> > > > > What comes after that '5' byte in the pointer you pass to
> > kstrtol?
> > > > >
> > > > The buffer is userspace. It will fall in the kernel space.
> > > > Kernel will get a free page, and copy the buffer to page.
> > > > This page has been cleared before copy to page.
> > > > The page has already have null-terminated.
> > >
> > > It doesn't allocate a whole page, it uses kmalloc (not kzalloc!).
> > Even
> > > if kzalloc were used, a larger user buffer could be the exact size
> > of the
> > > region that was allocated.
> > >
> > > See memdup_user() in mm/util.c
> > >
> > Did you miss something?
> > See fill_write_buffer() in fs/sysfs/file.c. It's used
> > get_zeroed_page()...
>=20
> OK, I was looking at fs/sysfs/bin.c which is something slightly different=
.
>=20
> fill_write_buffer() forces the size to be no more than "PAGE_SIZE - 1"
> so we know there's a terminator.
>=20
> Perhaps kernel/rtmutex-tester.c and kernel/time/clocksource.c are
> similarly confused?
>=20
Yes. But its depends on file->f_op.
See vfs_write in fs/read_write.c.
