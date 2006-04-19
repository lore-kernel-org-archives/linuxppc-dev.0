Return-Path: <paul@briny.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id 4A2EC679E2
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 14:31:19 +1000 (EST)
From: Paul Collins <paul@briny.ondioline.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.16 backtrace at boot (Ibook G4) (related to "PowerBook5,
	4 -- no sound?")
References: <Pine.LNX.4.44.0604181714400.12545-100000@zirkon.biophys.uni-duesseldorf.de>
	<1145397523.4705.94.camel@localhost.localdomain>
Date: Wed, 19 Apr 2006 14:25:06 +1000
Message-ID: <87r73u19b1.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "\[ATR\]Dj-Death" <djdeath@gmx.fr>, linuxppc-dev@ozlabs.org,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2006-04-18 at 17:20 +0200, Michael Schmitz wrote:
>> > > Here a trace at boot from the sound driver :
>> >
>> > I think that bug happens if the sound driver loads before i2c-powermac.
>> 
>> i2c-keywest is still request-module()d in 2.6.17-rc1, FWIW.
>> 
>> Regarding other sound breakage with 2.6.17-rc1, I traced that to
>> 
>> machine_is(powermac)
>> 
>> returning zero in sound/ppc/pmac.c:snd_pmac_detect() when loading
>> snd-powermac. The OSS driver spits -ENODEV as well on loading so I'd
>> suspect the same thing here.
>> 
>> machine_is boils down to a comparison machine_id == &mach_powermac, is
>> that sort of thing illegal after kernel init?
>
> Totally untested patch, please let me know if it helps:

Results in the following.

  arch/powerpc/platforms/powermac/setup.c:721: error: 'mach_powermac' undeclared here (not in a function)
  arch/powerpc/platforms/powermac/setup.c:721: warning: type defaults to 'int' in declaration of 'mach_powermac'
  make[2]: *** [arch/powerpc/platforms/powermac/setup.o] Error 1
  make[1]: *** [arch/powerpc/platforms/powermac] Error 2
  make: *** [arch/powerpc/platforms] Error 2

It looks like the EXPORT_SYMBOL() needs to be after the definition.

However, I tried adding "EXPORT_SYMBOL(mach_powermac);" after the
define_machine(powermac) and now sound works for me with my original
I2C_POWERMAC=y SND_POWERMAC=m configuration.

-- 
Dag vijandelijk luchtschip de huismeester is dood
