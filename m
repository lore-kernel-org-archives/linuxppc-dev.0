Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4ED12B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 Nov 2009 05:12:08 +1100 (EST)
Date: Sat, 7 Nov 2009 18:11:54 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20091107181153.GA31789@sirena.org.uk>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083448.18908.80366.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091107083448.18908.80366.stgit@angua>
Subject: Re: [alsa-devel] [PATCH 6/6] ASoC/mpc5200: Add fudge factor to
	value reported by	.pointer()
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 07, 2009 at 01:34:55AM -0700, Grant Likely wrote:
> ALSA playback seems to be more reliable if the .pointer() hook reports
> a value slightly into the period, rather than right on the period
> boundary.  This patch adds a fudge factor of 1/4 the period size
> to better estimate the actual position of the DMA engine in the
> audio buffer.

It occurs to me that in terms of dealing with what's going on here this
probably is achieving exactly the same effect as Jon's code in that it
tells ALSA that things are a bit ahead of where the buffer started.
