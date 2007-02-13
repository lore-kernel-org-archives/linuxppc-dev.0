Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 61CDBDDF17
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 04:32:23 +1100 (EST)
Message-ID: <45D1F61B.6020104@am.sony.com>
Date: Tue, 13 Feb 2007 09:32:11 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 19/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
References: <20070212205438.GB17285@ld0162-tx32.am.freescale.net>
	<45D0DE6C.1040207@am.sony.com>
	<20070213161337.GD24815@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070213161337.GD24815@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
>> It may be better to do it like this, as there will be more platforms that
>> need to hook in specific files.
>> 
>> src-plat-$(CONFIG_COMPAT_UIMAGE) += $(cuboot-plats:%=cuboot-%.c)
>> src-plat-$(CONFIG_XXX) += ...
>> src-plat-$(CONFIG_YYY) += ...
>> ...
>> src-plat := of.c $(src-plat-y)
> 
> Take it up with Paul.  He said that all platform files shall always be
> built, and that the wrapper script picks which ones to link.


That is what this sets up, for all platforms the kernel is built to support,
all the corresponding wrapperbits are built.

The problem I see with what you have done is that if there is a single bug in the
wrapperbits for any platform, all zImage builds for ANY platform will fail, even
platforms the kernel is not configured to support.

I think most people only build for a few platforms and would not want to
be inconvenienced buy a bug in a platform they have no interest in, and 
in general, I don't think platform maintainers want to inconvenience people
with platform specific bugs when they are not building for that platform.


>> > +ifeq ($(CONFIG_COMPAT_UIMAGE),y)
>> > +cuboot-plat-$(CONFIG_83xx) += 83xx
>> > +cuboot-plat-$(CONFIG_85xx) += 85xx
>> > +cuboot-plat-$(CONFIG_86xx) += 86xx
>> > +cuboot-plat-y += unknown-platform
>> > +
>> > +$(obj)/uImage: vmlinux $(wrapperbits)
>> > +	$(call cmd,wrap_dt,cuboot-$(word 1,$(cuboot-plat-y)))
>> > +else
>> >  $(obj)/uImage: vmlinux $(wrapperbits)
>> >  	$(call cmd,wrap,uboot)
>> > +endif
>> 
>> It would be nice if you could make the logic such that you don't need this ifeq.
> 
> Do you mean naming the target something other than uImage?

Perhaps.  Do you see any need to build both types with the same kernel config?

-Geoff
