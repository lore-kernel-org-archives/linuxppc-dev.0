Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53327DDFD2
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 00:51:59 +1000 (EST)
Message-Id: <A005B9E2-9A1D-4190-AB00-A7C880E4DBDB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20080606143347.B35CC247FE@gemini.denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Default flats for running dtc from kernel build
Date: Fri, 6 Jun 2008 09:51:44 -0500
References: <20080606143347.B35CC247FE@gemini.denx.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 6, 2008, at 9:33 AM, Wolfgang Denk wrote:

> In message  
> <A261F367-1C5F-4197-92FD-07E7AD1D21FC@kernel.crashing.org> you wrote:
>>
>>> As I see it, I have to define DTS_FLAGS manually
>>>
>>> $ export DTS_FLAGS="-R4 -S0x3000"
>>> $ make ARCH=powerpc tqm8548.dtb
>>>
>>> to get a working blob. Is that the intended behavior?
>>
>> this is normal.  Andy Fleming has posted a patch to u-boot to help
>> improve the situation.  I'm not sure if WD has picked it up for 1.3.4
>> yet.
>
> I will. But wouldn't it make sense to allow at least for  some  level
> of  compatibility with older versions of U-Boot? Adding these options
> as default would probably not hurt?

Agreed.  I didn't realize we could actually do this from the kernel  
build system.

I'm sure others will have their two cents to add.

But something like:

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index c40fb82..52db85a 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -29,6 +29,8 @@ ifdef CONFIG_DEBUG_INFO
  BOOTCFLAGS     += -g
  endif

+DTS_FLAGS      ?= -R4 -S 0x3000
+
  ifeq ($(call cc-option-yn, -fstack-protector),y)
  BOOTCFLAGS     += -fno-stack-protector
  endif


- k
