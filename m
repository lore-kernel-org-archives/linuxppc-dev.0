Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0101.outbound.protection.outlook.com [65.55.169.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0B6D1A066A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 08:17:30 +1000 (AEST)
Message-ID: <1430777837.16357.227.camel@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: fix the dependency issue for CRASH_DUMP
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 4 May 2015 17:17:17 -0500
In-Reply-To: <1430396997-14656-2-git-send-email-haokexin@gmail.com>
References: <1430396997-14656-1-git-send-email-haokexin@gmail.com>
 <1430396997-14656-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-30 at 20:29 +0800, Kevin Hao wrote:
> In the current code, the RELOCATABLE will be forcedly enabled when
> enabling CRASH_DUMP. But for ppc32, the RELOCABLE also depend on
> ADVANCED_OPTIONS and select NONSTATIC_KERNEL. This will cause build
> error when CRASH_DUMP=y && ADVANCED_OPTIONS=n. Even there is no such
> issue for ppc64, but select is only for non-visible symbols and for
> symbols with no dependencies. As for a symbol like RELOCATABLE, it is
> definitely not suitable to select it. So choose to depend on it.

Why is it "definitely not suitable to select it", provided the
ADVANCED_OPTIONS dependency is removed, and the FLATMEM dependency is
moved to places that select RELOCATABLE?  It seems wrong that the user
should have to enable ADVANCED_OPTIONS to even see the option to build a
crash kernel.

-Scott
