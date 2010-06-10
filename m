Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276150663.1962.43.camel@pasglop>
References: <20100608142152.26088.1108.stgit@angua>
	<20100608142643.26088.61366.stgit@angua>
	<20100608155702.GA5419@oksana.dev.rtsoft.ru>
	<AANLkTinZT4z93SWxjce5oRZzmaQHtVnO96zsXO9OX2UZ@mail.gmail.com>
	<20100608164645.GA15216@oksana.dev.rtsoft.ru>
	<AANLkTinHH-YhdWpH60Z2BYsiEjzLb_imrk6KUmQRH07P@mail.gmail.com>
	<20100608194809.GA32732@oksana.dev.rtsoft.ru>
	<1276150663.1962.43.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 08:18:19 -0600
Message-ID: <AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 12:17 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
>> You just introduced an unnamed structure of device + resources,
>> it isn't declared anywhere but in the code itself (either via
>> &foo[1] or buf + sizeof(*foo)).
>>
>> You're not the only one who hacks (or at least have to
>> understand) the OF stuff, so let's try keep this stuff
>> readable?
>>
>> I told you several ways of how to improve the code (based on
>> the ideas from drivers/base/, so the ideas aren't even mine,
>> fwiw).
>
> I tend to agree with Anton here.

The reason I'm confident doing it that way is that it is *not* a
structure.  There is no structure relationship between the resource
table and the platform_device other than they are allocated with the
same kzalloc() call.  All the code that cares about that is contained
within 4 lines of code.  I'm resistant to using a structure because it
is adds an additional 5-6 lines of code to add a structure that won't
be used anywhere else, and is only 4 lines to begin with.

> BTW. Why not make of_device a wrapper (or even alias of)
> platform_device ? :-) That way you get the resource array etc.. for free
> and it will make the whole of_device vs. platform_device issue moot.

of_device is an alias of platform_device now.  The resource array in
platform devices is not statically defined.  It is allocated
separately.  I can't currently use the platform_device_alloc code
which does separate deallocation because the OF code needs its own
release hook to put the node.  OTOH, I can probably change the guts of
of_release_dev() to be called by platform_device_release().

okay, I'll try changing this an see how it looks.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
