Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 3B81667A45
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 05:40:55 +1100 (EST)
Message-ID: <41ED5832.2040602@mvista.com>
Date: Tue, 18 Jan 2005 11:40:50 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <41EC29A8.1040703@mvista.com>
	<Pine.GSO.4.61.0501181017110.20681@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.61.0501181017110.20681@waterleaf.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:

>On Mon, 17 Jan 2005, Mark A. Greer wrote:
>  
>
>><snip>
>>
>>There are 2 reasons to not use the ppc_md.get_rtc_time() et. al. interfaces:
>>1) They are called before the i2c driver is initialized and even loaded if its
>>a module.
>>    
>>
>
>How is this solved by your patch if genrtc is builtin?
>

It solved because the rtc interface isn't called until you do an hwclock 
presumably in a startup script.

> How is your solution
>different from setting ppc_md.get_rtc_time to your get_rtc_time routine?
>

It arch independent which was the whole motivation for doing it this 
way.  However, it does rely on a startup script to do a 'hwclock 
--hctosys' which happen after driver initialization.  From what I can 
tell sysvinit used to do the hwclock but doesn't anymore so you need a 
script.  The mvl userland has a startup script that does this; others 
probably do too.  Note that using a startup script to do a hwclock is 
pretty standard AFAICT.

>>2) Its ppc-specific.  Implementing get_rtc_time() et. al. directly makes it
>>generic across all architectures.
>>    
>>
>
>... but prevents you from building a kernel that supports both normal RTCs and
>your i2c RTC.
>

Well, yes but you aren't going to be able to do this and be 
arch-agnostic.  If you don't care about running on anything but ppc then 
you can to it the way i2c rtc's have been done before and either kludge 
into the i2c driver during early startup or setup ppc_md.get_rtc_time() 
once the i2c/rtc driver(s) are initialized.  This patch will not 
interfere with that unless you deliberately set that option.

I think the real question you should be ask is are the 
ppc_md.get_rtc_time() et. al. calls really necessary?  Or to put it 
another way, should we be grilling the people who are submitting 
ppc-only solutions and not the ones submitting generic solutions?  :)

Mark
