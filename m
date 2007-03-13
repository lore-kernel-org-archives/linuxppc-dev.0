Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5984EDDDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 14:04:15 +1100 (EST)
In-Reply-To: <20070312230137.GA8304@keitarou>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<1172518068.15970.6.camel@localhost>
	<20070226222724.GA13182@keitarou>
	<1172558897.11949.43.camel@localhost.localdomain>
	<3ac1a55a11baddefb903f24b988566fe@kernel.crashing.org>
	<1172644987.11949.90.camel@localhost.localdomain>
	<1172657584.3452.51.camel@pmac.infradead.org>
	<1172709056.5852.6.camel@concordia.ozlabs.ibm.com>
	<20070312230137.GA8304@keitarou>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D963EE1E-7B36-4074-95B9-A312D92678EB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Make sure we populate the initroot filesystem late enough
Date: Mon, 12 Mar 2007 22:03:08 -0500
To: Paul TBBle Hampson <Paul.Hampson@Pobox.com>
Cc: torvalds@linux-foundation.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, john stultz <johnstul@us.ibm.com>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 12, 2007, at 6:01 PM, Paul TBBle Hampson wrote:

> On Thu, Mar 01, 2007 at 09:30:56AM +0900, Michael Ellerman wrote:
>> On Wed, 2007-02-28 at 10:13 +0000, David Woodhouse wrote:
>>> On Wed, 2007-02-28 at 07:43 +0100, Benjamin Herrenschmidt wrote:
>>>> I wouldn't be that sure ... I've had problems in the past with  
>>>> PMU based
>>>> cpufreq... looks like flushing all caches and hard-resetting the
>>>> processor on the fly when there can be pending DMAs might be a  
>>>> source of
>>>> trouble... especially on CPUs that don't have working cache  
>>>> flush HW
>>>> assist.
>>>
>>> I've seen it on a PowerMac3,1 (400MHz G4) where we don't have  
>>> cpufreq.
>>> I've also seen it on the latest 1.5GHz Mac Mini, and on my  
>>> shinybook.
>>> They all fall over with the latest kernel, although the shinybook  
>>> only
>>> does so immediately when booted with mem=512M. The shinybook does  
>>> crash
>>> later with new kernels though; I don't yet know why. It could be the
>>> same thing, or it could be something different. That one seemed to
>>> appear between Fedora's 2.6.19-1.2913 and 2.6.19-1.2914 kernels,  
>>> where
>>> we did nothing but turned CONFIG_SYSFS_DEPRECATED on.
>>>
>>> I don't blame cpufreq. At various times I've been equally  
>>> convinced that
>>> it was due to CONFIG_KPROBES, and Linus' initrd-moving patch.
>
>> Is there any pattern to the way it dies? Or is it just randomly  
>> dieing
>> somewhere depending on which config options you have enabled?
>
>> This is starting to sound reminiscent of a bug I chased for a  
>> while last
>> year on Power5, but didn't find. It was "fixed" on some machines by
>> disabling CONFIG_KEXEC, and/or other random unrelated CONFIG options.
>> Unfortunately it magically stopped reproducing so I never caught  
>> it :/
>
> Hmm. The crash came back after I booted into Mac OS X and back. It  
> was however
> a different crash, I believe it was coming from the USB modules (as  
> it would
> keep going when it happened, and get another crash, which tended to  
> scroll away
> too fast for me to capture) but I believe it was still getting down  
> into the
> slab code and actually dying there.
>
> However, reverting the reversion of
> 8d610dd52dd1da696e199e4b4545f33a2a5de5c6 and instead applying
> the following patch:
>
> diff -ru linux-source-2.6.20.orig/arch/powerpc/mm/init_32.c linux- 
> source-2.6.20/arch/powerpc/mm/init_32.c
> --- linux-source-2.6.20.orig/arch/powerpc/mm/init_32.c  2007-02-05  
> 05:44:54.000000000 +1100
> +++ linux-source-2.6.20/arch/powerpc/mm/init_32.c       2007-03-10  
> 11:03:56.000000000 +1100
> @@ -244,7 +244,8 @@
>  void free_initrd_mem(unsigned long start, unsigned long end)
>  {
>         if (start < end)
> -               printk ("Freeing initrd memory: %ldk freed\n", (end  
> - start) >> 10);
> +               printk ("NOT Freeing initrd memory: %ldk freed\n",  
> (end - start) >> 10);
> +       return;
>         for (; start < end; start += PAGE_SIZE) {
>                 ClearPageReserved(virt_to_page(start));
>                 init_page_count(virt_to_page(start));
>
> which if I recall correctly David Woodhouse posted to this thread,
> seems to have fixed it.
>
> I dunno if it's relevant, but my initrd.img is 13193315 bytes long,
> (ie 99 bytes over 12884k) and the above logs:
> "NOT Freeing initrd memory: 12888k freed"
> which makes sense...
>
> I of course completely failed to think to check this with the crashing
> kernel, if it seems relevant I can roll back to it and get the  
> numbers.

Have you tried 2.6.20.2, there was a significant bug in get_order()  
that was deemed to be causing these issues.

- k
