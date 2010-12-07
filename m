Return-Path: <dirk.brandewie@gmail.com>
Message-ID: <4CFDA7AF.2060201@gmail.com>
Date: Mon, 06 Dec 2010 19:19:11 -0800
From: Dirk Brandewie <dirk.brandewie@gmail.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/4] of: Add support for linking device tree blobs into
	vmlinux
References: <cover.1291656753.git.dirk.brandewie@gmail.com>
	<76a37fa459aeadce5d11db8a7cc044687a2e0e8c.1291656753.git.dirk.brandewie@gmail.com>
	<20101206190251.GB20882@merkur.ravnborg.org>
In-Reply-To: <20101206190251.GB20882@merkur.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, mmarek@suse.cz,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, sodaville@linutronix.de,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/06/2010 11:02 AM, Sam Ravnborg wrote:
> On Mon, Dec 06, 2010 at 09:35:59AM -0800, dirk.brandewie@gmail.com wrote:
>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>> -
>> +# DTC
>> +#  ---------------------------------------------------------------------------
>> +
>> +# Generate an assembly file to wrap the output of the device tree compiler
>> +$(obj)/%.dtb.S: $(obj)/%.dtb
>> +	@echo '#include<asm-generic/vmlinux.lds.h>'>  $@
>> +	@echo '.section .dtb.init.rodata,"a"'>>  $@
>> +	@echo '.balign STRUCT_ALIGNMENT'>>  $@
>> +	@echo '.global __dtb_$(*F)_begin'>>  $@
>> +	@echo '__dtb_$(*F)_begin:'>>  $@
>> +	@echo '.incbin "$<" '>>  $@
>> +	@echo '__dtb_$(*F)_end:'>>  $@
>> +	@echo '.global __dtb_$(*F)_end'>>  $@
>> +	@echo '.balign STRUCT_ALIGNMENT'>>  $@
>> +
>
> If we really want this rule in Makefile.lib then at least make it less verbose,
> and more secure.

I started with the change in Makefile.lib because it made sense to me, is there 
a more appropriate place for these rules/commands?

> Something like this:
> quiet_dt_S_dtb_cmd = DTB    $@
>        dt_S_dtb_cmd =                                      \
> (                                                         \
> 	@echo '#include<asm-generic/vmlinux.lds.h>';     \
> 	@echo '.section .dtb.init.rodata,"a"';            \
> 	@echo '.balign STRUCT_ALIGNMENT';                 \
> 	echo '.global __dtb_$(*F)_begin';                 \
> 	echo '__dtb_$(*F)_begin:';                        \
> 	echo '.incbin "$<" ';                             \
> 	echo '__dtb_$(*F)_end:';                          \
> 	echo '.global __dtb_$(*F)_end';                   \
> 	echo '.balign STRUCT_ALIGNMENT';                  \
> )>  $@
>
> $(obj)/%.dtb.S: $(obj)/%.dtb
> 	$(call cmd,dt_S_dtb)
>

I will make the changes in next version.

>
>> +DTC = $(objtree)/scripts/dtc/dtc
>
> If this is the only spot where we use DTC then drop the variable.
>
>> +
>> +quiet_cmd_dtc = DTC $@
>> +      cmd_dtc = $(DTC) -O dtb -o $@ -b 0 $(DTC_FLAGS) $<
>
>
>> +ooo
>
> What is the purpose of these "ooo"? A debugging left-over?
>

Yep sorry

>
> 	Sam
