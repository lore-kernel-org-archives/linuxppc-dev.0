Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id C80E62BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 01:53:18 +1000 (EST)
Date: Fri, 8 Oct 2004 11:45:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041008154631.GA14773@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.60.0410081142300.14235@dell.enoriver.com>
References: <Pine.LNX.4.60.0410080840520.6091@dell.enoriver.com>
	<7D7D70F5-193F-11D9-9299-003065F9B7DC@embeddededge.com>
	<20041008154631.GA14773@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: next pass of cleaning up micropatch.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 8 Oct 2004, Tom Rini wrote:

> On Fri, Oct 08, 2004 at 11:34:06AM -0400, Dan Malek wrote:
>> On Oct 8, 2004, at 8:44 AM, Robert P. J. Day wrote:
>>> + *  Shortcut macros for patching code.
>>>  */
>>> +
>>> +#define PATCH2000 \
>>> +	dp = (uint *)(commproc->cp_dpmem); \
>>> +	for (i=0; i<(sizeof(patch_2000)/4); i++) \
>>> +		*dp++ = patch_2000[i];
>>> +
>>> +#define PATCH2E00 \
>>> +	dp = (uint *)&(commproc->cp_dpmem[0x0e00]); \
>>> +	for (i=0; i<(sizeof(patch_2e00)/4); i++) \
>>> +		*dp++ = patch_2e00[i];
>>> +
>>> +#define PATCH2F00 \
>>> +	dp = (uint *)&(commproc->cp_dpmem[0x0f00]); \
>>> +	for (i=0; i<(sizeof(patch_2f00)/4); i++) \
>>> +		*dp++ = patch_2f00[i];
>>
>> Please get rid of these macros and place the code where it
>> belongs.  They add no value and just make it harder to
>> read the code and understand what it does.
>
> I agree.  If there were more patches it might make sense to write a
> do_microcode_patch2(N) macro, but PATCH2NNN isn't "readable" and it's
> only 3 patches.

fair enough, but keep in mind, the whole point was that what you're 
looking at is the minimal *infrastructure* for possibly adding more 
patches down the road.  right *now*, there's only three because those 
are the only ones that were in micropatch.c at the moment.  there's 
certainly a lot more available at freescale that can be added as time 
goes by.

i'll put the actual code back in, but you might have second thoughts 
when we're up to 8 or 10 patches some day. :-)

rday
