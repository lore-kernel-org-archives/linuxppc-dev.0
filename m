Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 859A0B6F01
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jun 2010 05:40:14 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5PJdurb016073
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 12:40:06 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o5PJe1ck008839
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 14:40:02 -0500 (CDT)
Message-ID: <4C25060B.2040903@freescale.com>
Date: Fri, 25 Jun 2010 14:39:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: mpc870 support in the powerpc arch?
References: <AANLkTikk8-jiDZNtP8eucP90DLYRALwu749H-3v9LsHI@mail.gmail.com>	<20100517195451.GA19894@schlenkerla.am.freescale.net>
	<AANLkTinTSyGBRuWrjEzl9gAzLMt-qNZkwpjhxsqr5_5f@mail.gmail.com>
In-Reply-To: <AANLkTinTSyGBRuWrjEzl9gAzLMt-qNZkwpjhxsqr5_5f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2010 04:08 AM, Shawn Jin wrote:
> On Mon, May 17, 2010 at 12:54 PM, Scott Wood<scottwood@freescale.com>  wrote:
>> On Fri, May 14, 2010 at 02:41:29PM -0700, Shawn Jin wrote:
>>> Hi,
>>>
>>> Is mpc870 fully supported in the powerpc arch? I know it's an old
>>> processor but 8xx is still one of platforms in the powerpc arch. If
>>> it's not supported, how much effort will it be to resurrect mpc870 in
>>> the new arch considering we have substantial 8xx support?
>>
>> It should work, with appropriate board support -- MPC875 and MPC885 have
>> been used with arch/powerpc, and MPC870 is very similar (albeit with fewer
>> devices).
>
> Thanks Scott. I found your implementation in the kernel. I use
> adder875 as my base to port my board support. But I'm having a problem
> in the last step to create the cuImage. You may know what I did wrong.
> The error message is as follows.
>
>    WRAP    arch/powerpc/boot/cuImage.my870
> ppc_8xx-ld: arch/powerpc/boot/cuboot-my870.o: No such file: No such
> file or directory
> make[1]: *** [arch/powerpc/boot/cuImage.my870] Error 1

You need to update the case statement arch/powerpc/boot/wrapper to 
recognize your board and select cuboot-8xx.o, as is done for adder875. 
Otherwise it defaults to looking for a file for your specific board.

-Scott
