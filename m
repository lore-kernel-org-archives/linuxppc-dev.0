Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53477DDED6
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 00:48:37 +1100 (EST)
Message-Id: <88CDAB76-B128-4C01-9834-05B9A480EB98@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Eduard Fuchs <edfuchs@uni-kassel.de>
In-Reply-To: <200904011536.39689.edfuchs@uni-kassel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: 8641D with linux 2.6.29 did'n show second cpu
Date: Wed, 1 Apr 2009 08:48:23 -0500
References: <200903311215.55237.edfuchs@uni-kassel.de>
	<200903311706.55478.edfuchs@uni-kassel.de>
	<E33D1DD7-FEA1-4B57-99C3-D2CA3BDE77E7@kernel.crashing.org>
	<200904011536.39689.edfuchs@uni-kassel.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	u-boot-dev U-Boot-UBOOTDEV <ubootdev@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 1, 2009, at 8:36 AM, Eduard Fuchs wrote:

> Hi,
>
> Am Mittwoch 01 April 2009 06:10:36 schrieb Kumar Gala:
>> On Mar 31, 2009, at 10:06 AM, Eduard Fuchs wrote:
>>> Hi,
>>>
>>> Am Dienstag 31 M=E4rz 2009 15:20:21 schrieb Kumar Gala:
>>>> On Mar 31, 2009, at 5:15 AM, Eduard Fuchs wrote:
>>>>> Hi,
>>>>>
>>>>> I'm testing the evaluation board from freescale (MPC8641DHPCN) =20
>>>>> with
>>>>> the latest
>>>>> linux kernel (2.6.29) and the second core seems disabled. =20
>>>>> CONFIG_SPM
>>>>> is
>>>>> enabled but the /proc/cpuinfo shows only one cpu. With original
>>>>> 2.6.27 kernel
>>>>> both cpu cores appears in /proc/cpuinfo.
>>>>>
>>>>> Has anyone an idea how can i enable the second core?
>>>>
>>>> Are you using u-boot?  I can't remember if you need a newer u-=20
>>>> boot to
>>>> deal with changes in how we bring up the second core.
>>>
>>> Yes. My u-boot version is 2009.03. Are there some additional config
>>> keys for
>>> SMP support in u-boot?
>>
>> It appears we introduced a bug in v2009.03 of u-boot.
>
> I never thought that the problem could be in u-boot. I tested the =20
> board with
> u-boot v2009.01 and it works well.

the u-boot bug is that we are over-writting the page of code we need =20
to bring up the second core.  Thus when the kernel releases the 2nd =20
core it goes off in the weeds.

I've sent some patches to the u-boot list that should fix the problem =20=

by making sure that u-boot avoids using the page of memory we need for =20=

the 2nd core.

- k=
