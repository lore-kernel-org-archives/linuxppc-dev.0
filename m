Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 95A1C2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 09:11:45 +1100 (EST)
Received: from mail15-db3 (localhost [127.0.0.1])	by mail15-db3-R.bigfish.com
 (Postfix) with ESMTP id 0B2394800DA	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 22 Mar 2013 22:11:39 +0000 (UTC)
Received: from DB3EHSMHS007.bigfish.com (unknown [10.3.81.227])	by
 mail15-db3.bigfish.com (Postfix) with ESMTP id 616882E004B	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 22:11:36 +0000 (UTC)
Date: Fri, 22 Mar 2013 17:11:08 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EB854F@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Fri Mar 22 00:46:24 2013)
Message-ID: <1363990268.24790.11@snotra>
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

On 03/22/2013 12:46:24 AM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, March 21, 2013 5:49 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Gala Kumar-B11780; =20
> linuxppc-dev@lists.ozlabs.org;
> > Zhao Chenhui-B35336; Li Yang-R58472
> > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
> >
> > On 03/19/2013 10:48:53 PM, Wang Dongsheng-B40534 wrote:
> > > 	while (*s) {
> > > 		if ('0' <=3D *s && *s <=3D '9')
> > > 			val =3D *s - '0';
> > > 		else if ('a' <=3D _tolower(*s) && _tolower(*s) <=3D 'f')
> > > 			val =3D _tolower(*s) - 'a' + 10;
> > > 		else
> > > 			break;	//this will break out to convert.
> >
> > Really?  How do you know that the next byte after the buffer isn't a
> > valid hex digit?  How do you even know that we won't take a fault
> > accessing it?
> >
> Under what case is unsafe, please make sense.

char buffer[1] =3D { '5' };
write(fd, &buffer, 1);

What comes after that '5' byte in the pointer you pass to kstrtol?

> "kstrtol" is used in almost of sysfs interface, I think it should be =20
> accepted in defaule :).

Just because a lot of other people copy blindly doesn't make it right.  =20
Most of the examples I found use sscanf instead, though that has the =20
same problem.

I do see a few instances of the "strings from sysfs write are not 0 =20
terminated!" in the comments, though (kernel/time/clocksource.c and =20
kernel/rtmutex-tester.c).

Also "words written to sysfs files may, or may not, be \n terminated" =20
in drivers/md/md.c.

-Scott=
