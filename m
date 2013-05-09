Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 9D9E62C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 23:30:05 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 24981-06 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  9 May 2013 14:29:57 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
Date: Thu, 9 May 2013 14:28:13 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B722F@saturn3.aculab.com>
In-Reply-To: <1368103062.25488.193.camel@pasglop>
References: <51885F49.6060605@windriver.com> (from tiejun.chen@windriver.com
 on Mon May 6 20:56:25 2013) <1367892390.3398.12@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E64A@039-SN2MPN1-011.039d.mgd.msft.net>
 <518B7014.1090508@windriver.com> <1368103062.25488.193.camel@pasglop>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>
Cc: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>, kvm@vger.kernel.org,
 Wood Scott-B07421 <B07421@freescale.com>, agraf@suse.de,
 kvm-ppc@vger.kernel.org, Bhushan Bharat-R65777 <R65777@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Some MPIC implementations tend to generate a spurrious IRQ in the case
> of level IRQs going away. IE. they still remember an event occurred =
and
> interrupt the processor, but on IACK return the spurious vector. =
However
> that isn't guaranteed to be the case and it is perfectly ok (and a =
good
> idea) for the PIC to just stop asserting the external interrupt line =
if
> the original device interrupt goes away (and it's configured as level
> sensitive).

That will happen if the IRQ goes away while the cpu is performing
the IACK sequence.
If the IRQ goes away while the cpu has interrupts masked then
the cpu won't start the interrupt sequence and then try to
read a vector when no interrupt is pending.

	David
