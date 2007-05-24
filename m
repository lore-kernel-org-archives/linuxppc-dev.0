Return-Path: <dzu@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 894D9DDE06
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 02:45:41 +1000 (EST)
To: joakim.tjernlund@transmode.se
Subject: Re: Problems in 2.6 memory management on 8xx
References: <m2fy5mcqut.fsf@sowhat.denx.de>
	<1180020200.1468.51.camel@gentoo-jocke.transmode.se>
	<1180023834.1468.64.camel@gentoo-jocke.transmode.se>
From: Detlev Zundel <dzu@denx.de>
Date: Thu, 24 May 2007 18:45:36 +0200
In-Reply-To: <1180023834.1468.64.camel@gentoo-jocke.transmode.se> (Joakim
	Tjernlund's message of "Thu\, 24 May 2007 18\:23\:54 +0200")
Message-ID: <m2hcq2b26n.fsf@sowhat.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Joakim,

> On Thu, 2007-05-24 at 17:23 +0200, Joakim Tjernlund wrote:
>> On Thu, 2007-05-24 at 15:07 +0200, Detlev Zundel wrote:
>> > Hi,
>> > 
>> > working on a 2.6.16 kernel on a 870 CPU, I ran into this strange
>> > behaviour exemplified by the simple attached demo program.  An icbi
>> > from userspace on an address that is mapped only lazily gets into an -
>> > though interruptible - loop. Locking the icbi target in question with
>> > mlock circumvents this problem.
>> 
>> 8xx is buggy w.r.t cache instructions. They do not update the
>> DAR register in the TLB miss/TLB error handlers.
>> The TLB miss handler does not use the DAR reg but the TLB error
>> handler do. Thats why it works when you mlock the memory.
>> 
>> This bug isn't documented but Freescale has confirmed it.
>> You can search the archives some years back for more info.
>> 
>>  Jocke
>
> BTW, it is possible to workaround this problem in the kernel by
> tagging DAR with an impossible value and compare DAR against it
> in the DTLB Error handler. If a match, then do a instruction decode
> to get the regs involved and calculate the faulting address.
>
> I did this several years ago for 2.4 in assembler and posted
> it, but it was rejected.
> One should bail out to handle_page_fault and do the
> calculations there instead(less likely to break that way)
>
> Found one version of the patch here:
> http://patchwork.ozlabs.org/linuxppc/patch?id=1307

Thanks for shedding some light on this problem.  I already found the
patch you refer to and also wondered why it was never accepted.  Was
there a technical reason or did it simply slip everybodys attention?

Cheers
  Detlev

-- 
Men are born ignorant, not stupid; they are made stupid by education.
					  --Bertrand Russell
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
