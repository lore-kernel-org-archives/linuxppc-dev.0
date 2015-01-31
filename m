Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BF221A0E53
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 15:19:35 +1100 (AEDT)
Message-ID: <54CC579D.1070709@kb.kras.ru>
Date: Sat, 31 Jan 2015 11:18:37 +0700
From: Arseny Solokha <asolokha@kb.kras.ru>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/mm: bail out early when flushing TLB page
References: <1422619707-30864-1-git-send-email-asolokha@kb.kras.ru>
 <1422654781.10544.173.camel@freescale.com>
In-Reply-To: <1422654781.10544.173.camel@freescale.com>
Content-Type: text/plain; charset=utf-8
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

> On Fri, 2015-01-30 at 19:08 +0700, Arseny Solokha wrote:
>> MMU_NO_CONTEXT is conditionally defined as 0 or (unsigned int)-1.
>
> For nohash it is specifically -1.

>>  However, in __flush_tlb_page() a corresponding variable is only tested
>> for open coded 0, which can cause NULL pointer dereference if `mm'
>> argument was legitimately passed as such.
>>
>> Bail out early in case the first argument is NULL, thus eliminate confusion
>> between different values of MMU_NO_CONTEXT and avoid disabling and then
>> re-enabling preemption unnecessarily.
>
> How did you notice this?  Did you see an oops, or was it code
> inspection?  I'm wondering what codepath gets here with mm == NULL.

Just a code inspection. It didn't seemed right at the first glance.

Arsény


>
> -Scott
