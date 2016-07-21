Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwMrT16ybzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 04:34:32 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Scott Wood <oss@buserror.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Thu, 21 Jul 2016 20:34:12 +0200
Message-ID: <3917663.1nRrfqKY9D@wuerfel>
In-Reply-To: <1469119526.25630.42.camel@buserror.net>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
 <146909676646.16700.8383344640490662952@concordia>
 <1469119526.25630.42.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, July 21, 2016 11:45:26 AM CEST Scott Wood wrote:
> 
> For the MMC issue I suggest using ifdef CONFIG_PPC and mfspr(SPRN_SVR) like
> the clock driver does[1] and we can revisit the issue if/when we need to do
> something similar on an ARM chip.

That sounds ok to me. having an mfspr check isn't nice but does the
job to work around existing bindings. For future chips, we can hopefully
find a way to identify most quirks early enough that the DT binding
can describe them using distinct compatible strings or other properties,
if necessary with the help of the boot loader.

Some other folks on MIPS were interested in having the soc_device
matching infrastructure and contacted me off-list, but they can of
course take the patch I sent and work from that.

	Arnd
