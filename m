Return-Path: <jogo@openwrt.org>
Received: from arrakis.dune.hu (arrakis.dune.hu [78.24.191.176])
 (using TLSv1.1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7A4E1A03A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 06:52:00 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
 by arrakis.dune.hu (Postfix) with ESMTP id ECC6F28092B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 22:45:31 +0200 (CEST)
Received: from mail-qk0-f171.google.com (mail-qk0-f171.google.com
 [209.85.220.171])
 by arrakis.dune.hu (Postfix) with ESMTPSA id 79FFD280463
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 22:45:28 +0200 (CEST)
Received: by qkhg7 with SMTP id g7so238319515qkh.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 13:46:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150422141721.D3F8C1A242E@localhost.localdomain>
References: <20150422141721.D3F8C1A242E@localhost.localdomain>
From: Jonas Gorski <jogo@openwrt.org>
Date: Wed, 22 Apr 2015 22:46:05 +0200
Message-ID: <CAOiHx==hwBGsYwT6MFV-ur=wnnUmqw_GF7sN8KOwUho3fz5uew@mail.gmail.com>
Subject: Re: [PATCH v2] spi: fsl-spi: use of_iomap() to map parameter ram on
 CPM1
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,

On Wed, Apr 22, 2015 at 4:17 PM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> On CPM2, the SPI parameter RAM is dynamically allocated in the
> dualport RAM whereas in CPM1, it is statically allocated to a default
> address with capability to relocate it somewhere else via the use of
> CPM micropatch. The address of the parameter RAM is given by the boot
> loader and expected to be mapped via of_iomap()
>
> In the current implementation, in function fsl_spi_cpm_get_pram()
> there is a confusion between the SPI_BASE register and the base of the
> SPI parameter RAM. Fortunatly, it is working properly with MPC866 and
> MPC885 because they do set SPI_BASE, but on MPC860 and other old
> MPC8xx that doesn't set SPI_BASE, pram_ofs is not properly set.
> Also, the parameter RAM is not properly mapped with of_iomap() as it
> should but still gets accessible by chance through the full RAM which
> is mapped from somewhere else.
>
> This patch applies to the SPI driver the same principle as for the
> CPM UART: when the CPM is of type CPM1, we simply do an of_iomap() of
> the area provided via the device tree.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> ---
>  v2: Use devm_ioremap_resource() instead of_iomap()

Your subject and commitlog still talk about using of_iomap(), you need
to update them too.


Regards
Jonas
