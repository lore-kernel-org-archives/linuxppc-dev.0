Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KKCl6Hg0zDrnl
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:50:43 +1000 (AEST)
Message-ID: <1523253032.11062.6.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 3/9] powerpc/powernv: opal_put_chars partial write fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 09 Apr 2018 15:50:32 +1000
In-Reply-To: <20180409052431.26405-4-npiggin@gmail.com>
References: <20180409052431.26405-1-npiggin@gmail.com>
 <20180409052431.26405-4-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-09 at 15:24 +1000, Nicholas Piggin wrote:
> The intention here is to consume and discard the remaining buffer
> upon error. This works if there has not been a previous partial write.
> If there has been, then total_len is no longer total number of bytes
> to copy. total_len is always "bytes left to copy", so it should be
> added to written bytes.
> 
> This code may not be exercised any more if partial writes will not be
> hit, but this is a small bugfix before a larger change.
> 

Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/platforms/powernv/opal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 516e23de5a3d..87d4c0aa7f64 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -388,7 +388,7 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
>  		/* Closed or other error drop */
>  		if (rc != OPAL_SUCCESS && rc != OPAL_BUSY &&
>  		    rc != OPAL_BUSY_EVENT) {
> -			written = total_len;
> +			written += total_len;
>  			break;
>  		}
>  		if (rc == OPAL_SUCCESS) {
