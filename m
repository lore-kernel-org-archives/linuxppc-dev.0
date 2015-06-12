Return-Path: <B18196@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0104.outbound.protection.outlook.com [157.56.110.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1B781A0689
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 17:53:22 +1000 (AEST)
Message-ID: <557A8FF5.10709@freescale.com>
Date: Fri, 12 Jun 2015 10:53:25 +0300
From: Cristian Stoica <cristian.stoica@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <horia.geanta@freescale.com>
Subject: Re: [PATCH v2] powerpc: support sizes greater than an unsigned long
References: <1431620684-20123-1-git-send-email-cristian.stoica@freescale.com>
 <1431683064-29584-1-git-send-email-cristian.stoica@freescale.com>
 <55799E38.1000004@freescale.com> <20150611153835.GB5058@kroah.com>
 <5579B2FC.4010008@freescale.com> <1434058075.2477.178.camel@freescale.com>
In-Reply-To: <1434058075.2477.178.camel@freescale.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/2015 12:27 AM, Scott Wood wrote:
> Dropping the upper bits of the size harms the ability to detect error 
> scenarios where unmappably large -- but not power-of-two -- regions 
> are requested to be mapped.
> 
> However, this patch doesn't fix that.  It just postpones the loss of 
> the upper 32 bits until __ioremap_caller() calls get_vm_area_caller().
>
> There's also no error checking at all for the size of ioremap() done 
> during early boot (!slab_is_available()).

Thanks for the explanation. I'll have a another look at the code.

> Don't just blindly turn static analyzer reports into patches -- and 
> why didn't the analyzer complain about the call to 
> get_vm_area_caller() after this patch?

The analysis that lead to this patch was targeted to a specific driver - in hindsight this is probably not the best
approach.

Cristian S.
