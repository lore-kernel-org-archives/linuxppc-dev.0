Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD9C9DDEBD
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 07:54:05 +1100 (EST)
Message-ID: <45F1C8FF.9040600@zytor.com>
Date: Fri, 09 Mar 2007 12:52:15 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
	David Woodhouse <dwmw2@infradead.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sam@ravnborg.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Complain about missing system calls.
References: <1173394873.3461.510.camel@pmac.infradead.org>
	<p737itqbdnl.fsf@bingen.suse.de>
	<20070309163805.GV18564@lug-owl.de> <45F1B818.4090007@zytor.com>
	<20070309201308.GB8444@flint.arm.linux.org.uk>
In-Reply-To: <20070309201308.GB8444@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Russell King wrote:
> On Fri, Mar 09, 2007 at 11:40:08AM -0800, H. Peter Anvin wrote:
>> Jan-Benedict Glaw wrote:
>>> Not everybody has a simple indexed list of pointers :)  For example,
>>> for vax-linux, we use a struct per syscall with the expected number of
>>> on-stack longwords for the call.
>>>
>>> So if something "new" is coming up, please keep in mind that it should
>>> be flexible enough to represent that. :)
>>>
>> I discussed with Al Viro a while ago about using something like the 
>> SYSCALLS.def file from klibc as the source format for the system calls. 
>>  That would deal very flexibly with almost all kinds of stub generation.
> 
> Hopefully with this idea in place, we can spot new syscalls before
> the final release of the kernel (maybe kautobuild can help there)
> and fix any silly system call argument ordering which requires
> different architectures to have different syscall prototypes (eg,
> sys_arm_fadvise64_64 vs sys_fadvise64_64, sys_arm_sync_file_range vs
> sys_sync_file_range).

That would definitely be nice.

> Otherwise the SYSCALLS.def file will probably end up being full of
> ifdefs.

... which exactly mirrors the pain and suffering which libc maintainers 
have to deal with.  The amount of time I spent per line of code in klibc 
is quite high, in part because I wanted it to be as self-porting as was 
possible.  I've really tried to avoid arch-specific hacks, and yet there 
are more there than there should be, in large part because of unusable 
or missing kernel header exports.

	-hpa
