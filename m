Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHwSt4GVTzDsqk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 16:10:38 +1100 (AEDT)
Message-ID: <1479186624.21746.15.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-kernel@vger.kernel.org
Cc: Yangbo Lu <yangbo.lu@nxp.com>, Arnd Bergmann <arnd@arndb.de>, Ulf
 Hansson <ulf.hansson@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 14 Nov 2016 23:10:24 -0600
In-Reply-To: <20161113190302.18099-4-paul.gortmaker@windriver.com>
References: <20161113190302.18099-1-paul.gortmaker@windriver.com>
 <20161113190302.18099-4-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 3/3] soc: fsl: make guts driver explicitly non-modular
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-11-13 at 14:03 -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/soc/fsl/Kconfig:config FSL_GUTS
> drivers/soc/fsl/Kconfig:        bool
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
> 
> Since the code was already not using module_init, the init ordering
> remains unchanged with this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> Cc: Scott Wood <oss@buserror.net>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Scott Wood <oss@buserror.net>

-Scott
