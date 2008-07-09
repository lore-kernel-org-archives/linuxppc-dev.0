Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8864FDE32C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 22:54:48 +1000 (EST)
Message-Id: <1F3AE758-B99A-457F-A74D-6D12DAF74115@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: jwboyer@linux.vnet.ibm.com
In-Reply-To: <1215603723.13186.0.camel@weaponx>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: libfdt: Increase namespace-pollution paranoia
Date: Wed, 9 Jul 2008 07:54:15 -0500
References: <20080709041024.GB29648@yookeroo.seuss>
	<1215603723.13186.0.camel@weaponx>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 9, 2008, at 6:42 AM, Josh Boyer wrote:

> On Wed, 2008-07-09 at 14:10 +1000, David Gibson wrote:
>> libfdt is supposed to easy to embed in projects all and sundry.
>> Often, it won't be practical to separate the embedded libfdt's
>> namespace from that of the surrounding project.  Which means there  
>> can
>> be namespace conflicts between even libfdt's internal/static  
>> functions
>> and functions or macros coming from the surrounding project's headers
>> via libfdt_env.h.
>>
>> This patch, therefore, renames a bunch of libfdt internal functions
>> and macros and makes a few other chances to reduce the chances of
>> namespace collisions with embedding projects.  Specifically:
>> 	- Internal functions (even static ones) are now named _fdt_*()
>>
>> 	- The type and (static) global for the error table in
>>          fdt_strerror() gain an fdt_ prefix
>>
>> 	- The unused macro PALIGN is removed
>>
>> 	- The memeq and streq macros are removed and open-coded in the
>>          users (they were only used once each)
>>
>> 	- Other macros gain an FDT_ prefix
>>
>> 	- To save some of the bulk from the previous change, an
>>          FDT_TAGALIGN() macro is introduced, where FDT_TAGALIGN(x) ==
>>          FDT_ALIGN(x, FDT_TAGSIZE)
>>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>
> On a slightly unrelated note, are you planning to sync the in-kernel
> dtc/libfdt version with the upstream version anytime soon?

I know jon put an -rc, not sure if he plans to pick up the slew of  
patches for the next -rc or the next release, but it would be good to  
resync the in-kernel version for 2.6.27.

- k
