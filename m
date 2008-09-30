Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4A3C9DDF0D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 02:57:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Disabling L1 D-cache and side effects
Date: Tue, 30 Sep 2008 09:57:00 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C06053428@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <1222758980.9006.43.camel@pasglop>
References: <9323BAFB78DE7C4183466AD03F73EA424D46071D@SDCEXCHANGE01.ad.amcc.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C060530C1@SDCEXCHANGE01.ad.amcc.com>
	<20080929180455.GA19014@lixom.net>
	<AC5E1C3367E37D44970B81A6ADD1DA2C060531D6@SDCEXCHANGE01.ad.amcc.com>
	<20080929211401.GA22039@lixom.net>
	<AC5E1C3367E37D44970B81A6ADD1DA2C0605320F@SDCEXCHANGE01.ad.amcc.com>
	<1222758980.9006.43.camel@pasglop>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
Ben,
  Thanks for the response. I am wondering how user space would get
affected by absence of L1 Dcache.
Thanks,
Marri

-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
Sent: Tuesday, September 30, 2008 12:16 AM
To: Tirumala Reddy Marri
Cc: Olof Johansson; linuxppc-dev@ozlabs.org
Subject: RE: Disabling L1 D-cache and side effects

On Mon, 2008-09-29 at 14:38 -0700, Tirumala Reddy Marri wrote:
> Could you please point me to the which does the Critical error=20
> (Machine
> Check) recovery. BTW I am successful booting the Linux until rootfs is

> being mounted. It fails to mount the Linux saying that blocks are=20
> corrupted in file system. I had to modify lots of initial bring up=20
> code to disable D-cache and make sure all TLB's are cache inhibited.=20
> Ando also made sure none of the misc_32.S , entry_32.S and head.S=20
> makes any references to d-cache.

Why the heck are you doing that btw ? AFAIK, as Olof says, things like
atomic operations will not work, dcbz neither etc... it's likely that
even if you manage to plaster around all of this in the kernel, whatever
userspace code you'll try to run in userspace will blow up too...

Cheers,
Ben.
