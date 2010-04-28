Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.211.196]) by ozlabs.org (Postfix) with ESMTP id 05943B7D5C
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 08:23:57 +1000 (EST)
Received: by ywh34 with SMTP id 34so7767106ywh.17
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 15:23:55 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <r2oed82fe3e1004281513k23b54b56v7904a4a34750c90b@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
	<z2xfa686aa41004281458u3a3048feh9d762e07f8052348@mail.gmail.com>
	<r2oed82fe3e1004281513k23b54b56v7904a4a34750c90b@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 28 Apr 2010 16:23:34 -0600
Message-ID: <s2wfa686aa41004281523x30650d0xf48cee0e72eea762@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
To: Timur Tabi <timur.tabi@gmail.com>
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

On Wed, Apr 28, 2010 at 4:13 PM, Timur Tabi <timur.tabi@gmail.com> wrote:
> On Wed, Apr 28, 2010 at 4:58 PM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
>> The sound0 node needs a compatible value,
>
> I knew I was forgetting something

:-)

>
>> the sound-device node should
>> probably have one too.
>
> The aliases, cpus, and memory node don't have a compatible property,
> and I was modeling the design after the aliases node.

Well, there are typically three ways to find a node; by name, by
device_type and by compatible.  device_type is meaningless for the
flattened tree, so that's out.  Matching by name could potentially
have namespace collisions, but I'm not sure.  I'll defer to Ben &
Mitch's judgment here.

The difference with aliases, cpus and memory nodes is that the
conventions around them were defined and agreed on a very long time
ago.  We could get consensus to do the same here, but I cannot make
that call.

>> The sound0 node should have something board specific like
>> "fsl,mpc8610hpcd-sound" to make it clear that the binding really only
>> applies to this particular board. =A0It would also be a good idea to
>> prefix all of the property names with 'fsl,' to avoid conflicting with
>> any future common bindings or conventions. =A0Other boards can use the
>> same binding, but they would get a different compatible value (the
>> driver could bind on both).
>
> The aliases node doesn't have an fsl, prefix. =A0I understand the need
> for the prefix, but I wonder why we don't do that for the aliases
> node.

aliases is not a vendor-specific or limited scope convention.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
