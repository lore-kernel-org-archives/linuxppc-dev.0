Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 108E8DDFCC
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 02:44:17 +1100 (EST)
Date: Thu, 11 Dec 2008 15:44:12 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Timur Tabi <timur@freescale.com>
Subject: Re: MPC8610HPCD sound as module
Message-ID: <20081211154411.GG30808@sirena.org.uk>
References: <49411308.1050008@fang.fa.gau.hu>
	<ed82fe3e0812110712r4baeea60ied52937aa434f48e@mail.gmail.com>
	<20081211153158.GF30808@sirena.org.uk>
	<49413487.9030805@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49413487.9030805@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 11, 2008 at 09:40:55AM -0600, Timur Tabi wrote:
> Mark Brown wrote:

> > ASoC v1 supports loading drivers as modules (and this is fairly heavily
> > used), though as you say the MPC8610 drivers don't support that.

> Well, at the time I wrote the drivers, I didn't see an easy way to support
> modules, since V1 drivers typically have lots of hard-coded references to global
>  variables in other files.

The only references should be machine->{codec,ssi} and ssi->platform.
There's a reasonable chance that your drivers would work fine if you
just marked them all as tristate, though since they're written rather
differently to other ASoC drivers it's possible something will break.
