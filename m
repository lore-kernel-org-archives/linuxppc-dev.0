Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9DC7A2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 14:27:41 +1100 (EST)
Received: from mail161-ch1 (localhost [127.0.0.1])	by
 mail161-ch1-R.bigfish.com (Postfix) with ESMTP id 0B3CB1C0226	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 03:27:28 +0000 (UTC)
Received: from CH1EHSMHS030.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.250])	by mail161-ch1.bigfish.com (Postfix) with ESMTP id
 C296020004A	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 03:27:25
 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
Date: Tue, 26 Mar 2013 03:27:24 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EBA9F7@039-SN2MPN1-022.039d.mgd.msft.net>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EB854F@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Fri Mar 22 00:46:24 2013)
 <1363990268.24790.11@snotra>
In-Reply-To: <1363990268.24790.11@snotra>
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
> Sent: Saturday, March 23, 2013 6:11 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org;
> Zhao Chenhui-B35336; Li Yang-R58472
> Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
>=20
> On 03/22/2013 12:46:24 AM, Wang Dongsheng-B40534 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Thursday, March 21, 2013 5:49 AM
> > > To: Wang Dongsheng-B40534
> > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > linuxppc-dev@lists.ozlabs.org;
> > > Zhao Chenhui-B35336; Li Yang-R58472
> > > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
> > >
> > > On 03/19/2013 10:48:53 PM, Wang Dongsheng-B40534 wrote:
> > > > 	while (*s) {
> > > > 		if ('0' <=3D *s && *s <=3D '9')
> > > > 			val =3D *s - '0';
> > > > 		else if ('a' <=3D _tolower(*s) && _tolower(*s) <=3D 'f')
> > > > 			val =3D _tolower(*s) - 'a' + 10;
> > > > 		else
> > > > 			break;	//this will break out to convert.
> > >
> > > Really?  How do you know that the next byte after the buffer isn't a
> > > valid hex digit?  How do you even know that we won't take a fault
> > > accessing it?
> > >
> > Under what case is unsafe, please make sense.
>=20
> char buffer[1] =3D { '5' };
> write(fd, &buffer, 1);
>=20
> What comes after that '5' byte in the pointer you pass to kstrtol?
>=20
The buffer is userspace. It will fall in the kernel space.
Kernel will get a free page, and copy the buffer to page.
This page has been cleared before copy to page.
The page has already have null-terminated.

> > "kstrtol" is used in almost of sysfs interface, I think it should be
> > accepted in defaule :).
>=20
> Just because a lot of other people copy blindly doesn't make it right.
> Most of the examples I found use sscanf instead, though that has the same
> problem.
>=20
> I do see a few instances of the "strings from sysfs write are not 0
> terminated!" in the comments, though (kernel/time/clocksource.c and
> kernel/rtmutex-tester.c).
>=20
> Also "words written to sysfs files may, or may not, be \n terminated"
> in drivers/md/md.c.
>=20
It's not "kstrtol" doesn't work as well, They do not belong to this kind
of scenarios.
