Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E500DDF3B
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 04:04:08 +1000 (EST)
Message-ID: <4863D87F.5060103@zytor.com>
Date: Thu, 26 Jun 2008 10:57:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or
	redirect to asm-generic
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<200806261735.12738.arnd@arndb.de>
	<20080626162118.GG22025@cs181140183.pp.htv.fi>
	<200806261838.33787.arnd@arndb.de>
In-Reply-To: <200806261838.33787.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Adrian Bunk <bunk@kernel.org>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com,
	Michal Simek <monstr@monstr.eu>, monstr@seznam.cz,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Thursday 26 June 2008, Adrian Bunk wrote:
>> The comment could be nuked (as well as the #ifdef __KERNEL__), but for 
>> the one #define an asm-generic header would IMHO be overkill.
> 
> I agree that it doesn't technically make sense to have a one-line
> asm-generic header, but I like the idea of reducing the number of
> asm/*.h files that actually contain anything other that
> #include <asm-generic/$FILE.h>, mostly for documentation purposes.
> 
> If we can eventually agree on a way to get rid of the requirement
> for explicit redirection, we can remove a larger number of source
> files completely.
> 

The sanest way to do that would probably be something along the lines of:

-> Change include/asm-xxx to arch/xxx/include/asm
-> Create arch/generic
-> Make sure arch/xxx/include/asm and arch/generic/include/asm are both 
in the include path, in that order.

That would also get rid of the symlink.

On the other hand, the redirection isn't all that bad.

	-hpa
