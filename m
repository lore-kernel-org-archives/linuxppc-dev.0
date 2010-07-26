Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "AAA Certificate Services" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36A8CB70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Jul 2010 21:14:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Timestamp in PowerPC 440
Date: Mon, 26 Jul 2010 12:02:59 +0100
Message-ID: <929D3CED81F34E43887A393170D66FB90301BAC1@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <BAY152-w35F374705FF06792DCEED3BCA60@phx.gbl>
References: <BAY152-w35F374705FF06792DCEED3BCA60@phx.gbl>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "kostas padarnitsas" <kpada84@hotmail.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I have ported Linux 2.6 to PowerPC 440. Could you tell me
> how it is possible to access the timebase register (TBU, TBL)
> from user space (in Linux) because I want to measure the time
> of an application that runs in Linux?

I just grabbed this code from the kernel (you can put the macro
expansions into the function if you like):

typedef unsigned long long u64;

#define mftbl() ({unsigned long rval; \
 asm volatile("mftbl %0" : "=3Dr" (rval)); rval;})
#define mftbu() ({unsigned long rval; \
 asm volatile("mftbu %0" : "=3Dr" (rval)); rval;})

static inline u64 get_tb(void)
{
	unsigned int tbhi, tblo, tbhi2;
	do {
		tbhi =3D get_tbu();
		tblo =3D get_tbl();
		tbhi2 =3D get_tbu();
	} while (tbhi !=3D tbhi2);
	return ((u64)tbhi << 32) | tblo;
}

The timebase frequency is available in text form from
/proc/cpuinfo and in binary (as a 4-byte bigendian
integer)from /proc/device-tree/...

grep timebase /proc/cpuinfo

find /proc/device-tree -name timebase-frequency -print \
 -exec od -td -An '{}' \;

Clive
