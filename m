Message-Id: <5.1.0.14.2.20030219004853.00b12e08@mail.ebshome.net>
Date: Wed, 19 Feb 2003 00:54:45 -0800
To: "Laurent Mohin" <laurent.mohin@acterna.com>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: 405GPr support in linux2.4.18
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <OFA7B6F432.6CF96B48-ONC1256CD1.00372BF7@eng.eni.wago.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 02:11 AM 2/18/2003, Laurent Mohin wrote:
>I'm designing a board with 405GP processor. I'm now trying to have it
>working with a 405GPr version.
>I've started to configure it working in legacy mode and made the necessary
>changes in PPCBoot.
>
>Once downloaded, my kernel hung in early_init function when it called the
>memset_io to zero the BSS. Using a BDI2000 debugger, I saw that I've
>reached the bad_page_fault function.
>
>The only difference I know between 405GP and 405GPr in legacy mode is data
>cache size. How does the kernel manage it?

We successfully run 405GPr based board (in legacy mode) with the _same_
kernel we used for 405GP.
We don't use any 405GPr specific features though.

As far as I understand, the only function which depends on the data cache
size is flush_dcache_all in (arch/ppc/kernel/misc.S).
But it already handles the worst case which is 440GP (32K), so no change is
needed for 405GPr.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
