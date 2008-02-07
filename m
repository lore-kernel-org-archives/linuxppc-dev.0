Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 28703DDE48
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 07:24:43 +1100 (EST)
Message-ID: <47AB690A.70807@pikatech.com>
Date: Thu, 07 Feb 2008 15:24:42 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: asm-offsets.c
References: <47AA8C7D.3030109@pikatech.com> <1202373888.7079.124.camel@pasglop>
In-Reply-To: <1202373888.7079.124.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@ottawa.kanatek.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2008-02-06 at 23:43 -0500, Sean MacLennan wrote:
>   
>> I just did a git pull of Josh's tree, and 
>> arch/powerpc/kernel/asm-offsets.c does not compile. I have only been 
>> glossing over the linuxppc-dev emails, so forgive me if this already 
>> came up.
>>
>> It looks like, at least for the Warp, CLOCK_REALTIME_RES is not defined 
>> so asm-offsets.c gets an error. The following patch fixes it.... but I 
>> am not sure it is right since I don't know if CLOCK_REALTIME_RES should 
>> be defined.
>>     
>
> Hrm... this macro should -define- CLOCK_REALTIME_RES, not rely on an
> existing definition...
>   
If I comment out CLOCK_REALTIME in include/linux/time.h then I fail:

  CC      arch/powerpc/kernel/asm-offsets.s
arch/powerpc/kernel/asm-offsets.c: In function 'main':
arch/powerpc/kernel/asm-offsets.c:313: error: 'CLOCK_REALTIME' undeclared (first use in this function)
arch/powerpc/kernel/asm-offsets.c:313: error: (Each undeclared identifier is reported only once
arch/powerpc/kernel/asm-offsets.c:313: error: for each function it appears in.)
make[1]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
make: Leaving directory `/home/seanm/taco/for-2.6.25'


It looks like the first arg must be defined?

Cheers,
   Sean
