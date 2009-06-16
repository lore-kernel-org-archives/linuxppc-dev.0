Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AE4E0B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 02:40:47 +1000 (EST)
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210]) by ozlabs.org (Postfix) with ESMTP id 1322BDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 02:40:46 +1000 (EST)
Received: by gxk6 with SMTP id 6so6753678gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 09:40:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1245049031.19217.49.camel@pasglop>
References: <20090527185422.15186.46133.stgit@localhost.localdomain>
	<1245049031.19217.49.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Jun 2009 10:40:25 -0600
Message-ID: <fa686aa40906160940p443cd954xa69ffb1fdf4e81dc@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc: add ioremap_early() for mapping IO regions
	before MMU_init()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=windows-1252
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 15, 2009 at 12:57 AM, Benjamin
Herrenschmidt<benh@kernel.crashing.org> wrote:
> On Wed, 2009-05-27 at 12:55 -0600, Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> ioremap_early() is useful for things like mapping SoC internally registe=
rs
>> and early debug output because it allows mappings to devices to be setup
>> early in the boot process where they are needed. =A0It also give a
>> performance boost since BAT mapped registers don't get flushed out of
>> the TLB.
>>
>> Without ioremap_early(), early mappings are set up in an ad-hoc manner
>> and they get lost when the MMU is set up. =A0Drivers then have to perfor=
m
>> hacky fixups to transition over to new mappings.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>
> My 40x config gives me:
>
> /home/benh/linux-powerpc-test/drivers/video/xilinxfb.c:409: warning:
> =91dcr_host.base=92 may be used uninitialized in this function
>
> (warning, I think, was already there, so the patch is going into -next
> but we may want another one, provided we find a way to shut the idiot up
> without horrible hacks since that's just gcc being stupid I believe).

I'll have the final fix out to you today.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
