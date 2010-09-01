Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by ozlabs.org (Postfix) with ESMTP id F23BCB7218
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 01:32:43 +1000 (EST)
Received: by pvg13 with SMTP id 13so3577924pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Sep 2010 08:32:42 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 1 Sep 2010 09:32:39 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] powerpc/512x: fix clk_get() return value
Message-ID: <20100901153239.GF13421@angua.secretlab.ca>
References: <1283244231-23659-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283244231-23659-1-git-send-email-akinobu.mita@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 31, 2010 at 05:43:51PM +0900, Akinobu Mita wrote:
> clk_get() should return an ERR_PTR value on error, not NULL.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: linuxppc-dev@lists.ozlabs.org

applied, thanks.

g.

> ---
>  arch/powerpc/platforms/512x/clock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
> index 5b243bd..3dc2a8d 100644
> --- a/arch/powerpc/platforms/512x/clock.c
> +++ b/arch/powerpc/platforms/512x/clock.c
> @@ -57,7 +57,7 @@ static struct clk *mpc5121_clk_get(struct device *dev, const char *id)
>  	int id_match = 0;
>  
>  	if (dev == NULL || id == NULL)
> -		return NULL;
> +		return clk;
>  
>  	mutex_lock(&clocks_mutex);
>  	list_for_each_entry(p, &clocks, node) {
> -- 
> 1.7.1.231.gd0b16
> 
