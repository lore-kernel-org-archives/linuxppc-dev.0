Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1E730DDEDD
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 03:52:07 +1000 (EST)
Message-ID: <46A78E3F.1030904@ru.mvista.com>
Date: Wed, 25 Jul 2007 21:54:07 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
	for CF	interface
References: <20070725165318.5331.23795.stgit@localhost.localdomain>	<20070725165326.5331.19920.stgit@localhost.localdomain>
	<46A78322.3080607@ru.mvista.com>
In-Reply-To: <46A78322.3080607@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

>>diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
>>index db0d003..f8f0e8a 100644
>>--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
>>+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
>>@@ -37,6 +37,15 @@
>> 		reg = <00000000 10000000>;
>> 	};
>> 
>>+	ide@f0000000 {
>>+		compatible = "mmio-ide";
>>+		device_type = "ide";

>     Why not "ata"?

    Also, what mmio-ide in the compat properly means in the context of 
ide_platform which is able to handle both port and memory mapped IDE. I think 
we must get rid with this crap, and since this IDE register mapping is pretty 
much board specific, call it something like "mpc8349emitx-ide" instead.

MBR, Sergei
