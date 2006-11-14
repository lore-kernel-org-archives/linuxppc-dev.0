Return-Path: <idr@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4647467F04
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 13:18:41 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAE2IaW7005698
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 21:18:36 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAE2IZjK227552
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 21:18:35 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAE2IZHV029626
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 21:18:35 -0500
Message-ID: <455926C0.9080906@us.ibm.com>
Date: Mon, 13 Nov 2006 18:15:28 -0800
From: Ian Romanick <idr@us.ibm.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH/RFC] powerpc: Fix mmap of PCI resource with hack for X
References: <1163405790.4982.289.camel@localhost.localdomain>
	<20061113.163138.98554015.davem@davemloft.net>
In-Reply-To: <20061113.163138.98554015.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	anton@samba.org, airlied@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Mon, 13 Nov 2006 19:16:30 +1100
> 
>> X is still broken when built 32 bits on machines where PCI MMIO can be
>> above 32 bits space unfortunately. It looks like somebody (DaveM ?)
>> hacked a fix in X to handle long long resources and had the good idea
>> to wrap it in #ifdef __sparc__ :-(
> 
> Sorry, it was the only 32/64 platform at the time that old X code was
> written and the X maintainers at the time were unbelievably anal :-/
> 
> So the gist of your change is that X isn't obtaining BAR values
> in the correct context on powerpc, and so you're going to hack up
> the "devices" files output to "help" X out.
> 
> This doesn't sound sane to me.

It doesn't sound terribly sane to me.  What's wrong with just opening
/sys/bus/pci/devices/*/resource[0-5]?  It seems like that solves all the
problems.

> What sounds better to me is that X does the right thing, which is
> obtain the BAR from the PCI config space to determine what values to
> pass in to /proc/bus/pci mmap() calls.  And if it wants raw addresses
> to pass in to /dev/mem mmap()'s on platforms where that works (ie. not
> Sparc, to begin with) it should obtain those values from the "devices"
> file which must be values suitable as /dev/mem offsets.
> 
> I strongly look forward to Ian's new X code, that is for sure :-)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFWSbAX1gOwKyEAw8RAtceAKCc2PrYJNg8v2LcClLwTfEmo1aGzwCfRR7o
TkJnY+7IMpmWUQt/7FAW6A4=
=tDJc
-----END PGP SIGNATURE-----
