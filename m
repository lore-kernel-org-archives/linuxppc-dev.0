Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0C93EB700B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 05:42:27 +1100 (EST)
Message-ID: <4EEF858C.1070600@freescale.com>
Date: Mon, 19 Dec 2011 12:42:20 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <dedekind1@gmail.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <4EDEAEB9.6020703@freescale.com> <1323724195.2297.11.camel@koala>
 <4EE66EFE.1050608@freescale.com> <1323724784.2297.20.camel@koala>
 <4EE6725C.3050706@freescale.com>
 <1324132520.4240.26.camel@sauron.fi.intel.com>
 <4EEF849B.7030804@freescale.com>
In-Reply-To: <4EEF849B.7030804@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Artem.Bityutskiy@nokia.com, dwmw2@infradead.org,
 linux-kernel@vger.kernel.org, shuo.liu@freescale.com,
 linux-mtd@lists.infradead.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/19/2011 12:38 PM, Scott Wood wrote:
> On 12/17/2011 08:35 AM, Artem Bityutskiy wrote:
>> It looks like currently you can re-define chip->read_page, so I guess
>> you should rework MTD and make chip->write_page re-definable?
> 
> Unless something has changed very recently, there is no chip->read_page
> or chip->write_page.  There is chip->ecc.read_page and
> chip->ecc.write_page, but they are too low-level.  What we'd need to
> replace is a portion of nand_do_read_ops()/nand_do_write_ops().

Sorry, chip->write_page does exist -- it's chip->read_page that would
need to be made similarly redefinable.

-Scott
