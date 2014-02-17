Return-Path: <glikely@secretlab.ca>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C0892C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 05:16:05 +1100 (EST)
Received: by mail-wi0-f182.google.com with SMTP id f8so2694514wiw.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 10:16:00 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] of: give priority to the compatible match in
 __of_match_node()
To: Rob Herring <robherring2@gmail.com>, Kevin Hao <haokexin@gmail.com>
In-Reply-To: <CAL_JsqKMi2H=vwoxrOt8QRA2xJeiLqBKKfLtt4QRCRoFk6JUHg@mail.gmail.com>
References: <1392205084-2351-1-git-send-email-haokexin@gmail.com> <
 CAL_JsqKMi2H=vwoxrOt8QRA2xJeiLqBKKfLtt4QRCRoFk6JUHg@mail.gmail.com>
Date: Mon, 17 Feb 2014 18:06:49 +0000
Message-Id: <20140217180649.8F257C403C8@trevor.secretlab.ca>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Chris Proctor <cproctor@csc.com.au>,
 Stephen N Chivers <schivers@csc.com.au>, Rob Herring <robh+dt@kernel.org>,
 Scott Wood <scottwood@freescale.com>,
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

On Thu, 13 Feb 2014 13:01:42 -0600, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Feb 12, 2014 at 5:38 AM, Kevin Hao <haokexin@gmail.com> wrote:
> > When the device node do have a compatible property, we definitely
> > prefer the compatible match besides the type and name. Only if
> > there is no such a match, we then consider the candidate which
> > doesn't have compatible entry but do match the type or name with
> > the device node.
> >
> > This is based on a patch from Sebastian Hesselbarth.
> >   http://patchwork.ozlabs.org/patch/319434/
> >
> > I did some code refactoring and also fixed a bug in the original patch.
> 
> I'm inclined to just revert this once again and avoid possibly
> breaking yet another platform.
> 
> However, I think I would like to see this structured differently. We
> basically have 2 ways of matching: the existing pre-3.14 way and the
> desired match on best compatible only. All new bindings should match
> with the new way and the old way needs to be kept for compatibility.
> So lets structure the code that way. Search the match table first for
> best compatible with name and type NULL, then search the table the old
> way. I realize it appears you are doing this, but it is not clear this
> is the intent of the code. I would like to see this written as a patch
> with commit 105353145eafb3ea919 reverted first and you add a new match
> function to call first and then fallback to the existing function.

I disagree here, partially because it complicates the code and partially
because it leaves an incorrect corner case.  Compatible is always the
preferred matching, even on old drivers, but there are bindings that
take both compatible and type or name into account. Even those cases
should rank the compatible order.

g.
