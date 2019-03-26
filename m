Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C07DC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 20:13:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6CD2087C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 20:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mind-be.20150623.gappssmtp.com header.i=@mind-be.20150623.gappssmtp.com header.b="iLzhsYGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6CD2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mind.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TMl94wvbzDqNV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 07:13:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=essensium.com
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=arnout.vandecappelle@essensium.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mind.be
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=mind-be.20150623.gappssmtp.com
 header.i=@mind-be.20150623.gappssmtp.com header.b="iLzhsYGk"; 
 dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TFlS0jN9zDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 02:43:10 +1100 (AEDT)
Received: by mail-ed1-x541.google.com with SMTP id s39so5683572edb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mind-be.20150623.gappssmtp.com; s=20150623;
 h=from:in-reply-to:to:cc:subject:organization:message-id:date
 :user-agent:mime-version:content-transfer-encoding:content-language;
 bh=qTFbVP0RRxY4mxvJEr6n3CrBaxLEfK17JkB/F+rzF78=;
 b=iLzhsYGk5hCkyDchoxlIl3+hBkRaD7/IFwG1pWXJ/egfc+VoB/jvXJ9lwg8Rob6z4g
 pJn7HOSVewxcMdvO/rpSThHa2R4THLCBF2QFbHYQEHVENtaFaswnYBhj0lMrEZSXnyo8
 Z8/qv2iow1XN2wV2xsrhKI3hjiYGTUg8OMIgxzZv6/TvMxbryE9SfVcu1rxhp/tb3RB/
 JQwLrml8TCVX+21mVfRgNT0Z6eJpYX6G5IMFUQxCVgd0i53SZPv11YC2milbjE89xE5y
 LQhGULZalbO6jIZaH6CwG3TnW91vR7YA65fg7se1uJ+CRB2Qpa5tmP8Wy+84EqakhKDf
 Zlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:in-reply-to:to:cc:subject:organization
 :message-id:date:user-agent:mime-version:content-transfer-encoding
 :content-language;
 bh=qTFbVP0RRxY4mxvJEr6n3CrBaxLEfK17JkB/F+rzF78=;
 b=rqoP2bl0UVUYIIVThloU5ekdMg1ehwWS09Cfys6osb3DkCjQu2aPa59P6doChS+d7D
 OsHpfFH+vkspNdVdJGQWz33USqkEkx6G0h7HTkMnUVpbmSZJ9y+0OanHDLxYOgeud877
 pN1a2OcF5SS+FoNTwtSxQIh0rkNpQb4SlNNDIouUSvrPlijy8I+Q09EOFuEe7nk00azu
 kQMRHB7TUHkbz6KW5HrFa9ivqNVMgwnGDVeoM9hRR8u8D9XGLH+vKblRn2WBVKSGA/9P
 x5yIxX8T0dls95nJ7oICb84ztRh4bVOHNejwq8h/Bv8/ks71TvU95/g99Fow7ZkwtUxk
 WYtQ==
X-Gm-Message-State: APjAAAXLrKawT/4RZjHEl8ktGYBj70H3KxT7R3tKkK6TSYm/55AFLCN+
 wgSxd2EkgAN3kZYDXCwkjvpfR+vNsDiuIw==
X-Google-Smtp-Source: APXvYqwE0TaKGdFtgbR/0LNQHwwQZn7e/3PPeDeLG8o0xEQPrq7i+9UH5mIvezIE0te2+XdcAMLuxA==
X-Received: by 2002:a17:906:194c:: with SMTP id
 b12mr8136512eje.228.1553614985501; 
 Tue, 26 Mar 2019 08:43:05 -0700 (PDT)
Received: from [10.3.4.110] (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id p26sm4279205eju.10.2019.03.26.08.43.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Mar 2019 08:43:04 -0700 (PDT)
From: Arnout Vandecappelle <arnout@mind.be>
In-Reply-To: <20190316142138.65860d88@archlinux>
To: Patrick Havelange <patrick.havelange@essensium.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/7] dt-bindings: counter: ftm-quaddec
Organization: Essensium/Mind
Message-ID: <55b4aaba-a94f-2a9d-c96d-e591877fe075@mind.be>
Date: Tue, 26 Mar 2019 16:43:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Mailman-Approved-At: Wed, 27 Mar 2019 07:12:00 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 William Breathitt Gray <vilhelm.gray@gmail.com>, Li Yang <leoyang.li@nxp.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Esben Haabendal <esben@haabendal.dk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

 [Full disclosure: I'm a colleague of Patrick.]

On 2019-03-16 14:21:38, Jonathan Cameron wrote:

> On Tue, 12 Mar 2019 14:09:52 -0500
> Rob Herring <robh@kernel.org> wrote:
>
> > On Wed, Mar 06, 2019 at 12:12:05PM +0100, Patrick Havelange wrote:
> > > FlexTimer quadrature decoder driver.
> > > 
> > > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> > > ---
> > > Changes v2
> > > - None
> > > ---
> > > .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
> > > 1 file changed, 18 insertions(+)
> > > create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt \
> > > b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt new file mode 100644
> > > index 000000000000..4d18cd722074
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > > @@ -0,0 +1,18 @@
> > > +FlexTimer Quadrature decoder counter
> > > +
> > > +This driver exposes a simple counter for the quadrature decoder mode.  
> > 
> > Seems like this is more a mode of a h/w block than describing a h/w 
> > block. Bindings should do the latter.


  As Jonathan writes below, it really is a "hardware mode", since it is tied
very closely to how the device is wired up.

 Basically, the same block can be used for pretty diverse functions: a PWM where
the pins are output, a counter where the pins are input, or a timer where the
interrupt or timer value is used purely internally.

 This smells a bit like an MFD, but IMO it really isn't, because only one of the
functions can be enabled. So indeed, it's more like a mode.


> The snag is that we need to dig ourselves out of the hole set by:
> fsl,vf610-ftm-pwm etc.
>
> Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> (I'm assuming these are the same IP block).
>
> Can probably be sorted out though.  One core driver binds against the
> ftm and deals with instantiating the others depending on the configuration
> (note that this mode for instance does make sense in DT as it's
> really reflecting the fact there is a quadrature encoder
> connected to the ftm).
>
> Fiddly though :)


 The way I see it, there are 3 ways this could be modelled (other than the
current way: several nodes with the same address).


1. The SoC's .dtsi defines a single node, and the compatible string (which would
be defined by the board .dts) both enables the node and sets the compatible
string. The .dtsi would also define the static properties of all the different
functions: some "static" properties, e.g. reg, but also some function
specific-properties, e.g.#pwm-cells (only for PWM), interrupts (only for timer).
The driver (selected through compatible) anyway only uses the properties that it
needs, so it doesn't hurt to have those other-function properties there.


2. Like 1, but instead of defining the compatible string in the .dts, use a
single compatible string for all the different drivers which is set in the
.dtsi, and add a mode property (to be set in the .dts) to select the driver. The
selection can be done either by having a top-level driver that calls out to the
subsystem-specific one based on the mode, or by having each driver bail out of
its probe function if the mode is not as expected.


3. Have a common node that essentially does nothing except occupy the memory
resource, and sub-nodes for each function. This can again be combined with a
common driver that does the common resource allocation, or each function driver
can just look at its parent node to find the resources. A disadvantage of this
one is that it is possible to enable several functions in the DT, while only one
can actually work.


 Option 3 is what is used for e.g. stm32-lptimer. It also uses an mfd driver to
model the common part. But possibly it actually allows the different functions
to operate simultaneously.


 Option 3 has the additional disadvantage that it requires changes in existing
DTs for ftm-pwm and ftm-timer, because some properties are moved one level down.
Since we need to retain backward compatibility, we'd need to look for those
properties both in the node itself and in the parent node. In particular, the
common driver part would be fairly complicated to implement in a backward
compatible way because it's not enough to do a simple devm_of_platform_populate().


 Personally I don't like the common driver part too much. This common driver
does almost nothing (iomap and clock) and it creates dependencies between
different drivers. Combined with the backward compatibility problem, I don't see
much point to it.


 I personally like option 2 the most. It's easy to be backward compatible (if
mode is not set, revert to the current behaviour, i.e. assume that the
compatible string has encoded the mode and that you're the only driver). It
doesn't introduce subnodes that have no hardware equivalent. The only messy
thing about it is that properties belonging to the different modes are mixed
together in a single node. And also, I don't think this kind of model is
currently used anywhere else in the kernel.



 Regards,
 Arnout


