Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews07.kpnxchange.com (cpsmtpb-ews07.kpnxchange.com
 [213.75.39.10])
 by lists.ozlabs.org (Postfix) with ESMTP id 448961A0360
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jan 2015 04:02:37 +1100 (AEDT)
Message-ID: <1422118156.27947.7.camel@x220>
Subject: Re: [PATCH 0/4] defconfigs: cleanup obsolete MTD configs
From: Paul Bolle <pebolle@tiscali.nl>
To: Semen Protsenko <semen.protsenko@globallogic.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Sat, 24 Jan 2015 17:49:16 +0100
In-Reply-To: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
References: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, Brian Norris <computersforpeace@gmail.com>,
 Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linux-mtd@lists.infradead.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-01-24 at 18:33 +0200, Semen Protsenko wrote:
> This patch series removes next obsolete MTD configs from all defconfig files:
>   - CONFIG_MTD_CHAR
>   - CONFIG_MTD_CONCAT
>   - CONFIG_MTD_DEBUG
>   - CONFIG_MTD_DEBUG_VERBOSE
>   - CONFIG_MTD_PARTITIONS
> 
> All those configs were removed from drivers/mtd/Kconfig earlier, but their usage
> in defconfig files was remain unnoticed. There are at least two obvious reasons
> to get rid of those configs:
>   1. Their usage may cause to build warnings

That's news for me. I thought they are silently ignored. Do you have an
example of such a warning?

>   2. Their usage may confuse someone who is grepping defconfig files to get
>      the clue what MTD configuration may look like.
> 
> This series is harmless for all those defconfigs and will not break anything.
> 
> 
> Semen Protsenko (4):
>   defconfigs: remove CONFIG_MTD_CONCAT
>   defconfigs: remove CONFIG_MTD_PARTITIONS
>   defconfigs: remove CONFIG_MTD_CHAR
>   defconfigs: remove CONFIG_MTD_DEBUG*
> 
>  arch/arm/configs/acs5k_defconfig                   |    3 ---
> [...]
>  arch/unicore32/configs/unicore32_defconfig         |    2 --
>  226 files changed, 364 deletions(-)

Seems like the kind of change that can only be reviewed by a script.

Is there any policy on keeping defconfig files up to date? Because, only
slightly exaggerated, all the defconfig files are outdated, in minor or
major ways, at any given moment.

I seem to remember Greg stating that defconfig files are on their way
out. Did I remember that correctly?  


Paul Bolle
