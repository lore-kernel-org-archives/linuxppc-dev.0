Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 945B5DDF1C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 03:07:44 +1100 (EST)
Message-Id: <547FA711-EB43-4F0A-B69D-AE7C9557AC37@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20081016152402.GA12408@secretlab.ca>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Fix linking modules against crtsavres.o
Date: Thu, 16 Oct 2008 11:07:27 -0500
References: <20081009195125.GG5178@mx.loc>
	<20081016152402.GA12408@secretlab.ca>
Cc: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>, paulus@samba.org,
	sam@ravnborg.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 16, 2008, at 10:24 AM, Grant Likely wrote:

> On Thu, Oct 09, 2008 at 09:51:25PM +0200, Bernhard Reutner-Fischer  
> wrote:
>> Hi,
>>
>> [ http://bugzilla.kernel.org/show_bug.cgi?id=11143 has it all]
>>
>> targeting ppc(32), e.g. 405 (!fp), previously i got:
>>  CC      drivers/char/hw_random/rng-core.mod.o
>>  LD [M]  drivers/char/hw_random/rng-core.ko
>> /there/src/buildroot.git.ppc/build_powerpc_nofpu/staging_dir/usr/ 
>> bin/powerpc-linux-uclibc-ld:
>> arch/powerpc/lib/crtsavres.o: No such file: No such file or directory
>>
>> 	* Makefile (LDFLAGS_MODULE_PREREQ): New variable to hold  
>> prerequisite
>> 	files for modules.
>> 	* arch/powerpc/Makefile: add crtsavres.o to LDFLAGS_MODULE_PREREQ.
>> 	* scripts/Makefile.modpost (cmd_as_o_S): Copy from Makefile.build.
>> 	(cmd_ld_ko_o): Also link LDFLAGS_MODULE_PREREQ.
>> 	Provide rule to build objects from assembler.
>>
>> The attached patch (same as attached to abovementioned bug) fixes  
>> this.
>> I'm asking the ppc maintainers or you, Sam, to consider something to
>> that effect for inclusing in the stable series.
>> thanks,
>
> This patch solves the problem for me.  Without it building modules
> before the kernel proper fails to find crtsavres.o when linking.
>
> Ben, Paul or Sam, could you please look at this and make comment
> if it is the right approach?
>
> I also agree that this should be back ported to the stable series
>
> (Note: for some reason this patch did *not* show up in patchwork).

because it was sent as an attachment.

- k
