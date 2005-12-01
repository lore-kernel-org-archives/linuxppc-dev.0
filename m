Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB77468862
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 02:13:59 +1100 (EST)
In-Reply-To: <20051201121711.GA4105@dmt.cnet>
References: <437B2051.5030408@ru.mvista.com> <20051117135810.GB9753@logos.cnet>
	<437DE07E.6080005@ru.mvista.com>
	<20051118090845.GB12765@logos.cnet>
	<17283.54950.681390.749679@cargo.ozlabs.ibm.com>
	<20051123091107.GA3482@logos.cnet>
	<ACB2F36A-0A37-4EA1-9E4A-F773AD4E0D86@kernel.crashing.org>
	<20051123120033.GA3551@logos.cnet>
	<6B29BC5F-3B18-4EEE-B70C-215A2C540C85@kernel.crashing.org>
	<20051201121711.GA4105@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F4EE951F-47BD-4C3E-A539-EE05BF1ADC04@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 1 Dec 2005 09:13:57 -0600
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 1, 2005, at 6:17 AM, Marcelo Tosatti wrote:

> On Wed, Nov 30, 2005 at 01:08:31AM -0600, Kumar Gala wrote:
>>> Hi Kumar,
>>>
>>> I dont really know the policy for driver placement, but it seems  
>>> that
>>> it works on a case by case basis.
>>>
>>> The files in arch/ppc/8xx_io/ (which is what I think you refer to as
>>> candidates for drivers/), are:
>>
>> We have been slowly working on moving drivers out of arch/ppc and
>> into drivers/ so that subsystem maintainers could get proper review
>> of them.
>>
>>> 1) commproc.c
>>> Basic API for dpram access. Core code.
>>>
>>> 2) micropatch.c
>>> microcode update code/data. Core code.
>>
>> Well #1 & #2 aren't what I would call drivers at all.  I would
>> consider them syslib/ candidates.  Hopefully, someone will
>
> Move them there? Yeah... We can add that to the 8xx TODO list
> if its interesting.

I would just wait and move them to arch/powerpc/sysdev whenever 8xx  
moves over to arch/powerpc.  No reason to move the files twice.

>>> 3) cs4218.h
>>> 4) cs4218_tdm.c
>>>
>>> cs4218 does not compile at the moment due to syntatical problems,
>>> I've fixed them up and the driver compiles, but I don't know
>>> if it works (patch attached).
>>>
>>> I would not be surprised if the driver has been broken since
>>> long time ago.
>>>
>>> Does anyone have hardware to test it? Dan?
>>>
>>> Otherwise we should remove it from the tree, since its unmaintained
>>> and unused.
>>
>> If its still good, I would guessing /drivers/audio or snd, but
>> neither seem to exist.  I wondering where sound card drivers live
>> these days.
>
> snd/ I think... Someone needs to test the driver. I think we should  
> just
> fixup the syntactical problems and mark it as BROKEN until someone  
> (Dan?)
> confirms it works.

Agreed.

>>> 5) enet.c
>>> 6) fec.c
>>>
>>> The ENET/FEC network drivers are obseleted by fs_enet.
>>>
>>> However there are some PHY descriptions in fec.c which are missing
>>> from
>>> fs_enet - we'd better make sure to have them all in the new driver
>>> before removing the old one.
>>
>> Agreed.
>>
>>> Aris, would you mind looking into this?
>>>
>>> Once we have that we can set a deadline at Documentation/feature-
>>> removal.txt
>>> if desired.
>>>
>>> Other than those there are no 8xx drivers in arch/ppc/ AFAIK.
>>>
>>> <cs42.patch>
>>
>> Good deal.  Are we really removing anything (except maybe cs4218)?
>
> FEC certainly and cs4218 seems like a candidate.

Well cs4218 depends on Dan's feedback.  As far as FEC, I see that we  
replaced it with something else.  So we should feel free to remove it  
from 8xx_io as long as we feel that the new driver will work for  
people and update the in kernel platforms for it.

- kumar
