Return-Path: <arndbergmann@gmail.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vk4dJ6wZdzDqYK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 08:35:00 +1100 (AEDT)
Received: by mail-ot0-x241.google.com with SMTP id x37so4753919ota.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 14:35:00 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <59d8c3d4-1fdf-7f30-f78c-92ddc9028d36@ti.com>
References: <20170315163730.17055-1-afd@ti.com>
 <CAK8P3a1XBUUtJHrzfTa3GRqh+beU+1MteQ0evB8Vvy5zABRbmw@mail.gmail.com>
 <59d8c3d4-1fdf-7f30-f78c-92ddc9028d36@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Mar 2017 22:34:57 +0100
Message-ID: <CAK8P3a3JxkbEyJig3M=Df=W8KDbwZURmfs7YdMWHx_K+2LsEfQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Remove unneeded build directory traversals
To: "Andrew F. Davis" <afd@ti.com>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
 Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Lauro Ramos Venancio <lauro.venancio@openbossa.org>,
 Aloisio Almeida Jr <aloisio.almeida@openbossa.org>,
 Samuel Ortiz <sameo@linux.intel.com>,
 kernel-janitors@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 15, 2017 at 10:15 PM, Andrew F. Davis <afd@ti.com> wrote:
> On 03/15/2017 04:03 PM, Arnd Bergmann wrote:
>> On Wed, Mar 15, 2017 at 5:37 PM, Andrew F. Davis <afd@ti.com> wrote:
>>> Hello all,
>>>
>>> I was building a kernel for x86 and noticed Make still descended into
>>> directories like drivers/gpu/drm/hisilicon, this seems kind of odd given
>>> nothing will be built here. It looks to be due to some directories being
>>> included in obj-y unconditionally instead of only when the relevant
>>> CONFIG_ is set.
>>>
>>> These patches are split by subsystem in-case, for some reason, a file in
>>> a directory does need to be built, I believe I have checked for all
>>> instances of this, but a quick review from some maintainers would be nice.
>>
>> I didn't see anything wrong with the patches, and made sure that there
>> are no tristate symbols controlling the subdirectory for anything that
>> requires a built-in driver (which would cause a link failure).
>>
>> I'm not sure about drivers/lguest, which has some special magic
>> in its Makefile, it's possible that this now fails with CONFIG_LGUEST=m.
>>
>
> lguest and mmc are the strange ones, so I put them last in the series in
> case they did need to be dropped.
>
> lguest was supposed to have been taken from v1:
> https://lkml.org/lkml/2016/6/20/1086
> but it looks like it didn't so I re-introduced it for v3.
>
> mmc caught some 0-day build warnings but I never got to the bottom of them.

Ah, I see now what happened to mmc:

obj-$(subst m,y,$(CONFIG_MMC))  += host/
tmio_mmc_core-$(subst m,y,$(CONFIG_MMC_SDHI))   += tmio_mmc_dma.o
obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))        += sdhci-pci-data.o

with CONFIG_MMC=m, this will fail to build the built-in files in
drivers/mmc/host. I suppose this could be expressed in a different
way these days, but dropping the patch would be easier.

     Arnd
