Return-Path: <skepper@chara.vm.bytemark.co.uk>
Received: from chara.vm.bytemark.co.uk (chara.vm.bytemark.co.uk [80.68.89.253])
	by ozlabs.org (Postfix) with ESMTP id C022ADDF6F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 22:00:14 +1000 (EST)
Date: Tue, 26 Aug 2008 13:00:05 +0100 (BST)
From: Chris Skepper <skepper@ukf.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Early boot problem with MPC8247 and Linux 2.6.26
In-Reply-To: <48AEF220.7080506@freescale.com>
Message-ID: <Pine.LNX.4.62.0808261219210.3327@chara.vm.bytemark.co.uk>
References: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>
	<48AEF220.7080506@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: Chris Skepper <skepper@chara.vm.bytemark.co.uk>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: skepper@ukf.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 22 Aug 2008, Scott Wood wrote:

> Chris Skepper wrote:
>> Using code to flash an LED I have traced execution from the entry point in 
>> head_32.S, through to call_setup_cpu in misc.S, __setup_cpu_603 and into 
>> setup_common_caches in cpu_setup_6xx.S.  It appears to reset when enabling 
>> the cache on the CPU:
>> 
>> setup_common_caches:
>>     mfspr    r11,SPRN_HID0
>>     andi.    r0,r11,HID0_DCE
>>     ori    r11,r11,HID0_ICE|HID0_DCE
>>     ori    r8,r11,HID0_ICFI
>>     bne    1f            /* don't invalidate the D-cache */
>>     ori    r8,r8,HID0_DCI        /* unless it wasn't enabled */
>> 1:    sync
>>     /* Chris: Reaches here. */
>>     mtspr    SPRN_HID0,r8        /* enable and invalidate caches */
>>     sync
>>     mtspr    SPRN_HID0,r11        /* enable caches */
>>     sync
>>     isync
>>     /* Chris: Never gets to here. */
>>     blr
>> 
>> FWIW, commenting out the lines above causes it to hang when attempting to 
>> enable the MMU, which is the next step in the process.
>
> How are you determining that it never gets to that point?  If it's via serial 
> I/O or similar, be aware that I/O isn't going to work when caches are enabled 
> but the MMU is not.

Hi Scott,

I'm triggering an LED which is connected to port A.  Are you saying that 
wouldn't work once the caching is enabled?

Cheers,

Chris.
