Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f227.google.com (mail-ew0-f227.google.com
	[209.85.219.227]) by ozlabs.org (Postfix) with ESMTP id 59321B7043
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 09:40:20 +1000 (EST)
Received: by ewy27 with SMTP id 27so256475ewy.40
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 16:40:19 -0700 (PDT)
Date: Wed, 23 Sep 2009 03:40:16 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mtd: m25p80: Add support for CAT25xxx serial EEPROMs
Message-ID: <20090922234016.GA1021@oksana.dev.rtsoft.ru>
References: <20090818214449.GA12848@oksana.dev.rtsoft.ru>
	<20090818214628.GB22651@oksana.dev.rtsoft.ru>
	<20090922162548.3e20e67c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090922162548.3e20e67c.akpm@linux-foundation.org>
Cc: dbrownell@users.sourceforge.net, dedekind1@gmail.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, dwmw2@infradead.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2009 at 04:25:48PM -0700, Andrew Morton wrote:
> On Wed, 19 Aug 2009 01:46:28 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > CAT25 chips (as manufactured by On Semiconductor, previously Catalyst
> > Semiconductor) are similar to the original M25Px0 chips, except:
> > 
> > - Address width can vary (1-2 bytes, in contrast to 3 bytes in M25P
> >   chips). So, implement convenient m25p_addr2cmd() and m25p_cmdsz()
> >   calls, and place address width information into flash_info struct;
> > 
> > - Page size can vary, therefore we shouldn't hardcode it, so get rid
> >   of FLASH_PAGESIZE definition, and place the page size information
> >   into flash_info struct;
> > 
> > - CAT25 EEPROMs don't need to be erased, so add NO_ERASE flag, and
> >   propagate it to the mtd subsystem.
> 
> This patch (still) doesn't know about the mx25l3205d, mx25l12805d and
> mx25l12855e devices.

Yes, support for these chips commited on Fri, 4 Sep 2009 08:40:27
+0000 (09:40 +0100). And the patch dated 19 Aug.

> I randomly did this:
> 
> ->	{ "mx25l3205d", INFO(0xc22016, 0, 64 * 1024, 64, 256, 3, 0) },
> ->	{ "mx25l6405d", INFO(0xc22017, 0, 64 * 1024, 128, 256, 3, 0) },
> 	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 256, 3, 0) },
> ->	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 256, 3, 0) },

Looks correct, thanks a lot.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
