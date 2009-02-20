Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7B53DDDE1A
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 04:37:19 +1100 (EST)
Date: Fri, 20 Feb 2009 20:37:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/83xx: Add power management support for MPC837x
	boards
Message-ID: <20090220173717.GA7852@oksana.dev.rtsoft.ru>
References: <20090220171258.GA3050@oksana.dev.rtsoft.ru>
	<499EE8DD.2030709@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <499EE8DD.2030709@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 20, 2009 at 11:31:09AM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
>> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
>> index 3e3ec8f..c54b90d 100644
>> --- a/arch/powerpc/boot/dts/mpc8377_mds.dts
>> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
>> @@ -137,6 +137,7 @@
>>  			reg = <0x3000 0x100>;
>>  			interrupts = <14 0x8>;
>>  			interrupt-parent = <&ipic>;
>> +			sleep = <&pmc 0x0c000000>;
>>  			dfsrr;
>
> [snip]
>
>> @@ -318,6 +325,7 @@
>>  			reg = <0x2e000 0x1000>;
>>  			interrupts = <42 0x8>;
>>  			interrupt-parent = <&ipic>;
>> +			sleep = <&pmc 0x0c000000>;
>
> You have two different nodes with the same bits referenced.

Yes, I2C1 and eSDHC are using the same clock source.

> These nodes
> cannot be put to sleep independently, and as such need to be under a
> common sleep-nexus node.

Ah, that's what the sleep-nexus nodes are for... ;-)

Thank you Scott, I'll add the sleep-nexus nodes.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
