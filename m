Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCFr03y9czDr30
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 09:55:43 +1000 (AEST)
Message-ID: <1471218899.12231.76.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: populate the default bus with
 machine_arch_initcall
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robh@kernel.org>
Cc: Kevin Hao <haokexin@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Date: Mon, 15 Aug 2016 09:54:59 +1000
In-Reply-To: <CAL_Jsq+JLvThaz3ZTy80yVW23waPjqfw_JC-EJF-QuCk21=eJQ@mail.gmail.com>
References: <1470913781-9204-1-git-send-email-haokexin@gmail.com>
 <87k2fmtxbv.fsf@concordia.ellerman.id.au>
 <20160812054934.GJ17275@pek-khao-d1>
 <CAL_Jsq+_K-uU7bFkSm-tq-Q0DPhQt4j=f84OzQSCJFEC29O-8A@mail.gmail.com>
 <1471209670.12231.60.camel@kernel.crashing.org>
 <CAL_Jsq+JLvThaz3ZTy80yVW23waPjqfw_JC-EJF-QuCk21=eJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-08-14 at 17:42 -0500, Rob Herring wrote:
> > Not fan of the hard #ifdef at all... it will make it hard to
> convert
> > platforms one by one. Why not an arch_want_default_of_probe() or
> > something like this which we can then plumb into ppc_md. ?
> 
> Yeah, I'm not either really. I didn't propose using IS_ENABLED here
> either as it does add a needless initcall.
> 
> Do you have any idea which platforms are not broken and could be
> switched over now. If not, I think we should just leave as is for 4.8
> and make it per platform selectable for 4.9.

Not really... the non-embedded platforms (mac, pseries, etc...) don't
really use the OF bus probing iirc, so it's going to be a matter of
scrubbing the embedded ones. I agree we can do that in 4.9

Cheers,
Ben.
