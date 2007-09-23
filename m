Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id BCE7CDDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Sep 2007 01:32:27 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1067695rvf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 23 Sep 2007 08:32:26 -0700 (PDT)
Message-ID: <fa686aa40709230832m1d4a083ao2e43b57cc39e088@mail.gmail.com>
Date: Sun, 23 Sep 2007 09:32:25 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Miroslaw Dach" <miroslaw.dach@psi.ch>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <Pine.LNX.4.44.0709231519510.25165-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.44.0709231519510.25165-100000@slslc02.psi.ch>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/23/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> Hi Grant,
>
> Thank you very much for your advices which were very valuable for me.
>
> Recently I have followed your advice to move from kernel 2.6.21 to the
> higher one in order to have the possibility to boot the kernel from
> u-boot. I have copied across from you git tree the latest version of linux
> kernel 2.6.23 rc-2.
>
> It compiles successfully with some warnings like below:
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x223c): Section mismatch: reference to .init.text:early_init (between 'start_here' and 'initial_mmu')
> WARNING: vmlinux.o(.text+0x2254): Section mismatch: reference to .init.text:machine_init (between 'start_here' and 'initial_mmu')
> WARNING: vmlinux.o(.text+0x2258): Section mismatch: reference to .init.text:MMU_init (between 'start_here' and 'initial_mmu')
> WARNING: vmlinux.o(.text+0x22b2): Section mismatch: reference to .init.text:start_kernel (between 'start_here' and 'initial_mmu')
> WARNING: vmlinux.o(.text+0x22b6): Section mismatch: reference to .init.text:start_kernel (between 'start_here' and 'initial_mmu')
>    LD      vmlinux

Yes, I see this warning too.  I haven't had a chance to debug it.
>
>
> My observation is that the linux 2.6.23 rc-2 is not that stable as 2.6.21.
> In most cases It boots successfully (ie. zImage.elf) but occasionally it
> fails during booting. It has never occurred with 2.6.21 which I also
> copied from your side.

Hmm, what failure mode are you seeing?  I haven't experienced that
problem.  However, -rc7 is now out, so I'd recommend moving up to it.
(Hint: use git to make it easy to pull the latest version and either
'quilt' or 'stgit' to manage your changes on top of the mainline tree;
it will make up/downgrading to different kernel version much easier)

> Second question:
>
> In addition I wanted to ask you about u-boot tree which you have mentioned
> in the post on u-boot mailing list. This post was about uart lite for
> ml403 in u-boot.
>
> I was not able to find the project which you have mentioned there:
> git://git.secretlab.ca/git/u-boot.git

That's because there is not such tree.  :-)  I retired that tree a
while ago because it's no longer current.  You can use the mainline
u-boot tree:

git://www.denx.de/git/u-boot.git

>
> This what interests me in particular concerning u-boot is the uart lite
> and temac interfaces from ml403.

:-(  I don't think either uartlite or temac drivers has been ported to u-boot.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
