Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id C6124DDFDC
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 01:25:51 +1000 (EST)
In-Reply-To: <20071010164336.GA21507@lixom.net>
References: <20071010003824.GA8477@lixom.net>
	<200710101008.l9AA8hIG084068@sullivan.realtime.net>
	<20071010164336.GA21507@lixom.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c3f800aec25dff34b59b8b496eee3f3b@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH v2] powerpc: don't enable cpu hotplug on mpic-based pseries
Date: Thu, 11 Oct 2007 10:25:56 -0500
To: Olof Johansson <olof@lixom.net>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Oct 10, 2007, at 11:43 AM, Olof Johansson wrote:
> On Wed, Oct 10, 2007 at 05:08:44AM -0500, Milton Miller wrote:
>> Olof's patch searched the device-tree again, looking for an mpic.   
>> This
>> code instead checks that we found an xics the first time by checking 
>> the
>> init function.
>
> I'm glad you find the kernel so perfect that your best use of time is
> to tweak the code added in a non-critical path (performance-wise) with
> a new way of checking for hardware features (no other code in the 
> kernel
> checks ppc_md function pointers for that purpose).

I never argued performance, I posted because !mpic != !!xics.  The 
tweak of not searching again was about avoiding code duplication.  I 
considered moving the call from an init function to an explicit call 
when we find it like the smp and kexec hooks are handled.   It would 
reorder the notifier registration (from arch_initcall to setup_arch) 
which would require additional testing.

> Pseries can only have mpic or xics, so it's not like it matters if we
> check for mpic or !xics, either.

Actually, in my work with simulators, sometimes I use neither, so the 
check is not equivalent.  We recently changed the call to 
ppc_md.init_IRQ to allow this.

> But hey, any color bike shed will do, and I don't care which one Paul
> chooses to merge. I will not waste more time debating this simple patch
> though. :)
>
> -Olof

milton
