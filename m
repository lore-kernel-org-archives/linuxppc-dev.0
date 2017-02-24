Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTwRG3PvNzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:44:10 +1100 (AEDT)
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTwRF5G7yz9s7K
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:44:09 +1100 (AEDT)
Received: by mail-yw0-x241.google.com with SMTP id l16so702296ywb.2
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:44:09 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <1487904081.23576.254.camel@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-2-benh@kernel.crashing.org>
 <CACPK8XfqnCm7ufoXQhvpx3tbhcoJtrtEzxJFrhmY-Q4Oif5Q_Q@mail.gmail.com>
 <1487904081.23576.254.camel@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Feb 2017 13:13:47 +1030
Message-ID: <CACPK8Xf_iGEMVTV_-DfsK=QFjQw-CNiQkAy2MGsXtUrm0nrvDA@mail.gmail.com>
Subject: Re: [PATCH v5 2/12] drm/ast: Handle configuration without P2A bridge
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dri-devel@lists.freedesktop.org, linuxppc-dev@ozlabs.org,
 airlied@redhat.com, "Y . C . Chen" <yc_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 24, 2017 at 1:11 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> The ast driver configures a window to enable access into BMC
> memory space in order to read some configuration registers.
>
> If this window is disabled, which it can be from the BMC side,
> the ast driver can't function.
>
> Closing this window is a necessity for security if a machine's
> host side and BMC side are controlled by different parties;
> i.e. a cloud provider offering machines "bare metal".
>
> A recent patch went in to try to check if that window is open
> but it does so by trying to access the registers in question
> and testing if the result is 0xffffffff.
>
> This method will trigger a PCIe error when the window is closed
> which on some systems will be fatal (it will trigger an EEH
> for example on POWER which will take out the device).
>
> This patch improves this in two ways:
>
>  - First, if the firmware has put properties in the device-tree
> containing the relevant configuration information, we use these.
>
>  - Otherwise, a bit in one of the SCU scratch registers (which
> are readable via the VGA register space and writeable by the BMC)
> will indicate if the BMC has closed the window. This bit has been
> defined by Y.C Chen from Aspeed.
>
> If the window is closed and the configuration isn't available from
> the device-tree, some sane defaults are used. Those defaults are
> hopefully sufficient for standard video modes used on a server.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> --
>
> v2. [BenH]
>     - Reworked on top of Aspeed P2A patch
>     - Cleanup overall detection via a "config_mode" and log the
>       selected mode for diagnostics purposes
>     - Add a property for the SCU straps
>
> v3. [BenH]
>     - Moved the config mode detection to a separate functionn
>     - Add reading of SCU 0x40 D[12] to detect the window is
>       closed as to not trigger a bus error by just "trying".
>       (change provided by Y.C. Chen)
> v4. [BenH]
>     - Only devices with the AST2000 PCI ID have a P2A bridge
>     - Update the P2A presence test to account for VGA only
>       mode as provided by Y.C. Chen.
> v5. [BenH]
>     - Fixup prefix of OF properties based on Joel Stanley
>       review comments.

LGTM. Thanks for the explaining the mcr regs, that stuff checks out now.

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/gpu/drm/ast/ast_drv.h  |   6 +-
>  drivers/gpu/drm/ast/ast_main.c | 264 +++++++++++++++++++++++++----------------
>  drivers/gpu/drm/ast/ast_post.c |   7 +-
>  3 files changed, 168 insertions(+), 109 deletions(-)
>
