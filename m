Return-Path: <glikely@secretlab.ca>
Received: from mail-ea0-x231.google.com (mail-ea0-x231.google.com
 [IPv6:2a00:1450:4013:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37D672C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 08:01:50 +1000 (EST)
Received: by mail-ea0-f177.google.com with SMTP id j14so616473eak.36
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 15:01:46 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] dtc: ensure #line directives don't consume data from the
 next line
To: Stephen Warren <swarren@wwwdotorg.org>,
 Rob Herring <rob.herring@calxeda.com>
In-Reply-To: <51AF6C3A.5020609@wwwdotorg.org>
References: <1370273816-19411-1-git-send-email-swarren@wwwdotorg.org>
 <51AF6C3A.5020609@wwwdotorg.org>
Date: Fri, 14 Jun 2013 23:01:35 +0100
Message-Id: <20130614220135.0D0D63E0A56@localhost>
Cc: Michal Marek <mmarek@suse.cz>, jdl@jdl.com,
 Stephen Warren <swarren@nvidia.com>, Ian Campbell <Ian.Campbell@citrix.com>,
 linux-kbuild@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 05 Jun 2013 10:50:02 -0600, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/03/2013 09:36 AM, Stephen Warren wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > Previously, the #line parsing regex ended with ({WS}+[0-9]+)?. The {WS}
> > could match line-break characters. If the #line directive did not contain
> > the optional flags field at the end, this could cause any integer data on
> > the next line to be consumed as part of the #line directive parsing. This
> > could cause syntax errors (i.e. #line parsing consuming the leading 0
> > from a hex literal 0x1234, leaving x1234 to be parsed as cell data,
> > which is a syntax error), or invalid compilation results (i.e. simply
> > consuming literal 1234 as part of the #line processing, thus removing it
> > from the cell data).
> > 
> > Fix this by replacing {WS} with [ \t] so that it can't match line-breaks.
> > 
> > Convert all instances of {WS}, even though the other instances should be
> > irrelevant for any well-formed #line directive. This is done for
> > consistency and ultimate safety.
> > 
> > This is a port of upstream dtc commit a1ee6f0 (with same subject) to the
> > kernel's copy of dtc.
> 
> Rob, Grant, does this look OK to apply for v3.10-rc*?

The fix is in mainline now. Please check to make sure it is working for you.

g.


-- 
email sent from notmuch.vim plugin
