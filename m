Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA06.emeryville.ca.mail.comcast.net
	(qmta06.emeryville.ca.mail.comcast.net [76.96.30.56])
	by ozlabs.org (Postfix) with ESMTP id E397DDDEF6
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 10:58:31 +1100 (EST)
Message-ID: <47E2FA6D.9020200@gmail.com>
Date: Thu, 20 Mar 2008 19:59:41 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] Make 83xx perfmon support selectable
References: <1204934343-5235-1-git-send-email-afleming@freescale.com>	<20080318170542.GA4099@loki.buserror.net>
	<E3C4695C-A2A9-4657-B771-97DFDD3F6ACE@kernel.crashing.org>
In-Reply-To: <E3C4695C-A2A9-4657-B771-97DFDD3F6ACE@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Phillips Kim <Kim.Phillips@freescale.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Mar 18, 2008, at 12:05 PM, Scott Wood wrote:
> 
>> On Fri, Mar 07, 2008 at 05:59:03PM -0600, Andy Fleming wrote:
>>> Not all e300 cores support the performance monitors, and the ones
>>> that don't will be confused by the mf/mtpmr instructions.  This
>>> allows the support to be optional, so the 8349 can turn it off
>>> while the 8379 can turn it on.  Sadly, those aren't config options,
>>> so it will be left to the defconfigs and the users to make that
>>> determination.
>>
>> So does this mean we can't do multiplatform of something with perfmon and
>> something without perfmon?  Seems like this should come from the device
>> tree, or PVR, or some other runtime check.
> 
> It possible if your binutils supports generating the instructions.  I 
> believe Kim was going to look at doing a patch to use a #define 
> MFPMR(x)/#define MTPMR() so we don't have to worry about toolchain 
> versions.
> 
> - k

Hi Kumar, Scott,

Per Andy (and my limited reading of the UMs), some 83xx have the PMR 
registers and some don't.  The compiler either supports the PMR register 
or it doesn't.  If you make it runtime configurable, people running CPUs 
that don't support the specific PMR will have to change compiler 
configurations in order to compile with the PMR register in there (could 
have unintended consequences).

Also, if you look at the code (arch/powerpc/kernel/pmc.c), there are 
several different types of PMR registers, based on the core and flavor 
of the core.  Finding or making a compiler setup that supports all of 
the possible PMR registers could be a problem.

You would still have to make the PMR read/write runtime selectable 
because the CPUs that don't support that register will raise an 
exception IIRC (an Really Bad Thing[tm]).

It crossed my mind /very briefly/ to use the FDT to select this but was 
not willing to put that much effort into it.
* Toolchain issues (first & second objection, above) - non-trivial
* Would have to read the enable/disable into a static (global?) variable
    to minimize the time impact for the runtime decision - ugh
* Need to add yet another definition to the booting-without-of.txt
    (bwoof) and appropriate .dts files - OK, I'm lazy

Best regards,
gvb
