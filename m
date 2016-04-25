Return-Path: <caleb@crome.org>
Received: from mail-oi0-x22c.google.com (mail-oi0-x22c.google.com
 [IPv6:2607:f8b0:4003:c06::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtvvP0d4RzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 04:31:44 +1000 (AEST)
Received: by mail-oi0-x22c.google.com with SMTP id r78so185975919oie.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 11:31:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160425180613.GR3217@sirena.org.uk>
References: <1461606624-130216-1-git-send-email-caleb@crome.org>
 <20160425180613.GR3217@sirena.org.uk>
From: Caleb Crome <caleb@crome.org>
Date: Mon, 25 Apr 2016 11:31:22 -0700
Message-ID: <CAG5mAdwtMBJB-5UwF+dYddvb=06JfJEexCRauAvHLYB2Ze0_AQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ASoC: fsl_ssi: add CCSR_SSI_SOR to volatile register
 list
To: Mark Brown <broonie@kernel.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 25, 2016 at 11:06 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 25, 2016 at 10:50:24AM -0700, Caleb Crome wrote:
>
>> Due to caching, SOR wasn't written when it should have been.  This
>> patch simply adds SOR to the volatile list.
>
> Could you expand on when it wasn't written and why it needed to be
> please?

Yes, sorry.

The CCSR_SSI_SOR is a register that clears the TX and/or the RX fifo
on the i.MX6 SSI port.  The fsl_ssi_trigger writes this register in
order to clear the fifo at trigger time.

However, since the CCSR_SSI_SOR register is not in the volatile list,
the caching mechanism prevented the register write in the trigger
function.  This caused the fifo to not be cleared (because the value
was unchanged from the last time the register was written), and thus
causes the channels in both TDM or simple I2S mode to slip and be in
the wrong time slots on SSI restart.

By adding CCSR_SSI_SOR to the volatile list, along with arnaud's
patches that I just tested (and sent tested-by slugs), fix most of the
problems  with the SSI port drivers for multi-channel operation (there
is one more to come that I think really fixes the last bit).

Most people never noticed the problem because with simple stereo mode,
the consequence is that left and right are swapped, which isn't that
noticeable.

I can re-submit the patch if you like with this more descriptive comment.

Thanks,
 -Caleb
