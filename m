Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id B2DE5DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 06:36:34 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 2/2] [POWERPC] Use new machine_xxx_initcall hooks in
	platform code
Date: Tue, 4 Dec 2007 20:35:59 +0100
References: <20071202061028.21193.39309.stgit@trillian.secretlab.ca>
	<fa686aa40712040536h18bd60d3xf89af1f89f6a92ad@mail.gmail.com>
	<fa686aa40712040621r3103bae9hd900c23d48273360@mail.gmail.com>
In-Reply-To: <fa686aa40712040621r3103bae9hd900c23d48273360@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712042036.00785.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 December 2007, Grant Likely wrote:
> On 12/4/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On 12/4/07, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > > You seem to have missed the PS3 *_initcall()s.
> > > Probably because they test for firmware_has_feature(FW_FEATURE_PS3_LV1) instead
> > > of machine_is(ps3).
> >
> > That's exactly why; I didn't know if 'machine_is(ps3)' was a suitable
> > substitute so I left it alone.
> 
> On that topic; I left some pseries and iseries stuff alone also for
> the same reason.

Yes, and in many cases it's the right answer to base a decision on a specific
feature rather than a platform name, for two reasons:

1. If another platform gets added that uses the same firmware feature, it
will automatically do the right thing.

2. The call to firmware_has_feature() turns into a compile-time check in
many cases, so if the kernel does not contain support for any firmware
with the given feature, all the code referenced it can get optimized
away by the compiler.

If we have many cases where an initcall is done based on a specific fw-feature
or cpu-feature, we might want to add a similar initcall mechanism for those
along the lines of machine_xxx_initcall, but of course we should be sure
not to overengineer things here.

	Arnd <><
