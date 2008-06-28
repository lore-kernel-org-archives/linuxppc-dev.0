Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A884DDE98
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 08:31:24 +1000 (EST)
In-Reply-To: <1214483429-32360-20-git-send-email-monstr@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
	<1214483429-32360-4-git-send-email-monstr@seznam.cz>
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
	<1214483429-32360-14-git-send-email-monstr@seznam.cz>
	<1214483429-32360-15-git-send-email-monstr@seznam.cz>
	<1214483429-32360-16-git-send-email-monstr@seznam.cz>
	<1214483429-32360-17-git-send-email-monstr@seznam.cz>
	<1214483429-32360-18-git-send-email-monstr@seznam.cz>
	<1214483429-32! 360-19-git-send-email-monstr@seznam.cz>
	<1214483429-32360-20-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6e8c2b4453be89dba35e0595c9cfcf0a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 19/60] microblaze_v4: checksum support
Date: Sun, 29 Jun 2008 00:28:14 +0200
To: monstr@seznam.cz
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
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
