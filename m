Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 73BE2DDE28
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 07:38:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Disabling L1 D-cache and side effects
Date: Mon, 29 Sep 2008 14:38:49 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C0605320F@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <20080929211401.GA22039@lixom.net>
References: <9323BAFB78DE7C4183466AD03F73EA424D46071D@SDCEXCHANGE01.ad.amcc.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C060530C1@SDCEXCHANGE01.ad.amcc.com>
	<20080929180455.GA19014@lixom.net>
	<AC5E1C3367E37D44970B81A6ADD1DA2C060531D6@SDCEXCHANGE01.ad.amcc.com>
	<20080929211401.GA22039@lixom.net>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Olof Johansson" <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Hi Olof,
   I see code in arch/powerpc/kernel/traps.c . But only
cbe_machine_check_handler() is the only function assigned to
ppc_md.machine_check_exception. Which is also not doing any recovery. It
just dumps the registers and return 0. Which would cause system Panic.


Could you please point me to the which does the Critical error (Machine
Check) recovery. BTW I am successful booting the Linux until rootfs is
being mounted. It fails to mount the Linux saying that blocks are
corrupted in file system. I had to modify lots of initial bring up code
to disable D-cache and make sure all TLB's are cache inhibited. Ando
also made sure none of the misc_32.S , entry_32.S and head.S makes any
references to d-cache.


Thanks,
Marri

-----Original Message-----
From: Olof Johansson [mailto:olof@lixom.net]=20
Sent: Monday, September 29, 2008 2:14 PM
To: Tirumala Reddy Marri
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Disabling L1 D-cache and side effects

On Mon, Sep 29, 2008 at 02:00:06PM -0700, Tirumala Reddy Marri wrote:
>  Olof,
>   Thanks for the response.
>=20
>   Is there a piece of code in Linux which does the Machine check=20
> recovery and continue normal execution ?

Yes, there is. Several pieces, actually.


-Olof
