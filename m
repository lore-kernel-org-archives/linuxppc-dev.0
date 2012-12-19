Return-Path: <glikely@secretlab.ca>
Received: from mail-vb0-f48.google.com (mail-vb0-f48.google.com
 [209.85.212.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 94C542C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2012 22:03:13 +1100 (EST)
Received: by mail-vb0-f48.google.com with SMTP id fc21so2064379vbb.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2012 03:03:10 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1355914716-19469-1-git-send-email-grant.likely@secretlab.ca>
References: <1355914716-19469-1-git-send-email-grant.likely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 19 Dec 2012 11:02:49 +0000
Message-ID: <CACxGe6vTxQGr+t5O4q0J265K02-EEeEiGoOTvB1o-ee2bBrhZg@mail.gmail.com>
Subject: Re: [PATCH] of: Fix export of of_find_matching_node_and_match()
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anatolij Gustschin <agust@denx.de>, Stephen Warren <swarren@nvidia.com>,
 Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 19, 2012 at 10:58 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Commit 50c8af4cf9, "of: introduce for_each_matching_node_and_match()"
> renamed of_find_matching_node() to of_find_matching_node_and_match() and
> created a new static inline of_find_matching_node() wrapper around the
> new name. However, the change neglected to change the EXPORT_SYMBOL()
> reference causing build errors for modules.
>
> This patch fixes the EXPORT_SYMBOL() statement. Discovered on a PowerPC
> Efika build with the mpc52xx_uart driver being built as a module.
>
> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Anatolij Gustschin <agust@denx.de>

Rob, I've just pushed this out to my devicetree/merge branch. If
you've got any fixes queued up for Linus, then please pull this in
before sending them on to him. Otherwise I'll send Linus a pull req
for this fix this evening. Ether way, please reply to let me know what
you're going to do.

g.

The following changes since commit 752451f01c4567b506bf4343082682dbb8fb30dd:

  Merge branch 'i2c-embedded/for-next' of
git://git.pengutronix.de/git/wsa/linux (2012-12-18 16:51:10 -0800)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 devicetree/merge

for you to fetch changes up to 80c2022e5645a1a789531d13010292c5c18bf1db:

  of: Fix export of of_find_matching_node_and_match() (2012-12-19
10:58:53 +0000)

----------------------------------------------------------------
Grant Likely (1):
      of: Fix export of of_find_matching_node_and_match()

 drivers/of/base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

> ---
>
> I'll push this patch out to my tree ASAP.
>
>  drivers/of/base.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index db8d211..2390ddb 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -629,7 +629,7 @@ struct device_node *of_find_matching_node_and_match(struct device_node *from,
>         read_unlock(&devtree_lock);
>         return np;
>  }
> -EXPORT_SYMBOL(of_find_matching_node);
> +EXPORT_SYMBOL(of_find_matching_node_and_match);
>
>  /**
>   * of_modalias_node - Lookup appropriate modalias for a device node
> --
> 1.7.10.4
>



--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
