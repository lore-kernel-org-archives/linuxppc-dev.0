Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F9D667B31
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 04:22:03 +1000 (EST)
Message-ID: <4485C7A7.8050507@zytor.com>
Date: Tue, 06 Jun 2006 11:21:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: Base address of executables - weirdness?
References: <4485A279.4050403@zytor.com> <20060606173343.GE9294@austin.ibm.com>
In-Reply-To: <20060606173343.GE9294@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> On Tue, Jun 06, 2006 at 08:42:49AM -0700, H. Peter Anvin wrote:
>> I'm trying to track down an odd issue with klibc on ppc32.
>>
>> Until recently, binaries linked with ld defaulted to a base address of 
>> 0x10000000+SIZEOF_HEADERS.  However, recently I've gotten a couple of 
>> reports -- and I've been able to confirm this on my FC5 system -- that 
>> some versions of ld links at 0x01800000+SIZEOF_HEADERS.  Needless to 
>> say, this is more than a bit confusing, *especially* since "ld -verbose" 
>> still reports:
>>
>>      PROVIDE (__executable_start = 0x10000000); . = 0x10000000 + 
>> SIZEOF_HEADERS;
>>
>> ... at the top of the linker script.
>>
>> I'm rather baffled.  Has anyone else seen this, and/or have any other 
>> explanation?
> 
> Googling "0x01800000 linux ppc" brings up some interesting but old hits.
> 
> However, I swear I saw someone suggest a patch last week that changed
> 0x10000000 to 0x01800000 somewhere, (vmlinux.lds ??) as a proposed cure
> for a bug. Sorry, I deleted it.
> 

Well, it's worse than I previously surmised.  I can't seem to find any combination of 
options which work on both affected and unaffected binutils.  This is a real mess.

	-hpa
