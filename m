Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42822DDE25
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 00:46:13 +1000 (EST)
Message-Id: <D346E2E4-26C3-482E-ABBF-AF1EE97E91CD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20080504192434.GA23752@uranus.ravnborg.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: How to link a .o with all modules
Date: Mon, 5 May 2008 09:46:08 -0500
References: <6C8AB345-2DA0-460D-B7C8-262463247DDE@kernel.crashing.org>
	<20080504192434.GA23752@uranus.ravnborg.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	lkml List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 4, 2008, at 2:24 PM, Sam Ravnborg wrote:

> On Sun, May 04, 2008 at 01:22:38PM -0500, Kumar Gala wrote:
>> Sam,
>>
>> We have a case in powerpc in which we want to link some library
>> routines with all module objects.  The routines are intended for
>> handling out-of-line function call register save/restore so having
>> them as EXPORT_SYMBOL() is counter productive (we do also need to  
>> link
>> the same "library" code into the kernel).
>>
>> Any suggestions on how to handle this?
>
> I assume you have the .o file build somewhere as part of the
> normal kernel build.
>
> Then you in
> arch/powerpc/Makefile adds the following assignment:
>
> LDFLAGS_MODULE += arch/powerpc/lib/my_magic_file.o
>
> kbuild will then during the modpost stage link this
> file on all modules.
> To add the same file to the kernel just include it
> in a obj-y += my_magic_file.o
>
> One trap is that my_magic_file.o needs to be built
> for a modules build too.
> I think you need to assign it to always:
>
>   always := my_magic_file.o
>
> to accomplish this.
>
> So in the end we will have:
>
> arch/powerpc/Makefile:
> LDFLAGS_MODULE += arch/powerpc/lib/my_magic_file.o
>
> arch/powerpc/lib/Makefile:
> always := my_magic_file.o
> obj-y += my_magic_file.o
>
>
> Let me know if this does address your question.

The problem is MODPOST complains about undefined symbols:

   MODPOST 24 modules
ERROR: "_restgpr_20_x" [net/key/af_key.ko] undefined!
ERROR: "_restgpr_25_x" [net/key/af_key.ko] undefined!
ERROR: "_restgpr_30_x" [net/key/af_key.ko] undefined!

...

Any ideas on that?

- k
