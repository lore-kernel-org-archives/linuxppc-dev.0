Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 890CA2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 15:12:25 +1100 (EST)
Subject: Re: [PATCH] [RFC] Emulate "lwsync" to run standard user land on e500
 cores
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <alpine.LRH.2.00.1310241556390.31001@ra8135-ec1.am.freescale.net>
Date: Thu, 24 Oct 2013 23:12:30 -0500
Message-Id: <26976A96-8DF8-44EB-8B9B-E23200738F4E@kernel.crashing.org>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
 <1382523314.3926.21.camel@aoeu.buserror.net>
 <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
 <1382607919.9395.56.camel@pasglop>
 <6BFC8EB0-1A75-41C3-985A-E3ED14846710@kernel.crashing.org>
 <alpine.LRH.2.00.1310241556390.31001@ra8135-ec1.am.freescale.net>
To: James Yang <James.Yang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 24, 2013, at 4:05 PM, James Yang wrote:

> On Thu, 24 Oct 2013, Kumar Gala wrote:
>=20
>> On Oct 24, 2013, at 4:45 AM, Benjamin Herrenschmidt wrote:
>>=20
>>> On Wed, 2013-10-23 at 23:06 -0500, Kumar Gala wrote:
>>>> On Oct 23, 2013, at 5:15 AM, Scott Wood wrote:
>>>>=20
>>>>> On Wed, 2013-10-23 at 00:07 -0500, Kumar Gala wrote:
>>>>>> On Oct 18, 2013, at 2:38 AM, Wolfgang Denk wrote:
>>>>>>> diff --git a/arch/powerpc/kernel/traps.c =
b/arch/powerpc/kernel/traps.c
>>>>>>> index f783c93..f330374 100644
>>>>>>> --- a/arch/powerpc/kernel/traps.c
>>>>>>> +++ b/arch/powerpc/kernel/traps.c
>>>>>>> @@ -986,6 +986,13 @@ static int emulate_instruction(struct =
pt_regs *regs)
>>>>>>> 		return 0;
>>>>>>> 	}
>>>>>>>=20
>>>>>>> +	/* Emulating the lwsync insn as a sync insn */
>>>>>>> +	if (instword =3D=3D PPC_INST_LWSYNC) {
>>>>>>> +		PPC_WARN_EMULATED(lwsync, regs);
>>>>>>> +		asm volatile("sync" : : : "memory");
>>>>>>=20
>>>>>> Do we really need the inline asm?  Doesn't the fact of just =
taking an exception and returning from it equate to a sync.
>>>>>=20
>>>>> No, it doesn't equate to a sync.  See the discussion here:
>>>>> http://patchwork.ozlabs.org/patch/256747/
>>>>>=20
>>>>=20
>>>> Thanks.=20
>>>>=20
>>>> I'm not sure I'm a fan of doing this as it silently hides a=20
>>>> significant performance impact.
>>>>=20
>>>> Could we possible re-write the userspace instruction to be a=20
>>>> 'sync' when we hit this?
>>>=20
>>> Rewriting user space is a can of worms I wouldn't get into ... is=20
>>> any other arch doing it ?
>>=20
>> Fair enough
>>>=20
>>> I'm not too worried as long as we warn and account them.
>>=20
>> Than, I'd ask this be under a Kconfig option that is disabled by=20
>> default.  Users should have to explicitly enable this so they know=20
>> what they are doing.
>=20
>=20
> I think it should be enabled by default, rather than disabled, so that=20=

> users would actually see a warning rather than get a sig 4.  Or, let=20=

> it not be Kconfig-able so that this doesn't become a problem any more.=20=

> (It's been 4 years since I sent to you an earlier version of this=20
> patch.)

And clearly most users don't seem terrible annoyed enough about this =
issue to have concerns.  I don't see why making it a Kconfig option =
impacts the small handful of people that happen to try and run a more =
generic distro on e500 cores.

- k=
