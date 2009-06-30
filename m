Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1CB90B70FD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 10:12:35 +1000 (EST)
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.225])
	by ozlabs.org (Postfix) with ESMTP id 645D6DDFAB
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 02:53:48 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id b25so94312rvf.9
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 09:53:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090630085917.GA13961@sirena.org.uk>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<9e4733910906291726h5cd5bdf8ve7e946aef855ac07@mail.gmail.com>
	<20090630085917.GA13961@sirena.org.uk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 30 Jun 2009 10:53:26 -0600
Message-ID: <fa686aa40906300953n28016d4v179a1c7ed3198399@mail.gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 30, 2009 at 2:59 AM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 29, 2009 at 08:26:12PM -0400, Jon Smirl wrote:
>
>> Does your touchscreen driver use this mutex? Or was this mutex needed
>> just for the AC97 driver?
>
> It's in the register accesses so everything accessing the chip registers
> will use it.

The mutexes are needed.  The ac97 bus doesn't have any knowledge about
what codec(s) will be wired up to it so it must protect against
multiple access.  In my case both the wm9712 audio codec driver and
the wm9712 touchscreen driver perform register accesses.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
