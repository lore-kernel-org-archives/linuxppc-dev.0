Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40023DE44D
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 23:38:55 +1100 (EST)
Message-ID: <47F22C9A.4050501@semihalf.com>
Date: Tue, 01 Apr 2008 14:37:46 +0200
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Please pull linux-2.6-mpc52xx.git
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>	
	<20080317222836.AFA66241A2@gemini.denx.de>	
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>	
	<47E938A8.9000103@semihalf.com>
	<fa686aa40803251151p457a2295w449222654be4d0d1@mail.gmail.com>
In-Reply-To: <fa686aa40803251151p457a2295w449222654be4d0d1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

Grant Likely wrote:
> On Tue, Mar 25, 2008 at 11:38 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
>> Grant Likely wrote:
>>  > The one part that I have a really strong opinion on is that there
>>  > should be a full featured mpc5200 defconfig for build testing.  Beyond
>>  > that (and if ojn can also be appeased) I can probably be convinced.  :-)
>>
>>  Hi Grant,
>>
>>  How to deal with a situation where I need a particular PHY driver from
>>  libphy compiled in the kernel for one of the MPC5200 boards? Adding it
>>  to mpc5200_defconfig doesn't seem like a right thing to do.
> 
> Why not?  mpc5200_defconfig is all about compile and runtime testing
> on many platforms to make sure drivers play well together.  I have no
> problem adding more drivers to the mpc5200 defconfig.  (In fact, I
> encourage it).
> 
>>  How to
>>  convince you (and appease ojn) to accept a patch that adds a
>>  board-specific defconfig that only slightly differs from
>>  mpc5200_defconfig? :)
> 
> I'm thinking 'optimized' defconfigs should go into a subdirectory.

This requires a change to the top-level Makefile and shepherding this
change upstream. Could we perhaps try to avoid this by having optimized
defconfigs in the form of, for example:

arch/powerpc/configs/tqm5200_opt_defconfig
arch/powerpc/configs/motionpro_opt_defconfig

Or, to signify what is the base defconfig:

arch/powerpc/configs/mpc5200_tqm5200_defconfig
arch/powerpc/configs/mpc5200_motionpro_defconfig

or even:

arch/powerpc/configs/mpc5200_opt_tqm5200_defconfig
arch/powerpc/configs/mpc5200_opt_motionpro_defconfig

Would patch adding an optimized _defconfig along these lines be accepted?

Regards,
Bartlomiej
