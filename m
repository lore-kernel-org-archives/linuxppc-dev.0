Return-Path: <b08248@gmail.com>
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C1632C0321
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 03:16:13 +1100 (EST)
Received: by mail-oa0-f41.google.com with SMTP id i10so9460452oag.14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Mar 2013 08:16:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1362386425-20149-1-git-send-email-B38951@freescale.com>
References: <1362386425-20149-1-git-send-email-B38951@freescale.com>
Date: Mon, 4 Mar 2013 10:16:10 -0600
Message-ID: <CALRxmdBjb+TrqZ_XdNjH=oDcdYtVJ5=Q71dcCkKodpe7WCHDpA@mail.gmail.com>
Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
From: Stuart Yoder <b08248@gmail.com>
To: Jia Hongtao <B38951@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 4, 2013 at 2:40 AM, Jia Hongtao <B38951@freescale.com> wrote:
> A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
> goes down. when the link goes down, Non-posted transactions issued
> via the ATMU requiring completion result in an instruction stall.
> At the same time a machine-check exception is generated to the core
> to allow further processing by the handler. We implements the handler
> which skips the instruction caused the stall.

Can you explain at a high level how just skipping an instruction solves
anything?   If you just skip a load/store and continue like nothing is
wrong, isn't your system possibly in a really bad state.

And if the core is already hung, due to the PCI link going down, isn't
it too late?   How does skipping help?

Stuart
