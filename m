Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 7436DDDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 03:03:11 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so598532qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 08:03:09 -0800 (PST)
Date: Thu, 13 Nov 2008 11:03:07 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 11/11] ppc440spe-adma: ADMA driver for PPC440SP(e) systems
Message-ID: <20081113160307.GB2299@yoda.jdub.homelinux.org>
References: <1226589364-5619-1-git-send-email-yanok@emcraft.com>
	<1226589364-5619-12-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1226589364-5619-12-git-send-email-yanok@emcraft.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, wd@denx.de,
	dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 13, 2008 at 06:16:04PM +0300, Ilya Yanok wrote:
> Adds the platform device definitions and the architecture specific support
>routines for the ppc440spe adma driver.
>
> Any board equipped with PPC440SP(e) controller may utilize this driver.
>
>Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
>Signed-off-by: Ilya Yanok <yanok@emcraft.com>

Before I really dig into reviewing this driver, I'm going to ask you as simple
question.  This looks like a 1/2 completed port of an arch/ppc driver that uses
the device tree (incorrectly) to get the interrupt resources and that's about it.
Otherwise, it's just a straight up platform device driver.  Is that correct?

If that is the case, I think the driver needs more work before it can be merged.
It should get the DCR and MMIO resources from the device tree as well.  It should
be binding on compatible properties and not based on device tree paths.  And it
should probably be an of_platform device driver.

(There's also weird stuff like #if 0 code left in, etc).

josh
