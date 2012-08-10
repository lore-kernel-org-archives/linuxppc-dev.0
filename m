Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
 by ozlabs.org (Postfix) with ESMTP id 73CCE2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 23:27:56 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Fri, 10 Aug 2012 13:27:47 +0000
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com>
In-Reply-To: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201208101327.47789.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com, cjb@laptop.org,
 linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 10 August 2012, Chunhe Lan wrote:

> +static inline void mmc_delay(unsigned int ms)
> +{
> +	if (ms < 1000 / HZ) {
> +		cond_resched();
> +		mdelay(ms);
> +	} else {
> +		msleep(ms);
> +	}
> +}

I would actually question the point in this function to start with: The
decision whether to call mdelay() or msleep() should only be based on
whether you are allowed to sleep in the caller context. The idea of


	cond_resched();
	mdelay(ms);

sets off alarm bells, and I would always replace that with msleep().

	Arnd
