Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 320C2DDE25
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 17:43:12 +1000 (EST)
In-Reply-To: <14852.1177053830@neuling.org>
References: <12001.1176881167@neuling.org> <5129.1176956949@neuling.org>
	<46b0d1603ea2ab82b37daaa1888e8793@bga.com>
	<14852.1177053830@neuling.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1b37836af7a3cbc22d6b9bf8cef5851b@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] kexec-tools ppc64: add --reuseinitrd option 
Date: Fri, 20 Apr 2007 02:42:44 -0500
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org,
	Fastboot mailing list <fastboot@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Apr 20, 2007, at 2:23 AM, Michael Neuling wrote:
> In message <46b0d1603ea2ab82b37daaa1888e8793@bga.com> you wrote:
>> On Apr 18, 2007, at 11:29 PM, Michael Neuling wrote:
>>> Add a --reuseinitrd option so that initrds saved using the
>>> retain_initrd kernel option can be reused on the kexec boot.
>>
>> Although this seems efficent to look at what was in the device tree,
>> I'd prefer we actually looked at /proc/cmdline when we parse the
>> arg, so that we are sure to find what the kernel is actually
>> using for the command line.
>>
>> Besides it will be eaiser for other archs to copy the check.
>
> Looks like we should make it a generic option.  If we do, this should
> probably be two patches.  One to introduce the option, and one for the
> ppc64 specific parts.
>
> Do any of the other architectures allow you to see where the initrd is
> located for the current boot from user space?  If not, the option will
> need to take two parameters saying where the retained initrd is.  This
> will make the option less generic (if not, we'll need to change the
> other archs to export these values to user space).

Since we just added the option to the kernel, I'm guessing not.
Most of them use /proc/iomem with resources for finding system ram,
the kernel text and crash kernel region, so they should probably
add a resource there when the initrd is retained.  We (powerpc) export
our bootloader data aka device tree instead, and make kexec-tools
parse it.  I don't know how sparc passes an initrd to the kernel.

>>> @@ -148,6 +154,9 @@ int elf_ppc64_load(int argc, char **argv
>>>  	else
>>>  		fprintf(stdout, "Warning: append= option is not passed. Using t
> he
>>> first kernel root partition\n");
>>>
>>> +	if (ramdisk && reuse_initrd)
>>> +		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n")
> ;
>>> +
>>
>> This check is generic, not elf specific, so it should be where
>> we pass the args.  Hmm, maybe this is that place and it just
>> wants abstracting, I don't have the tree in front of me.
>
> I put it here so the error's caught independent of the arg parsing
> order.  Otherwise, we'd need to duplicate the check.
>
> I think it's the right place, unless we move it to an arch generic
> option.

I didn't mean as we parse the option, but is there not something
that gets called after we parse all the options?   Maybe that is
just the load function.   I was just thinking it should be in a
sanity_check_args() function that looks for exclusive options like
these rather than in "load a kernel like elf file", although that
is the only current option for ppc64, so it might be ok here.

milton
