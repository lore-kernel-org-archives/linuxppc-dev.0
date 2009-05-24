Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id D7B82DE037
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 01:21:18 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1477898qwe.15
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 08:21:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090524110854.GB4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090524110854.GB4933@sirena.org.uk>
Date: Sun, 24 May 2009 11:21:15 -0400
Message-ID: <9e4733910905240821p7313f82bu171e0d4a2f3dbbff@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V2 0/9] mpc5200 audio rework for AC97
From: Jon Smirl <jonsmirl@gmail.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 7:08 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> I'm not aware of any CODEC drivers which can't currently be built and
> used as modules. =A0If you mean "load via the normal device model" then
> yes, that'd be very good (and is in progress) but it's another issue and
> as I explained last time AC97 poses particular problems there.
>

I mean "load via the normal device model". For example the AC97
drivers need to be loadable by the codec id. There's no entry in
scripts/mod/file2alias.c for dynamically loading the modules.  They
don't have an id_table.

My AC97 driver is detecting the codec id and printing it before trying
to access the codec driver. I can convert that to a load_module() call
when the drivers are ready.

The core needs to detect if a specific codec id can't be supported to
fall back to the generic AC97 driver.

--=20
Jon Smirl
jonsmirl@gmail.com
