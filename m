Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A1608DE0D1
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 07:00:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Disabling L1 D-cache and side effects
Date: Mon, 29 Sep 2008 14:00:06 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C060531D6@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <20080929180455.GA19014@lixom.net>
References: <9323BAFB78DE7C4183466AD03F73EA424D46071D@SDCEXCHANGE01.ad.amcc.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C060530C1@SDCEXCHANGE01.ad.amcc.com>
	<20080929180455.GA19014@lixom.net>
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

 Olof,
  Thanks for the response.

  Is there a piece of code in Linux which does the Machine check
recovery and continue normal execution ?
Thanks and Regards,
Marri

-----Original Message-----
From: Olof Johansson [mailto:olof@lixom.net]=20
Sent: Monday, September 29, 2008 11:05 AM
To: Tirumala Reddy Marri
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Disabling L1 D-cache and side effects

On Mon, Sep 29, 2008 at 10:05:41AM -0700, Tirumala Reddy Marri wrote:
> =20
> Hi,
>   I had to bring up a PPC based SOC with L1 dcache disabled.  I did=20
> that and tried to boot Linux using RAMDISK/NFS mount. In RAMDISK I see

> the file system errors. In case of NFS mount I see error saying failed

> to load ld.so library.
> =20
>  Could you guys please share thoughts what are the different side=20
> effects might be causing this.

There are a number of things you have to be careful about when you
disable caches. Depending on your implementation, you likely can't use
lwarx/stwcx, cache ops will not work, etc. Also, are you 100% sure that
this is caused only by disabling L1D, and not by any other problems with
your silicon?

If you're doing early bringup of you'll have a whole lot of debug work
in front of you, and this mailing list is probably not the best place to
bring your homework.


-Olof
