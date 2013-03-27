Return-Path: <B40534@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B5FA2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 14:21:25 +1100 (EST)
Received: from mail142-tx2 (localhost [127.0.0.1])	by
 mail142-tx2-R.bigfish.com (Postfix) with ESMTP id A90022400CD	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 03:21:16 +0000 (UTC)
Received: from TX2EHSMHS020.bigfish.com (unknown [10.9.14.247])	by
 mail142-tx2.bigfish.com (Postfix) with ESMTP id 0EF28440051	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 03:21:09 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
Date: Wed, 27 Mar 2013 03:21:04 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EBB71C@039-SN2MPN1-022.039d.mgd.msft.net>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EB854F@039-SN2MPN1-022.039d.mgd.msft.net>
 <1363990268.24790.11@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EBA9F7@039-SN2MPN1-022.039d.mgd.msft.net>
 <1364319342.469.7@snotra>
In-Reply-To: <1364319342.469.7@snotra>
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
> Sent: Wednesday, March 27, 2013 1:36 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org;
> Zhao Chenhui-B35336; Li Yang-R58472
> Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
>=20
> On 03/25/2013 10:27:24 PM, Wang Dongsheng-B40534 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Saturday, March 23, 2013 6:11 AM
> > > To: Wang Dongsheng-B40534
> > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > linuxppc-dev@lists.ozlabs.org;
> > > Zhao Chenhui-B35336; Li Yang-R58472
> > > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
> > >
> > > On 03/22/2013 12:46:24 AM, Wang Dongsheng-B40534 wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Wood Scott-B07421
> > > > > Sent: Thursday, March 21, 2013 5:49 AM
> > > > > To: Wang Dongsheng-B40534
> > > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > > linuxppc-dev@lists.ozlabs.org;
> > > > > Zhao Chenhui-B35336; Li Yang-R58472
> > > > > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup
> > support
> > > > >
> > > > > On 03/19/2013 10:48:53 PM, Wang Dongsheng-B40534 wrote:
> > > > > > 	while (*s) {
> > > > > > 		if ('0' <=3D *s && *s <=3D '9')
> > > > > > 			val =3D *s - '0';
> > > > > > 		else if ('a' <=3D _tolower(*s) && _tolower(*s) <=3D
> > 'f')
> > > > > > 			val =3D _tolower(*s) - 'a' + 10;
> > > > > > 		else
> > > > > > 			break;	//this will break out to
> > convert.
> > > > >
> > > > > Really?  How do you know that the next byte after the buffer
> > isn't a
> > > > > valid hex digit?  How do you even know that we won't take a
> > fault
> > > > > accessing it?
> > > > >
> > > > Under what case is unsafe, please make sense.
> > >
> > > char buffer[1] =3D { '5' };
> > > write(fd, &buffer, 1);
> > >
> > > What comes after that '5' byte in the pointer you pass to kstrtol?
> > >
> > The buffer is userspace. It will fall in the kernel space.
> > Kernel will get a free page, and copy the buffer to page.
> > This page has been cleared before copy to page.
> > The page has already have null-terminated.
>=20
> It doesn't allocate a whole page, it uses kmalloc (not kzalloc!).  Even
> if kzalloc were used, a larger user buffer could be the exact size of the
> region that was allocated.
>=20
> See memdup_user() in mm/util.c
>=20
Did you miss something?

See fill_write_buffer() in fs/sysfs/file.c. It's used get_zeroed_page()...

See SYSCALL_DEFINE3(write,...) in fs/read_write.c

[c0000000f1ff3a60] [c000000000008224] .show_stack+0x74/0x1b0 (unreliable)
[c0000000f1ff3b10] [c00000000002f370] .fsl_timer_wakeup_store+0x30/0x200
[c0000000f1ff3bc0] [c00000000030accc] .dev_attr_store+0x3c/0x50
[c0000000f1ff3c30] [c00000000018c47c] .sysfs_write_file+0xec/0x1f0
[c0000000f1ff3ce0] [c00000000010dfb4] .vfs_write+0xf4/0x1b0
[c0000000f1ff3d80] [c00000000010e360] .SyS_write+0x60/0xe0
[c0000000f1ff3e30] [c000000000000590] syscall_exit+0x0/0x80
