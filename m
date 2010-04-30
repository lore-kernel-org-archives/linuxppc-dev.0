Return-Path: <timur.tabi@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id 830FFB7D48
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 08:04:38 +1000 (EST)
Received: by pxi18 with SMTP id 18so389259pxi.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 15:04:37 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <t2ged82fe3e1004301446mfbe63ddele99ad22ae331dd57@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>
	<t2ged82fe3e1004301446mfbe63ddele99ad22ae331dd57@mail.gmail.com>
From: Timur Tabi <timur@freescale.com>
Date: Fri, 30 Apr 2010 17:04:07 -0500
Message-ID: <u2hed82fe3e1004301504x95b2947fv60cc561feb3f26a4@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
To: Liam Girdwood <lrg@slimlogic.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 30, 2010 at 4:46 PM, Timur Tabi <timur@freescale.com> wrote:

> When I boot Linux, I get this:
>
> asoc: cs4270 <-> /soc@e0000000/ssi@16000 mapping ok
> sysfs: cannot create duplicate filename '/devices/platform/soc-audio/cs4270'

*sigh* never mind.  The problem was that the stream_name was the same
for both DAIs.

What exactly should the stream names be set to, anyway?  I did this:

	machine_data->dai[0].stream_name = "playback";
	machine_data->dai[1].stream_name = "capture";

but I have a suspicion that this is too simplistic.

-- 
Timur Tabi
Linux kernel developer at Freescale
