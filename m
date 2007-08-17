Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7B36DDE9B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 22:53:45 +1000 (EST)
In-Reply-To: <20070817181352.d29117be.sfr@canb.auug.org.au>
References: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170212210.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170213040.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170215360.15311@blarg.am.freescale.net>
	<20070817181352.d29117be.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F5B1DA42-E536-4E06-BAB2-D16FCC1D9066@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [POWERPC] Stop include asm-ppc when building
	ARCH=powerpc for ppc32
Date: Fri, 17 Aug 2007 07:55:25 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2007, at 3:13 AM, Stephen Rothwell wrote:

> On Fri, 17 Aug 2007 02:15:54 -0500 (CDT) Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> @@ -172,18 +168,15 @@ install:
>>  archclean:
>>  	$(Q)$(MAKE) $(clean)=$(boot)
>>
>> -archmrproper:
>> -	$(Q)rm -rf arch/$(ARCH)/include
>> -
>>  archprepare: checkbin
>>
>> -ifeq ($(CONFIG_PPC32),y)
>> -# Temporary hack until we have migrated to asm-powerpc
>> -include/asm: arch/$(ARCH)/include/asm
>> -arch/$(ARCH)/include/asm: FORCE
>> -	$(Q)if [ ! -d arch/$(ARCH)/include ]; then mkdir -p arch/$(ARCH)/ 
>> include; fi
>> -	$(Q)ln -fsn $(srctree)/include/asm-$(OLDARCH) arch/$(ARCH)/ 
>> include/asm
>> -endif
>> +#ifeq ($(CONFIG_PPC32),y)
>> +## Temporary hack until we have migrated to asm-powerpc
>> +#include/asm: arch/$(ARCH)/include/asm
>> +#arch/$(ARCH)/include/asm: FORCE
>> +#	$(Q)if [ ! -d arch/$(ARCH)/include ]; then mkdir -p arch/$ 
>> (ARCH)/include; fi
>> +#	$(Q)ln -fsn $(srctree)/include/asm-$(OLDARCH) arch/$(ARCH)/ 
>> include/asm
>> +#endif
>
> Why not just remove it?  git will preserve it if we find a use for it.

oops, that was a debug foobar.. should have been removed.

Now fixed, got to love git-commit --amend.

- k
