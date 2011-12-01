Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5363CB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 22:44:43 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so1397811vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Dec 2011 03:44:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322717953.3729.18.camel@pasglop>
References: <1322717953.3729.18.camel@pasglop>
Date: Thu, 1 Dec 2011 06:44:39 -0500
Message-ID: <CA+5PVA5xaCa8Tv3MMr1WzQAuLit9KenMoezOKB7ENQSt=fOSOg@mail.gmail.com>
Subject: Re: ppc4xx simple vs SoC's
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 1, 2011 at 12:39 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hi Josh !
>
> I was helping Tony with some of the Currituck stuff when I noticed an
> oddity...
>
> So we have various "SoC" config symbols such as 440EP, 460SX, etc...
> that in turn select various bits & pieces that enable support for that
> SoC (such as EMAC4 support or FPU support). Those only act as "enables"
> for compiling of the code, there is still going to be a runtime check of
> course.
>
> Those SoC config symbols are not user selectable, they are meant to be
> themselves select'ed by the board Kconfig entries.

Yep, and they are.

> However, the entry for ppc44x_simple doesn't select any of these,
> meaning for example, AFAIK, that you don't get EMAC4 etc... I'm
> surprised things work at all !
>
> What am I missing ?

CONFIG_PPC44x_SIMPLE is selected by the board Kconfig values, which
also select all of the SoC Kconfig options they need as well.
ppc44x_simple started as a way to basically avoid duplicating a bunch
of board.c files, but it's still "driven" from the board options.

So hopefully that explains how things are working today.  The question
now is whether you would like something different?

josh
