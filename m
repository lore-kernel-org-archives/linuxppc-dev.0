Return-Path: <guangyu.chen@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFC701A0CF6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:53:21 +1000 (EST)
Date: Wed, 6 Aug 2014 10:42:37 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Message-ID: <20140806024236.GA17879@MrMyself>
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
 <53E0B926.9010103@gmail.com> <20140805110735.GA16503@MrMyself>
 <53E0BC95.7040208@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <53E0BC95.7040208@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 Li.Xiubo@freescale.com, b42378@freescale.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, timur@tabi.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Varka,

On Tue, Aug 05, 2014 at 04:44:29PM +0530, Varka Bhadram wrote:
> On 08/05/2014 04:37 PM, Nicolin Chen wrote:
> >Hi Varka,
> >
> >On Tue, Aug 05, 2014 at 04:29:50PM +0530, Varka Bhadram wrote:
> >>>diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >>>index 0f4e238..77864f4 100644
> >>>--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >>>+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >>>@@ -24,6 +24,22 @@ Required properties:
> >>>  - big-endian-data: If this property is absent, the little endian mode will
> >>>    be in use as default, or the big endian mode will be in use for all the
> >>>    fifo data.
> >>>+- fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
> >>>+  that SAI will work in the synchronous mode (sync Tx with Rx) which means
> >>>+  both the transimitter and receiver will send and receive data by following
> >>>+  receiver's bit clocks and frame sync clocks.
> >>>+- fsl,sai-asynchronous: This is a boolean property. If present, indicating
> >>>+  that SAI will work in the asynchronous mode, which means both transimitter
> >>>+  and receiver will send and receive data by following their own bit clocks
> >>>+  and frame sync clocks separately.
> >>>
> >>Would be readable if it like this...
> >>
> >>fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
> >>			that SAI will work in the synchronous mode (sync Tx with Rx) which means
> >>			both the transimitter and receiver will send and receive data by following
> >>			receiver's bit clocks and frame sync clocks.
> >>- fsl,sai-asynchronous: This is a boolean property. If present, indicating
> >>			that SAI will work in the asynchronous mode, which means both transimitter
> >>			and receiver will send and receive data by following their own bit clocks
> >>			and frame sync clocks separately.
> >I agree, however, the doc was initialized in that format. Adding
> >indentations for these two appended lines makes the whole text
> >look weird. :(
> 
> Reading comfortably is important for us...  :-)
> see this:http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt#L46

I know how to write a binding doc with indentations to make it clear.

What I'm talking about is that the doc was created without indentations,
so I don't feel comfortable to add indentations starting from this patch
while leaving the old lines in totally a different style because It's not
helpful to make people read comfortably at all but only forcing people to
think why these two lines are so special to take some steps back here.

So personally I agree with your idea to make doc more readable. But what
I prefer to do is not having a conversation on the style within this patch
but to create an extra style-refinement patch later after this one.

Let's just focus on the function itself right now. We can later send a
patch to refine this entire doc. Won't you think it's a better idea? :)

Thank you
Nicolin
