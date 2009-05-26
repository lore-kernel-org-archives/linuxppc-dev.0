Return-Path: <jonsmirl@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id 517CDDDDE2
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 02:53:10 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1277133wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 09:53:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40905260951g5115007fo3ef5eb1fb90998f3@mail.gmail.com>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221509.21370.70182.stgit@terra>
	<20090526110120.GA8969@sirena.org.uk>
	<fa686aa40905260951g5115007fo3ef5eb1fb90998f3@mail.gmail.com>
Date: Tue, 26 May 2009 12:53:07 -0400
Message-ID: <9e4733910905260953i6337f8a9xc3cd1ff490cd3540@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V4 2/5] Main rewite of the mpc5200 audio DMA
	code
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 12:51 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Tue, May 26, 2009 at 5:01 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Mon, May 25, 2009 at 06:15:09PM -0400, Jon Smirl wrote:
>>> Rewrite the mpc5200 audio DMA code to support both I2S and AC97.
>>>
>>> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>>
>> Grant, I'm OK with that if you are?
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Put in the V5 version this one has this in the h file:

-int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
-                          struct snd_soc_dai *dai);
+/* whack this after Timur's patch is merged in to
arch/powerpc/include/asm/delay.h */
+#define spin_event_timeout(condition, timeout, delay, rc)                   \
+{                                                                           \
+       unsigned long __loops = tb_ticks_per_usec * timeout;                \
+       unsigned long __start = get_tbl();                                  \
+       while ((rc = (condition)) && (tb_ticks_since(__start) <= __loops)) \
+               if (delay)                                                  \
+                       udelay(delay);                                      \
+               else                                                        \
+                       cpu_relax();                                        \
+}
+/* whack this after Timur's patch is merged in to
arch/powerpc/include/asm/delay.h */




>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- 
Jon Smirl
jonsmirl@gmail.com
