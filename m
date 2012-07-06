Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C21642C01B4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2012 02:25:18 +1000 (EST)
Message-ID: <4FF71164.3040501@freescale.com>
Date: Fri, 6 Jul 2012 11:25:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/3] powerpc/e500: add paravirt QEMU platform
References: <20120627235005.GB9100@tyr.buserror.net>
 <36624A62-88AD-404A-A7A8-02D62E8700F0@suse.de>
In-Reply-To: <36624A62-88AD-404A-A7A8-02D62E8700F0@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2012 07:29 AM, Alexander Graf wrote:
> 
> On 28.06.2012, at 01:50, Scott Wood wrote:
> 
>> This gives the kernel a paravirtualized machine to target, without
>> requiring both sides to pretend to be targeting a specific board
>> that likely has little to do with the host in KVM scenarios.  This
>> avoids the need to add new boards to QEMU just to be able to
>> run KVM on new CPUs.
>>
>> As this is the first platform that can run with either e500v2 or
>> e500mc, CONFIG_PPC_E500MC is now a legitimately user configurable
>> option, so add a help text.
>>
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>> ---
>> arch/powerpc/platforms/85xx/Kconfig     |   16 +++++++
>> arch/powerpc/platforms/85xx/Makefile    |    1 +
>> arch/powerpc/platforms/85xx/qemu_e500.c |   66 +++++++++++++++++++++++++++++++
>> arch/powerpc/platforms/Kconfig.cputype  |    4 ++
> 
> I really think we should document what exactly this machine expects.

Well, the point of this paravirt machine is to avoid such assumptions --
it's all device-tree driven, at least in theory.  If a certain qemu
configuration ends up breaking the Linux platform (such as using a
different PIC), then that's a lack of flexibility on Linux's part that
should get fixed if someone finds it useful enough to justify the
effort.  Same with real hardware -- if you care about it, you add
support -- we just don't have a unique name for every configuration.
The information is there in the device tree, though.

Honestly, even having "qemu" in there is more specific than I'd prefer,
but I don't want to stir up the "generic platform" argument again
without at least limiting the scope.

>> +void __init qemu_e500_pic_init(void)
>> +{
>> +	struct mpic *mpic;
>> +
>> +	mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU,
>> +			0, 256, " OpenPIC  ");
> 
> Does that mean we're configuring the MPIC regardless of what the
> guest tells us? So the MPIC is a hard requirement. We can't use UIC
> or XPIC with this machine, right? This needs to be documented.

Then what would we do if we want to add an ePAPR virtual PIC instead?
Or if something replaces MPIC on future FSL chips?

Better to change the Linux implementation as needed than to change a spec.

-Scott
