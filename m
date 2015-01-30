Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5A731A12EC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 08:53:15 +1100 (AEDT)
Message-ID: <1422654781.10544.173.camel@freescale.com>
Subject: Re: [PATCH] powerpc/mm: bail out early when flushing TLB page
From: Scott Wood <scottwood@freescale.com>
To: Arseny Solokha <asolokha@kb.kras.ru>
Date: Fri, 30 Jan 2015 15:53:01 -0600
In-Reply-To: <1422619707-30864-1-git-send-email-asolokha@kb.kras.ru>
References: <1422619707-30864-1-git-send-email-asolokha@kb.kras.ru>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-01-30 at 19:08 +0700, Arseny Solokha wrote:
> MMU_NO_CONTEXT is conditionally defined as 0 or (unsigned int)-1.

For nohash it is specifically -1.

>  However, in __flush_tlb_page() a corresponding variable is only tested
> for open coded 0, which can cause NULL pointer dereference if `mm'
> argument was legitimately passed as such.
> 
> Bail out early in case the first argument is NULL, thus eliminate confusion
> between different values of MMU_NO_CONTEXT and avoid disabling and then
> re-enabling preemption unnecessarily.

How did you notice this?  Did you see an oops, or was it code
inspection?  I'm wondering what codepath gets here with mm == NULL.

-Scott
