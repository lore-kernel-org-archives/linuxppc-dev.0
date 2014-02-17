Return-Path: <glikely@secretlab.ca>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4BBDA2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 05:00:07 +1100 (EST)
Received: by mail-wi0-f177.google.com with SMTP id e4so2674830wiv.16
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 10:00:03 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 2/2] of: search the best compatible match first in
 __of_match_node()
To: Rob Herring <robherring2@gmail.com>, Kevin Hao <haokexin@gmail.com>
In-Reply-To: <CAL_JsqKq4_1K8EF+PZoP=0=H6tiRxbgdzs9UHHVdbHS014n74Q@mail.gmail.com>
References: <1392355366-1445-1-git-send-email-haokexin@gmail.com> <
 1392355366-1445-3-git-send-email-haokexin@gmail.com> <
 CAL_JsqKq4_1K8EF+PZoP=0=H6tiRxbgdzs9UHHVdbHS014n74Q@mail.gmail.com>
Date: Mon, 17 Feb 2014 17:59:59 +0000
Message-Id: <20140217175959.178DAC403C8@trevor.secretlab.ca>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Stephen N Chivers <schivers@csc.com.au>, Rob Herring <robh+dt@kernel.org>,
 Kumar Gala <galak@codeaurora.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 14 Feb 2014 09:53:40 -0600, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Feb 13, 2014 at 11:22 PM, Kevin Hao <haokexin@gmail.com> wrote:
> > Currently, of_match_node compares each given match against all node's
> > compatible strings with of_device_is_compatible.
> >
> > To achieve multiple compatible strings per node with ordering from
> > specific to generic, this requires given matches to be ordered from
> > specific to generic. For most of the drivers this is not true and also
> > an alphabetical ordering is more sane there.
> >
> > Therefore, this patch introduces a function to match each of the node's
> > compatible strings against all given compatible matches without type and
> > name first, before checking the next compatible string. This implies
> > that node's compatibles are ordered from specific to generic while
> > given matches can be in any order. If we fail to find such a match
> > entry, then fall-back to the old method in order to keep compatibility.
> >
> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> 
> Looks good to me. I'll put this in next for a few days. I'd really
> like to see some acks and tested-by's before sending to Linus.

As I commented on the patch, I don't think the new solution is correct
either. I've made a suggestion on how to fix it, but in the mean time
the revert should be applied and sent to Linus.

g.
