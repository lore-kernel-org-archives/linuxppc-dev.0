Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
 by ozlabs.org (Postfix) with ESMTP id 783C72C007A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 22:34:04 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Chunhe Lan <b25806@freescale.com>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Fri, 21 Sep 2012 12:33:54 +0000
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com>
 <201208101327.47789.arnd@arndb.de> <505CD3A5.6080101@freescale.com>
In-Reply-To: <505CD3A5.6080101@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201209211233.54545.arnd@arndb.de>
Cc: kumar.gala@freescale.com, linux-mmc@vger.kernel.org, cjb@laptop.org,
 linuxppc-dev@lists.ozlabs.org, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 21 September 2012, Chunhe Lan wrote:
> On 08/10/2012 09:27 AM, Arnd Bergmann wrote:
> > On Friday 10 August 2012, Chunhe Lan wrote:
> >
> >       cond_resched();
> >       mdelay(ms);
> >
> > sets off alarm bells, and I would always replace that with msleep().
>      I think that it does not replace with msleep().
>      When the time of sleep is very short, program should not been scheduled
>      in the context. Because it expends the more time.
> 

A time measured in miliseconds is never "very short" for the scheduler,
a lot of things can happen during that time span. The code I quoted
also does not care too much about accuracy, otherwise it would adapt
the time in the mdelay based on whether the cond_resched() actually
schedules to another thread.

	Arnd
