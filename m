Return-Path: <clabbe@baylibre.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428HHv6H9fzF3B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 04:53:31 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id q8-v6so22589380wmq.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 11:53:31 -0700 (PDT)
Date: Mon, 10 Sep 2018 20:53:25 +0200
From: LABBE Corentin <clabbe@baylibre.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 alexandre.torgue@st.com, alistair@popple.id.au,
 benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
 galak@kernel.crashing.org, joabreu@synopsys.com,
 khilman@baylibre.com, maxime.ripard@bootlin.com,
 michal.lkml@markovi.net, mpe@ellerman.id.au,
 mporter@kernel.crashing.org, nicolas.palix@imag.fr,
 oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com,
 tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
Message-ID: <20180910185325.GC7819@Red>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
 <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
 <a1795266-5679-289d-5cce-1111babf3180@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a1795266-5679-289d-5cce-1111babf3180@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2018 at 07:22:04AM +0200, Christophe LEROY wrote:
> 
> 
> Le 07/09/2018 à 21:41, Corentin Labbe a écrit :
> > This patch adds setbits32/clrbits32/clrsetbits32 and
> > setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.
> 
> So you changed the name of setbits32() ... to setbits32_be() and now you 
> are adding new functions called setbits32() ... which do something 
> different ?
> 
> What will happen if any file has been forgotten during the conversion, 
> or if anybody has outoftree drivers and missed this change ?
> They will silently successfully compile without any error or warning, 
> and the result will be crap buggy.
> 
> And why would it be more legitim to have setbits32() be implicitely LE 
> instead of implicitely BE ?
> 
> I really think those new functions should be called something like 
> setbits_le32() ...
> 

I believed that writel/readl was endian agnostic so it explain my mistake.

I will use xxxbits_le32 as you requests.

Thanks
Regards
