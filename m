Return-Path: <imp@bsdimp.com>
Received: from harmony.bsdimp.com (bsdimp.com [199.45.160.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EDC831007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 01:23:47 +1000 (EST)
Date: Thu, 10 Jun 2010 09:13:57 -0600 (MDT)
Message-Id: <20100610.091357.513168276793712624.imp@bsdimp.com>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>
References: <20100608194809.GA32732@oksana.dev.rtsoft.ru>
	<1276150663.1962.43.camel@pasglop>
	<AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message: <AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>
            Grant Likely <grant.likely@secretlab.ca> writes:
: On Thu, Jun 10, 2010 at 12:17 AM, Benjamin Herrenschmidt
: <benh@kernel.crashing.org> wrote:
: >
: >> You just introduced an unnamed structure of device + resources,
: >> it isn't declared anywhere but in the code itself (either via
: >> &foo[1] or buf + sizeof(*foo)).
: >>
: >> You're not the only one who hacks (or at least have to
: >> understand) the OF stuff, so let's try keep this stuff
: >> readable?
: >>
: >> I told you several ways of how to improve the code (based on
: >> the ideas from drivers/base/, so the ideas aren't even mine,
: >> fwiw).
: >
: > I tend to agree with Anton here.
: 
: The reason I'm confident doing it that way is that it is *not* a
: structure.  There is no structure relationship between the resource
: table and the platform_device other than they are allocated with the
: same kzalloc() call.  All the code that cares about that is contained
: within 4 lines of code.  I'm resistant to using a structure because it
: is adds an additional 5-6 lines of code to add a structure that won't
: be used anywhere else, and is only 4 lines to begin with.

I tend to agree with Grant here.  The idiom he's using is very wide
spread in the industry and works extremely well.  It keeps the
ugliness confined to a couple of lines and is less ugly than the
alternatives for this design pattern.  It is a little surprising when
you see the code the first time, granted, but I think its expressive
power trumps that small surprise.

Warner
