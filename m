Return-Path: <Monstr@seznam.cz>
Received: from mxl.seznam.cz (mxl.seznam.cz [77.75.72.44])
	by ozlabs.org (Postfix) with ESMTP id 594F3DDEDA
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 17:36:14 +1000 (EST)
In-Reply-To: <6e8c2b4453be89dba35e0595c9cfcf0a@kernel.crashing.org>
Date: Mon, 30 Jun 2008 09:18:10 +0200 (CEST)
To: =?us-ascii?Q?Segher=20Boessenkool?= <segher@kernel.crashing.org>
From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20=5BPATCH=2019=2F60=5D=20microblaze=5Fv4=3A=20checksum=20support?=
Mime-Version: 1.0
Message-Id: <4117.6640-711-1819091302-1214810290@seznam.cz>
Content-Type: text/plain;
	charset="us-ascii";
	format=flowed
Cc: linux-arch@vger.kernel.org,
	=?us-ascii?Q?Michal=20Simek?= <monstr@monstr.eu>,
	vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com, linuxppc-dev@ozlabs.org,
	alan@lxorguk.ukuu.org.uk, hpa@zytor.com, drepper@redhat.com,
	john.williams@petalogix.com, will.newton@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Segher,

you find bug because there is microblaze asm code in generic folder. 
Big thanks. I'll fix it and I'll look at parameters too.

Michal

> +static inline unsigned int
> +csum_tcpudp_nofold(unsigned long saddr, unsigned long daddr, unsigned 
> short len,
> +		unsigned short proto, unsigned int sum)
> +{
> +	__asm__("add %0, %4, %1\n\t"
> +		"addc %0, %4, %2\n\t"
> +		"addc %0, %4, %3\n\t"
> +		"addc %0, %4, r0\n\t"
> +		: "=d" (sum)
> +		: "d" (saddr), "d" (daddr), "d" (len + proto),
> +		"0"(sum));

"sum" should use an earlyclobber, i.e.  "=&d"(sum)  , since some
inputs are used after %0 is first written to.

Also, you can use "+" instead of "=" to say the argument is both
input and output, and get rid of %4, if you like.


Segher
