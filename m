Return-Path: <julia.lawall@lip6.fr>
Date: Sun, 23 Nov 2014 14:18:13 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 9/9] sound/ppc/snd_ps3.c: fix error return code
In-Reply-To: <1416746890-22719-9-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <alpine.DEB.2.02.1411231417560.2261@localhost6.localdomain6>
References: <1416746890-22719-1-git-send-email-Julia.Lawall@lip6.fr>
 <1416746890-22719-9-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wrong patch, please ignore.

julia

On Sun, 23 Nov 2014, Julia Lawall wrote:

> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Initialize ret before returning on failure, as done elsewhere in the
> function.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> 
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  sound/ppc/snd_ps3.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
> index 1aa52ef..9b18b52 100644
> --- a/sound/ppc/snd_ps3.c
> +++ b/sound/ppc/snd_ps3.c
> @@ -1040,6 +1040,7 @@ static int __devinit snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
>  				   GFP_KERNEL);
>  	if (!the_card.null_buffer_start_vaddr) {
>  		pr_info("%s: nullbuffer alloc failed\n", __func__);
> +		ret = -ENOMEM;
>  		goto clean_preallocate;
>  	}
>  	pr_debug("%s: null vaddr=%p dma=%#llx\n", __func__,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
