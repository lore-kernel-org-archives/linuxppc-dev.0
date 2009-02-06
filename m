Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 528C6DDE00
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:27:01 +1100 (EST)
Message-Id: <287EB610-4821-4F0A-A3EF-7DCA146D2F73@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20090206160452.GB1641@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Build breakage for CONFIG_PM but no CONFIG_SUSPEND
Date: Fri, 6 Feb 2009 10:26:46 -0600
References: <1436.1233879027@neuling.org>
	<20090206160452.GB1641@ld0162-tx32.am.freescale.net>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 6, 2009, at 10:04 AM, Scott Wood wrote:

> On Fri, Feb 06, 2009 at 11:10:27AM +1100, Michael Neuling wrote:
>> I noticed this doing some randconfig testing (.config below).  I have
>> CONFIG_PM but no CONFIG_SUSPEND.  Bug is against mainline.
>>
>> arch/powerpc/sysdev/built-in.o: In function `ipic_suspend':
>> ipic.c:(.text+0x6b34): undefined reference to `fsl_deep_sleep'
>> make[1]: *** [.tmp_vmlinux1] Error 1
>> make: *** [sub-make] Error 2
>>
>> Looks like #ifdef CONFIG_PM in arch/powerpc/sysdev/ipic.c should be
>> CONFIG_SUSPEND.  d49747bdfb2ddebea24d1580da55b79d093d48a9 introduced
>> this.
>>
>> Maybe this fixes it?
>>
>>
>> Fix build when we have CONFIG_PM but no CONFIG_SUSPEND.
>
> ACK.  That was a leftover from before CONFIG_SUSPEND was introduced.

If you send a proper patch I'll apply it and queue it up with some  
other fixes.

- k
