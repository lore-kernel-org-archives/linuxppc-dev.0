Return-Path: <B42378@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9CAB92C034F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 23:29:10 +1100 (EST)
Date: Tue, 29 Oct 2013 20:13:31 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and disable TIE/RIE in
 trigger()
Message-ID: <20131029121330.GB9605@MrMyself>
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
 <526FA330.3080209@tabi.org> <20131029115711.GA9605@MrMyself>
 <526FA78D.2090601@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <526FA78D.2090601@tabi.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 29, 2013 at 07:18:21AM -0500, Timur Tabi wrote:
> Nicolin Chen wrote:
> >Well, actually I just wanted to clear T/RDMAE to disable DMA request,
> >but it seems to be much easier to do it like this based on current
> >code and disabling unused interrupts should be better right?:)
> 
> It's not better if it complicates the code and has no real impact.
> The code has been running fine for years the way it is.  Unless you
> can show me that it actually makes a difference, I will have to NACK
> this patch.
>

The DMA request might be remaining high if not disabling it. This would
cause SDMA re-check this request, while it has no BD existing. For the
other interrupts, if you don't like it, I can drop it. Just modification
to the driver might not be less complicated.

Thank you,
Nicolin Chen
