Return-Path: <wharms@bfs.de>
Received: from mx01-fr.bfs.de (mx01-fr.bfs.de [193.174.231.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk5VR01gszDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 20:13:02 +1000 (AEST)
Message-ID: <570B76A3.70701@bfs.de>
Date: Mon, 11 Apr 2016 12:04:19 +0200
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: geoff@infradead.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: Re: Inconsistent use of size argument in kzalloc and memcpy in
 'drivers/net/ethernet/toshiba/ps3_gelic_wireless.c'
References: <570B75A4.5070904@wanadoo.fr>
In-Reply-To: <570B75A4.5070904@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this is a case for kmemdup().

target->hwinfo=kmemdup(scan_info,be16_to_cpu(scan_info->size), GFP_KERNEL);


re,
 wh


Am 11.04.2016 12:00, schrieb Christophe JAILLET:
> Hi,
> 
> while looking at potential clean-up, I ended on the following code which
> looks spurious to me.
> 
> We allocate 'be16_to_cpu(scan_info->size)' bytes, but then copy
> 'scan_info->size'.
> This is not consistent.
> 
> 
> I don't know which one is the correct one.
> 
> 
> CJ
> 
> --- drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
> +++ /tmp/cocci-output-24201-0dddbd-ps3_gelic_wireless.c
> @@ -1616,13 +1616,10 @@ static void gelic_wl_scan_complete_event
>          target->valid = 1;
>          target->eurus_index = i;
>          kfree(target->hwinfo);
> -        target->hwinfo = kzalloc(be16_to_cpu(scan_info->size),
> -                     GFP_KERNEL);
>          if (!target->hwinfo)
>              continue;
> 
>          /* copy hw scan info */
> -        memcpy(target->hwinfo, scan_info, scan_info->size);
>          target->essid_len = strnlen(scan_info->essid,
>                          sizeof(scan_info->essid));
>          target->rate_len = 0;
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe
> kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
