Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 627C667A6B
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 10:03:08 +1000 (EST)
Message-ID: <4251D5BA.5080905@gmx.net>
Date: Tue, 05 Apr 2005 02:03:06 +0200
From: Christian <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <20050328232355.GA1982@pegasos>	<20050331142813.GH25923@smtp.west.cox.net>
	<20050331184549.GA28069@pegasos>
In-Reply-To: <20050331184549.GA28069@pegasos>
Content-Type: text/plain; charset=UTF-8
Cc: Tom Rini <trini@kernel.crashing.org>
Subject: Re: PREP sym53c8xx sym53c8xx brokeness due to
 2.6.9-rc1-bk1	introduced residual data patch ...
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

Sven Luther wrote:
>>># This is a BitKeeper generated diff -Nru style patch.
>>>#
>>># ChangeSet
>>>#   2004/08/16 10:35:18-07:00 trini@kernel.crashing.org
>>>#   ppc32: On PReP, use residual data for PCI dev -> IRQ, and use it.
>
> I got through all the changesets one by one, and it is most definitively this
> one. i unapply it and it works, i apply it and it breaks.

i can confirm this one.

the changesets are listed here:
http://linux.bkbits.net:8080/linux-2.6/patch@1.1803.125.6

...and because i had some troubles getting a GNU diff-style patch with
/usr/bin/bk, i made one against 2.6.11.6:

http://nerdbynature.de/bits/hal/2.6.11.6/1.1803.125.6.diff

more info and dmesg under:

http://nerdbynature.de/bits/hal/2.6.11.6/

to summarize: i don't know exactly which changes, but *some* changes had
to be made to arch/ppc/platforms/prep_pci.c to get the network card
working [1] again (network code kept locking up the machine). after this
issue was resolved, i too noticed the scsi errors [2] others were
complaing about.

thanks to all involved,
Christian.


[1] http://ozlabs.org/pipermail/linuxppc-dev/2004-December/017954.html
[2] http://nerdbynature.de/bits/hal/2.6.11-rc5/dmesg
- --
BOFH excuse #307:

emissions from GSM-phones
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCUdW5C/PVm5+NVoYRAnBFAKDWoLrgNglNCIuVNLMZcJXccp7K6QCfSyIp
i4H8VpqUw3e7WiyqpsqYs54=
=WD3X
-----END PGP SIGNATURE-----
