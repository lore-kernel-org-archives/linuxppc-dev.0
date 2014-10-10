Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0123.outbound.protection.outlook.com [65.55.169.123])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 383B51A09A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 19:28:47 +1100 (EST)
Message-ID: <543794C2.7010309@freescale.com>
Date: Fri, 10 Oct 2014 11:11:46 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/msi: Use WARN_ON() in msi bitmap selftests
References: <1412928265-21991-1-git-send-email-mpe@ellerman.id.au>
 <1412928265-21991-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1412928265-21991-2-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Comment inline.

On 10/10/2014 11:04 AM, Michael Ellerman wrote:
> As demonstrated in the previous commit, the failure message from the msi
> bitmap selftests is a bit subtle, it's easy to miss a failure in a busy
> boot log.
> 
> So drop our check() macro and use WARN_ON() instead. This necessitates
> inverting all the conditions as well.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/sysdev/msi_bitmap.c | 54 ++++++++++++++++++----------------------

[snip]

>  
>  	/* Free most of them for the alignment tests */
>  	msi_bitmap_free_hwirqs(&bmp, 3, size - 3);
>  
>  	/* Check we get a naturally aligned offset */
>  	rc = msi_bitmap_alloc_hwirqs(&bmp, 2);
> -	check(rc >= 0 && rc % 2 == 0);
> +	WARN_ON(rc < 0 && rc % 2 != 0);

Here and below, shouldn't these be:

	WARN_ON(rc < 0 || rc % 2 != 0);

?

>  	rc = msi_bitmap_alloc_hwirqs(&bmp, 4);
> -	check(rc >= 0 && rc % 4 == 0);
> +	WARN_ON(rc < 0 && rc % 4 != 0);
>  	rc = msi_bitmap_alloc_hwirqs(&bmp, 8);
> -	check(rc >= 0 && rc % 8 == 0);
> +	WARN_ON(rc < 0 && rc % 8 != 0);
>  	rc = msi_bitmap_alloc_hwirqs(&bmp, 9);
> -	check(rc >= 0 && rc % 16 == 0);
> +	WARN_ON(rc < 0 && rc % 16 != 0);
>  	rc = msi_bitmap_alloc_hwirqs(&bmp, 3);
> -	check(rc >= 0 && rc % 4 == 0);
> +	WARN_ON(rc < 0 && rc % 4 != 0);
>  	rc = msi_bitmap_alloc_hwirqs(&bmp, 7);
> -	check(rc >= 0 && rc % 8 == 0);
> +	WARN_ON(rc < 0 && rc % 8 != 0);
>  	rc = msi_bitmap_alloc_hwirqs(&bmp, 121);
> -	check(rc >= 0 && rc % 128 == 0);
> +	WARN_ON(rc < 0 && rc % 128 != 0);
>  
>  	msi_bitmap_free(&bmp);
>  
> -	/* Clients may check bitmap == NULL for "not-allocated" */
> -	check(bmp.bitmap == NULL);
> +	/* Clients may WARN_ON bitmap == NULL for "not-allocated" */
> +	WARN_ON(bmp.bitmap != NULL);
>  
>  	kfree(bmp.bitmap);
>  }
> @@ -229,14 +224,13 @@ static void __init test_of_node(void)
>  	of_node_init(&of_node);
>  	of_node.full_name = node_name;
>  
> -	check(0 == msi_bitmap_alloc(&bmp, size, &of_node));
> +	WARN_ON(msi_bitmap_alloc(&bmp, size, &of_node));
>  
>  	/* No msi-available-ranges, so expect > 0 */
> -	check(msi_bitmap_reserve_dt_hwirqs(&bmp) > 0);
> +	WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp) <= 0);
>  
>  	/* Should all still be free */
> -	check(0 == bitmap_find_free_region(bmp.bitmap, size,
> -					   get_count_order(size)));
> +	WARN_ON(bitmap_find_free_region(bmp.bitmap, size, get_count_order(size)));
>  	bitmap_release_region(bmp.bitmap, 0, get_count_order(size));
>  
>  	/* Now create a fake msi-available-ranges property */
> @@ -250,11 +244,11 @@ static void __init test_of_node(void)
>  	of_node.properties = &prop;
>  
>  	/* msi-available-ranges, so expect == 0 */
> -	check(msi_bitmap_reserve_dt_hwirqs(&bmp) == 0);
> +	WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp));
>  
>  	/* Check we got the expected result */
> -	check(0 == bitmap_parselist(expected_str, expected, size));
> -	check(bitmap_equal(expected, bmp.bitmap, size));
> +	WARN_ON(bitmap_parselist(expected_str, expected, size));
> +	WARN_ON(!bitmap_equal(expected, bmp.bitmap, size));
>  
>  	msi_bitmap_free(&bmp);
>  	kfree(bmp.bitmap);
> 

---
Best Regards, Laurentiu
