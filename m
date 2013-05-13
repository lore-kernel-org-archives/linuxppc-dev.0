Return-Path: <Ian.Campbell@citrix.com>
Received: from SMTP.EU.CITRIX.COM (smtp.eu.citrix.com [46.33.159.39])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "Cisco Appliance Demo Certificate",
 Issuer "Cisco Appliance Demo Certificate" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 718642C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 21:59:19 +1000 (EST)
Message-ID: <1368446352.537.81.camel@zakaz.uk.xensource.com>
Subject: Re: [RFC] device-tree.git automatic sync from linux.git
From: Ian Campbell <Ian.Campbell@citrix.com>
To: "monstr@monstr.eu" <monstr@monstr.eu>
Date: Mon, 13 May 2013 12:59:12 +0100
In-Reply-To: <5190900D.5020408@monstr.eu>
References: <1366800525.20256.266.camel@zakaz.uk.xensource.com>
 <5190900D.5020408@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 Arnd Bergmann <arnd@arndb.de>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob
 Herring <rob.herring@calxeda.com>,
 "linux@lists.openrisc.net" <linux@lists.openrisc.net>, Olof
 Johansson <olof@lixom.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-13 at 08:02 +0100, Michal Simek wrote:
> Just small overview it is a Xilinx soft core cpu where you can even setup
> some parameters for core itself - multiplier, divider, BS, fpu, cache sizes, etc.
> You have to also compose the whole system and every platform/configuration is different
> because you can setup addresses, IP on the bus, IRQs, etc.
> Based on this configuration we have created tcl script which is able to generate
> DTS directly from Xilinx design tool and it is working quite well for several years
> and everybody just use it without any problem.

That sounds very neat!

Does this tcl script live in the kernel tree? If so would you think it
would make sense for it to also migrate to device-tree.git? I'm not at
all sure if that makes sense but if you think it does please let me know
which paths need top be carried over.

> As you see in your repo there is only one microblaze DTS which is for one of mine
> ancient configuration which none used.
> It means from microblaze point of view we can simple remove it from mainline kernel
> because it is useless.

That will then naturally get propagated over to device-tree.git.

> I also care about arm zynq platform where situation is partially different because
> zynq is fixed block but you can add others thing to programmable logic.
> It means for zynq case we are almost in the same situation where every zynq based
> platform is using different configuration and that's why fpgas are so great.
> 
> It means for zynq case everybody will need different DTS but will be just good
> to describe or show binding.
> Currently we have just one dts for zc702 xilinx reference board.
> 
> Let's move to my point.
> Based on our experience all xilinx boards don't depend on any dts in the linux kernel
> and our users just understand the reason why they should use our tcl script for
> DTS generation.
> 
> Back to your point about moving DTSes out of the kernel.

I suppose you are now commenting on the Phase II bit where maintenance
of the DTS moves out of linux.git into device-tree.git, rather than
Phase I work, which is creating a split repo which is automatically
synchronised from linux.git but maintenance remains in linux.git, i.e.
what I'm doing here.

>  For microblaze - no problem
> just do it. For arm zynq this is more problematic because there is weird binding
> for ARM. For example PMU which is out of bus and should be probably in cpu node.
> Also scu devices, scutimers, watchdog which lie on the bus for our case and we
> need to use PPI interrupt cpu mask. Different clock binding, maybe pinmux binding, etc.
> 
> It means from my point of view if binding is correct, no problem to move it
> out of the kernel. If a kernel patch change binding, it is worth for me to change
> dts in the kernel too to reflect this change and track this change too.
> My proposal is, let's clean all DTSes in the arm kernel that all platform use
> the same binding where all platforms are just correctly described.

AIUI this split/move isn't intended to change the existing policy, which
is already that DTS files are supposed to remain compatible across
kernel versions and that "flag days" are to be avoided. The split is
supposed to make it harder (if not impossible) to accidentally break
that policy.

On the other hand I suppose there is an argument to be made for clearing
up the cruft *before* making the split.

Ultimately I think this will be up to Grant & co.

> The reaching this point I would suggest that for arm, arm-soc maintainers should
> keep eyes on any dts binding change and all these changes require ACK from Rob or Grant
> (like device-tree maintainers).

Yes, once we move onto Phase II I don't expect it will end up being me
that is the DTS maintainer -- I expect the maintenance will remain with
those who take care of it in linux.git today.

My involvement in Phase I is really just to help out with the transition
(ulterior motive: the Xen project would also like to use these DTS
files...) not to perform a "land grab" or take over maintenance etc. I
certainly don't think I am the right person to become the long term
maintainer of device-tree.git!

Ian.
