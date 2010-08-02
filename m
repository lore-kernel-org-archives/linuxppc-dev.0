Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by ozlabs.org (Postfix) with ESMTP id 2B7601007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  2 Aug 2010 23:49:02 +1000 (EST)
Received: by bwz4 with SMTP id 4so1893930bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 02 Aug 2010 06:48:59 -0700 (PDT)
Date: Mon, 2 Aug 2010 17:48:57 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Atul Deshmukh <atulsdeshmukh@gmail.com>
Subject: Re: Issues to access Compact Flash Card on MPC8360E
Message-ID: <20100802134857.GA8689@oksana.dev.rtsoft.ru>
References: <AANLkTi=ke8Yiy39dONFkMPpm5H8vhRy1jVyaKLuG8r4e@mail.gmail.com>
	<AANLkTikGL6LKJyWjK946enVwkUzviOsHasYbzV1Wj2LR@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTikGL6LKJyWjK946enVwkUzviOsHasYbzV1Wj2LR@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 02, 2010 at 06:08:14PM +0530, Atul Deshmukh wrote:
[...]
> 2: To access CF card in True IDE mode we have to use
> "linux-kernel-source/drivers/ata/pata_platform.c" and
> "linux-kernel-source/drivers/ata/libata-sff.c".....I'm going right??

CF IDE support was already implemented for MPC8349EmITX boards
with a bit of help from UPM (User-Programmable Machine), so
you can do the same for MPC8360.

UPM is programmed in U-Boot, u-boot/include/configs/MPC8349ITX.h
(CONFIG_SYS_BR3_PRELIM stuff), and
u-boot/board/freescale/mpc8349itx/mpc8349itx.c (UPMATable).

For linux part, see arch/powerpc/boot/dts/mpc8349emitx.dts (pata
node), and drivers/ata/pata_of_platform.c.

For HW side, you can find MPC8349EmITX schematics on Freescale
site (last time I checked, no registration was required).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
