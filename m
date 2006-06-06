Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B0FB67B47
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 07:22:07 +1000 (EST)
Message-ID: <4485F1F5.7070506@zytor.com>
Date: Tue, 06 Jun 2006 14:21:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Subject: Re: Base address of executables - weirdness?
References: <4485A279.4050403@zytor.com> <jeirne56kn.fsf@sykes.suse.de>
In-Reply-To: <jeirne56kn.fsf@sykes.suse.de>
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

Andreas Schwab wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> Until recently, binaries linked with ld defaulted to a base address of 
>> 0x10000000+SIZEOF_HEADERS.  However, recently I've gotten a couple of 
>> reports -- and I've been able to confirm this on my FC5 system -- that 
>> some versions of ld links at 0x01800000+SIZEOF_HEADERS.
> 
> You are probably using the wrong linker emulation.  There are three
> emulations enabled when building binutils for ppc-linux, but only the
> elf32ppclinux emulation it the right one that uses 0x10000000 for the base
> address.
> 

Hm.  Well, it's using the default one, but perhaps I should try to specify an explicit -m 
option.  Sure enough, that did the trick.

THANKS!

	-hpa
