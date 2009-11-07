Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id D2A3AB7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 Nov 2009 05:20:17 +1100 (EST)
Received: by yxe9 with SMTP id 9so2109028yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 Nov 2009 10:20:15 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091107181153.GA31789@sirena.org.uk>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083448.18908.80366.stgit@angua>
	<20091107181153.GA31789@sirena.org.uk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 7 Nov 2009 11:19:54 -0700
Message-ID: <fa686aa40911071019y6be8283bu8d36d96420deefab@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 6/6] ASoC/mpc5200: Add fudge factor to value
	reported by .pointer()
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Sat, Nov 7, 2009 at 11:11 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Nov 07, 2009 at 01:34:55AM -0700, Grant Likely wrote:
>> ALSA playback seems to be more reliable if the .pointer() hook reports
>> a value slightly into the period, rather than right on the period
>> boundary. =A0This patch adds a fudge factor of 1/4 the period size
>> to better estimate the actual position of the DMA engine in the
>> audio buffer.
>
> It occurs to me that in terms of dealing with what's going on here this
> probably is achieving exactly the same effect as Jon's code in that it
> tells ALSA that things are a bit ahead of where the buffer started.

Possibly, but I can both reproduce and eliminate the problem Jon is
seeing regardless of whether or not this patch, so I'm not yet
convinced.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
