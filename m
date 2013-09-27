Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5EEEE2C019C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 07:44:02 +1000 (EST)
Message-ID: <1380318232.24959.495.camel@snotra.buserror.net>
Subject: Re: [PATCH v4] powerpc 8xx: Fixing issue with CONFIG_PIN_TLB
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Fri, 27 Sep 2013 16:43:52 -0500
In-Reply-To: <201309240818.r8O8IdF9016374@localhost.localdomain>
References: <201309240818.r8O8IdF9016374@localhost.localdomain>
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

On Tue, 2013-09-24 at 10:18 +0200, Christophe Leroy wrote:
> Activating CONFIG_PIN_TLB is supposed to pin the IMMR and the first three
> 8Mbytes pages. But the setting of MD_CTR to a pinnable entry was missing before
> the pinning of the third 8Mb page. As the index is decremented module 28
> (MD_RSV4D is set) after every DTLB update, the third 8Mbytes page was
> not pinned.

The examples you showed weren't quite modulo 28, more like "if (x >= 28)
x -= 4".  I'll fix up the changelog on applying, to read something like
"As the index is decremented to a value within the first 28 entries
(MD_RSV4D is set)...".

-Scott
