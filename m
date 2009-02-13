Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A04F0DDF71
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 12:18:05 +1100 (EST)
Date: Fri, 13 Feb 2009 04:18:01 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/83xx: Revive Marvell PHY option on
	MPC8313E-RDB rev. C boards
Message-ID: <20090213011801.GA28509@oksana.dev.rtsoft.ru>
References: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
	<2a27d3730902082347n7f0eb48dq8c4ecccda290f9c8@mail.gmail.com>
	<ED186496-3882-4E87-9BEC-B56FE09C5827@kernel.crashing.org>
	<20090210151047.GA25086@oksana.dev.rtsoft.ru>
	<60C07231-C830-440E-8425-D3069AB3620B@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9ED1D2D8B@zch01exm26.fsl.freescale.net>
	<F0245D03-4191-4482-B007-603C3DAC8A1A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <F0245D03-4191-4482-B007-603C3DAC8A1A@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 12, 2009 at 05:51:57PM -0600, Kumar Gala wrote:
> On Feb 11, 2009, at 11:40 PM, Li Yang-R58472 wrote:
>>>> Li, thanks for heads-up!
>>>>
>>>> One thing though: documentation says that Marvell PHY
>>> address is 0x3,
>>>> while old device tree and this patch:
>>>>
>>>>
>>> http://www.bitshrine.org/gpp/linux-fsl-2.6.23-MPC8313ERDB-add- 
>>> default-
>>>> dts.patch
>>>>
>>>> says "0x1"... I don't have any rev. C boards, so it would
>>> be great if
>>>> somebody could confirm that 0x1 is the actual address.
>>
>> The correct address is 0x3.  The previous patch in revB BSP used a  
>> guess
>> value before the revC documentation is available.  The latest BSP has
>> been updated to use the correct address.
>
> Anton, will you spin a new patch with this change?

Since the correct address is 0x3, that means that the old device
tree never worked on rev. C boards, thus there is no regression.
And furthermore, it appears that U-Boot doesn't support Marvell
PHY option either.

So, I don't think that adding the new device tree makes any sense
now.

I think the better option would be to implement Marvell PHY support
in U-Boot, and at the same time teach U-Boot to fixup 8313rdb's
device tree depending on the environment variable (something like
setenv marvell_phy_option yes/no), i.e. like I did for
MPC8315E-RDB's ULPI/TSEC1 options:

http://lists.denx.de/pipermail/u-boot/2008-July/036553.html

Makes sense? If not, I'll readily respin this patch with the PHY
address change.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
