Return-Path: <glikely@secretlab.ca>
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com
 [IPv6:2607:f8b0:4001:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 144612C00D8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 21:07:39 +1000 (EST)
Received: by mail-ie0-f171.google.com with SMTP id e11so3910804iej.16
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 04:07:36 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1367822494.15842.12.camel@pasglop>
References: <1367822494.15842.12.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 6 May 2013 12:07:15 +0100
Message-ID: <CACxGe6uQx+u-9Vr0FeR86P82-e7hUrgVR-z=EqSwMgks+WG5Cg@mail.gmail.com>
Subject: Re: [PATCH] irqdomain: Allow quiet failure mode
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 6, 2013 at 7:41 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Some interrupt controllers refuse to map interrupts marked as
> "protected" by firwmare. Since we try to map everyting in the
> device-tree on some platforms, we end up with a lot of nasty
> WARN's in the boot log for what is a normal situation on those
> machines.
>
> This defines a specific return code (-EPERM) from the host map()
> callback which cause irqdomain to fail silently.
>
> MPIC is updated to return this when hitting a protected source
> printing only a single line message for diagnostic purposes.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
>
> Grant, I'm happy to merge that myself provided I have your ack,
> it fixes an annoying problem on Cell introduced by previous changes
> to irqdomain (not recent but users started to notice).

Yes, please merge it since powerpc needs it.

Acked-by: Grant Likely <grant.likely@linaro.org>

g.
