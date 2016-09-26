Return-Path: <david.engraf@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [176.9.12.79])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjHqc6xWMzDrPk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 18:55:40 +1000 (AEST)
From: David Engraf <david.engraf@sysgo.com>
Subject: Re: powerpc64: Enable CONFIG_E500 and CONFIG_PPC_E500MC for
 e5500/e6500
To: Scott Wood <oss@buserror.net>
References: <1471877203-29327-1-git-send-email-david.engraf@sysgo.com>
 <20160925062017.GA10754@home.buserror.net>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <87664de8-7aea-96a8-9906-cf2ce8d325a2@sysgo.com>
Date: Mon, 26 Sep 2016 10:48:31 +0200
MIME-Version: 1.0
In-Reply-To: <20160925062017.GA10754@home.buserror.net>
Content-Type: multipart/mixed; boundary="------------7D9FB6D632217FEE3DE6D715"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------7D9FB6D632217FEE3DE6D715
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Am 25.09.2016 um 08:20 schrieb Scott Wood:
> On Mon, Aug 22, 2016 at 04:46:43PM +0200, David Engraf wrote:
>> The PowerPC e5500/e6500 architecture is based on the e500mc core. Enable
>> CONFIG_E500 and CONFIG_PPC_E500MC when e5500/e6500 is used.
>>
>> This will also fix using CONFIG_PPC_QEMU_E500 on PPC64.
>>
>> Signed-off-by: David Engraf <david.engraf@sysgo.com>
>> ---
>>  arch/powerpc/platforms/Kconfig.cputype | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
>> index f32edec..0382da7 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -125,11 +125,13 @@ config POWER8_CPU
>>
>>  config E5500_CPU
>>  	bool "Freescale e5500"
>> -	depends on E500
>> +	select E500
>> +	select PPC_E500MC
>>
>>  config E6500_CPU
>>  	bool "Freescale e6500"
>> -	depends on E500
>> +	select E500
>> +	select PPC_E500MC
>
> These config symbols are for setting -mcpu.  Kernels built with
> CONFIG_GENERIC_CPU should also work on e5500/e6500.

I don't think so. At least on QEMU it is not working because e5500/e6500 
is based on the e500mc core and the option CONFIG_PPC_E500MC also 
controls the cpu features (check cputable.h).

> The problem is that CONFIG_PPC_QEMU_E500 doesn't select E500 (I didn't
> notice it before because usually CORENET_GENERIC is enabled as well).

I noticed that as well, but I think it makes more sense to select 
E500/PPC_E500MC within the cputype menu instead of having a dependency 
which might be not clear for the user. Right now the way how to 
configure such a BSP is not clear, you need to open "Processor support" 
and select the "Processor Type", then switch to "Platform support" to 
select the BSP and afterward got back to "Processor support" to switch 
from the generic CPU type to e5500/e6500.

> Note that your patch, by eliminating the dependency on E500, would make
> it possible to build a book3s kernel with E5500_CPU/E6500_CPU, which
> doesn't make any sense.

You're right. The attached version fixes this.

- David

--------------7D9FB6D632217FEE3DE6D715
Content-Type: text/x-patch;
 name="ppc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ppc.patch"

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f32edec..abd345e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -125,11 +125,15 @@ config POWER8_CPU
 
 config E5500_CPU
 	bool "Freescale e5500"
-	depends on E500
+	depends on PPC_BOOK3E_64
+	select E500
+	select PPC_E500MC
 
 config E6500_CPU
 	bool "Freescale e6500"
-	depends on E500
+	depends on PPC_BOOK3E_64
+	select E500
+	select PPC_E500MC
 
 endchoice
 

--------------7D9FB6D632217FEE3DE6D715--
