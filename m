Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9E4DCB70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 04:41:41 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 340A5DDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 04:41:40 +1000 (EST)
Date: Fri, 7 Aug 2009 22:41:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] sdhci-of: Some fixes for high-speed and 4-bit SD cards
Message-ID: <20090807184138.GA22322@oksana.dev.rtsoft.ru>
References: <20090807163940.GA29192@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090807163940.GA29192@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Ben Dooks <ben@fluff.org>,
	Pierre Ossman <pierre@ossman.eu>, linux-kernel@vger.kernel.org,
	sdhci-devel@lists.ossman.eu
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2009 at 08:39:40PM +0400, Anton Vorontsov wrote:
> Hi all,
> 
> Finally I've got a bunch of SD cards to test eSDHC in various ways,
> and more importantly now I have a lot of SDHS cards. ;-)
> 
> So, here are few fixes that make eSDHC work flawlessly on MPC83xx
> SOCs with all SD and MMC cards that I have.
> 
> On MPC85xx (namely MPC8536 and MPC8569) SOCs there is one issue:
> the cards can be detected and read just fine, but writing doesn't
> work (no interrupts received). I'm currently investigating this.

Solved. It appears that eSDHC on MPC85xx has a normal write-protect
reporting. And eSDHC actually checks the WP pin, thus doesn't let
anybody to do any writes... I'll make some additional patches and
will send v2 soon.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
