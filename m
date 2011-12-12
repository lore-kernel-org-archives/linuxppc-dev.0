Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F41C31007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 08:30:53 +1100 (EST)
Message-ID: <4EE6725C.3050706@freescale.com>
Date: Mon, 12 Dec 2011 15:30:04 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <dedekind1@gmail.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <4EDEAEB9.6020703@freescale.com> <1323724195.2297.11.camel@koala>
 <4EE66EFE.1050608@freescale.com> <1323724784.2297.20.camel@koala>
In-Reply-To: <1323724784.2297.20.camel@koala>
Content-Type: text/plain; charset="UTF-8"
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, shuo.liu@freescale.com,
 linux-mtd@lists.infradead.org, akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2011 03:19 PM, Artem Bityutskiy wrote:
> On Mon, 2011-12-12 at 15:15 -0600, Scott Wood wrote:
>> NAND chips come from the factory with bad blocks marked at a certain
>> offset into each page.  This offset is normally in the OOB area, but
>> since we change the layout from "4k data, 128 byte oob" to "2k data, 64
>> byte oob, 2k data, 64 byte oob" the marker is no longer in the oob.  On
>> first use we need to migrate the markers so that they are still in the oob.
> 
> Ah, I see, thanks. Are you planning to implement in-kernel migration or
> use a user-space tool?

That's the kind of answer I was hoping to get from Shuo. :-)

Most likely is a firmware-based tool, but I'd like there to be some way
for the tool to mark that this has happened, so that the Linux driver
can refuse to do non-raw accesses to a chip that isn't marked as having
been migrated (or at least yell loudly in the log).

Speaking of raw accesses, these are currently broken in the eLBC
driver... we need some way for the generic layer to tell us what kind of
access it is before the transaction starts, not once it wants to read
out the buffer (unless we add more hacks to delay the start of a read
transaction until first buffer access...).  We'd be better off with a
high-level "read page/write page" function that does the whole thing
(not just buffer access, but command issuance as well).

-Scott
