Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail123-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D4079DDF75
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 08:00:16 +1100 (EST)
Message-ID: <4755BFCB.9010502@am.sony.com>
Date: Tue, 04 Dec 2007 12:59:55 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH v2 2/2] [POWERPC] Use new machine_xxx_initcall hooks in
	platform code
References: <20071202061028.21193.39309.stgit@trillian.secretlab.ca>
	<20071202061033.21193.64818.stgit@trillian.secretlab.ca>
	<Pine.LNX.4.62.0712041320250.12181@pademelon.sonytel.be>
	<fa686aa40712040536h18bd60d3xf89af1f89f6a92ad@mail.gmail.com>
	<Pine.LNX.4.62.0712041442530.12181@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0712041442530.12181@pademelon.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> On Tue, 4 Dec 2007, Grant Likely wrote:
>> On 12/4/07, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
>> > On Sat, 1 Dec 2007, Grant Likely wrote:
>> > > From: Grant Likely <grant.likely@secretlab.ca>
>> > >
>> > > This patch makes the platform code use the new machine-specific initcall
>> > > hooks.  This has the advantage of not needing to explicitly test
>> > > machine_is() at the top of every initcall function.
>> >
>> > You seem to have missed the PS3 *_initcall()s.
>> > Probably because they test for firmware_has_feature(FW_FEATURE_PS3_LV1) instead
>> > of machine_is(ps3).
>> 
>> That's exactly why; I didn't know if 'machine_is(ps3)' was a suitable
>> substitute so I left it alone.
> 
> I think it's OK. But...
> 
> Geoff: is there any specific reason why you used
> firmware_has_feature(FW_FEATURE_PS3_LV1)?

As Arnd pointed out, the code in the firmware_has_feature() conditional
will be removed by the optimizer when the kernel is built without support
for that feature.  This then gives a multi-platform binary that has only
the code for the sub-set of features the user selected. 

-Geoff 
