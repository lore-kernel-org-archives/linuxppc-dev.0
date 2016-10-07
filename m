Return-Path: <david.engraf@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [176.9.12.79])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sr3Pv2dc0zDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 20:00:18 +1100 (AEDT)
Subject: Re: powerpc64: Enable CONFIG_E500 and CONFIG_PPC_E500MC for
 e5500/e6500
To: Scott Wood <oss@buserror.net>
References: <1471877203-29327-1-git-send-email-david.engraf@sysgo.com>
 <20160925062017.GA10754@home.buserror.net>
 <87664de8-7aea-96a8-9906-cf2ce8d325a2@sysgo.com>
 <1474931328.4283.41.camel@buserror.net>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: David Engraf <david.engraf@sysgo.com>
Message-ID: <992d2bea-019a-3969-e154-10b9b43ab6fc@sysgo.com>
Date: Fri, 7 Oct 2016 11:00:09 +0200
MIME-Version: 1.0
In-Reply-To: <1474931328.4283.41.camel@buserror.net>
Content-Type: multipart/mixed; boundary="------------87FF40E6215DD7B6BC059197"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------87FF40E6215DD7B6BC059197
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 27.09.2016 um 01:08 schrieb Scott Wood:
> On Mon, 2016-09-26 at 10:48 +0200, David Engraf wrote:
>> Am 25.09.2016 um 08:20 schrieb Scott Wood:
>>>
>>> On Mon, Aug 22, 2016 at 04:46:43PM +0200, David Engraf wrote:
>>>>
>>>> The PowerPC e5500/e6500 architecture is based on the e500mc core. Enable
>>>> CONFIG_E500 and CONFIG_PPC_E500MC when e5500/e6500 is used.
>>>>
>>>> This will also fix using CONFIG_PPC_QEMU_E500 on PPC64.
>>>>
>>>> Signed-off-by: David Engraf <david.engraf@sysgo.com>
>>>> ---
>>>>  arch/powerpc/platforms/Kconfig.cputype | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/platforms/Kconfig.cputype
>>>> b/arch/powerpc/platforms/Kconfig.cputype
>>>> index f32edec..0382da7 100644
>>>> --- a/arch/powerpc/platforms/Kconfig.cputype
>>>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>>>> @@ -125,11 +125,13 @@ config POWER8_CPU
>>>>
>>>>  config E5500_CPU
>>>>  	bool "Freescale e5500"
>>>> -	depends on E500
>>>> +	select E500
>>>> +	select PPC_E500MC
>>>>
>>>>  config E6500_CPU
>>>>  	bool "Freescale e6500"
>>>> -	depends on E500
>>>> +	select E500
>>>> +	select PPC_E500MC
>>> These config symbols are for setting -mcpu.  Kernels built with
>>> CONFIG_GENERIC_CPU should also work on e5500/e6500.
>> I don't think so.
>
> I do think so.  It's what you get when you run "make corenet64_smp_defconfig"
> and that kernel works on e5500/e6500.
>
>>  At least on QEMU it is not working because e5500/e6500
>> is based on the e500mc core and the option CONFIG_PPC_E500MC also
>> controls the cpu features (check cputable.h).
>
> Again, this is only a problem when you have CONFIG_PPC_QEMU_E500 without
> CONFIG_CORENET_GENERIC, and the fix for that is to have CONFIG_PPC_QEMU_E500
> select CONFIG_E500 (and you need to manually turn on CONFIG_PPC_E500MC if
> applicable, since CONFIG_PPC_QEMU_E500 can also be used with e500v2).
>
> I wouldn't be opposed to also adding "select PPC_E500MC if PPC64" to
> CONFIG_PPC_QEMU_E500.

Please find attached the new version, setting E500 and PPC_E500MC on 64 
bit for review.

- David

>>>
>>> The problem is that CONFIG_PPC_QEMU_E500 doesn't select E500 (I didn't
>>> notice it before because usually CORENET_GENERIC is enabled as well).
>> I noticed that as well, but I think it makes more sense to select
>> E500/PPC_E500MC within the cputype menu instead of having a dependency
>> which might be not clear for the user.
>
> Again, that breaks CONFIG_GENERIC_CPU.  Unlike 32-bit, all 64-bit book3e
> targets are supposed to be supportable with a single kernel image.
>
> -Scott
>


--------------87FF40E6215DD7B6BC059197
Content-Type: text/x-diff;
 name="ppc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ppc.patch"

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index df25a3e..7e18456 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -253,6 +253,8 @@ endif # PPC32
 config PPC_QEMU_E500
 	bool "QEMU generic e500 platform"
 	select DEFAULT_UIMAGE
+	select E500
+	select PPC_E500MC if PPC64
 	help
 	  This option enables support for running as a QEMU guest using
 	  QEMU's generic e500 machine.  This is not required if you're

--------------87FF40E6215DD7B6BC059197--
