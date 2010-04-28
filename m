Return-Path: <timur.tabi@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id C233EB7D5B
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 08:14:06 +1000 (EST)
Received: by pxi18 with SMTP id 18so2780770pxi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 15:14:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <z2xfa686aa41004281458u3a3048feh9d762e07f8052348@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
	<z2xfa686aa41004281458u3a3048feh9d762e07f8052348@mail.gmail.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Wed, 28 Apr 2010 17:13:35 -0500
Message-ID: <r2oed82fe3e1004281513k23b54b56v7904a4a34750c90b@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	Mark Brown <broonie@opensource.wolfsonmicro.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 28, 2010 at 4:58 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:

> The sound0 node needs a compatible value,

I knew I was forgetting something

> the sound-device node should
> probably have one too.

The aliases, cpus, and memory node don't have a compatible property,
and I was modeling the design after the aliases node.

> The sound0 node should have something board specific like
> "fsl,mpc8610hpcd-sound" to make it clear that the binding really only
> applies to this particular board. =A0It would also be a good idea to
> prefix all of the property names with 'fsl,' to avoid conflicting with
> any future common bindings or conventions. =A0Other boards can use the
> same binding, but they would get a different compatible value (the
> driver could bind on both).

The aliases node doesn't have an fsl, prefix.  I understand the need
for the prefix, but I wonder why we don't do that for the aliases
node.

> I'm not a huge fan of the name "sound-devices" for the parent node.
> There are other sorts of things that we need 'virtual' device nodes to
> describe. =A0It would be nice to have a single place for collecting
> nodes for stuff like this. =A0Perhaps this:
>
> system {
> =A0 =A0 =A0 =A0compatible =3D "system-devices";
> =A0 =A0 =A0 =A0sound0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8610hpcd-sound";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,ssi =3D &ssi0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,playback-dma =3D &dma00;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,capture-dma =3D &dma01;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,codec =3D &cs4270;
> =A0 =A0 =A0 =A0};
> };

I like that.

--=20
Timur Tabi
Linux kernel developer at Freescale
