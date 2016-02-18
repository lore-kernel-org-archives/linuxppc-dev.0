Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 558871A0353
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 12:11:35 +1100 (AEDT)
Message-ID: <1455757889.2463.88.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Leo Li <pku.leo@gmail.com>, Raghav Dogra <raghav.dogra@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Date: Wed, 17 Feb 2016 19:11:29 -0600
In-Reply-To: <CADRPPNQpCv7xJEXE98xQExw2R_hE_YWj6T49WfB2NhW22UHEYA@mail.gmail.com>
References: <1455516864-3594-1-git-send-email-raghav.dogra@nxp.com>
 <1455611695.2463.56.camel@buserror.net>
 <DB4PR04MB346600B0CB57C4F161C896589AE0@DB4PR04MB346.eurprd04.prod.outlook.com>
 <CADRPPNQpCv7xJEXE98xQExw2R_hE_YWj6T49WfB2NhW22UHEYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH][v3] drivers/memory: Add deep sleep support for IFC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-17 at 17:19 -0600, Leo Li wrote:
> On Wed, Feb 17, 2016 at 8:40 AM, Raghav Dogra <raghav.dogra@nxp.com> wrote:
> > 
> > > Is it really necessary to spin here rather than waiting for an interrupt
> > > like
> > > normal?
> > > 
> > 
> > Aren't the global interrupts disabled at this stage? Can we use the
> > interrupt based
> > waits in the deep sleep code? We used it based on the assumption that
> > interrupts
> > cannot be used here.
> 
> At the resume() stage, interrupts are already enabled.  But the
> problem of using interrupt based wait here is that we cannot give a
> correct return value at this point.  And it can also defeat the
> ordering of resume() callbacks for dependent devices.

I didn't say to return from the resume() function before the operation is
done, just to have the resume() function wait for the interrupt.  At the very
least it would make it easier to reuse existing code once this is moved to the
NAND driver, if we don't need a special way of waiting for this operation.

-Scott
