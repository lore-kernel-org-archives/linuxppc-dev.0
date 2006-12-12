Return-Path: <root@ucw.cz>
Received: from spitz.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id 2177F67BF7
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 00:20:33 +1100 (EST)
Date: Tue, 12 Dec 2006 13:20:24 +0000
From: Pavel Machek <pavel@suse.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [RFC 3/3] suspend to disk on powermac G5
Message-ID: <20061212132023.GD5190@ucw.cz>
References: <20061211230208.526233000@sipsolutions.net>>
	<20061211230754.979775000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061211230754.979775000@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, Torrance <torrance123@gmail.com>,
	Michael Buesch <mb@bu3sch.de>, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> This patch implements a very hacky suspend to disk for powermac G5 machines. I
> know it's broken in many places.
> 
> Built and tested against the tree after commit
> 620034c84d1d939717bdfbe02c51a3fee43541c3.
> 
> For some reason usb doesn't survive suspend even if I try to restore
> interrupts now... I use this script:
...
> Oh and did I say this is hacky? MMIO save/restore, the need to hook many
> places, no proper MPIC suspend/resume functionality, snd-aoa doesn't work
> after resume (it plays but no sound comes out, interrupts are coming in
> though... go figure, eh wait, since I wrote it I guess I'll check it too).

Does aoa module load/unload help? Does making it build-in help? Also
try playing with aumix after resume.

> I also ifdef'ed out
> 
> 	set_context(current->active_mm->context.id, current->active_mm->pgd);
> 
> because I didn't know what it is doing and it works without :)
> 
> I've suspended and resumed a few times in a row with this now, with and
> without longer breaks with the machine up and with the machine off.
> 
> Ah who am I kidding... This is pretty much guaranteed to break. Parts of the
> assembly code are quite old (written like half a year ago) so I don't
> remember some things... Why, for example, the save area has holes. I shall
> fix these some time I guess.
> 


> +	/* phew. suckers. this 16MB area is left unmapped
> +	 * at another place but they don't bother to mark it so */
> +	for (i = 0; i < (1<<24); i+= PAGE_SIZE)
> +		SetPageNosave(virt_to_page((void*)((unsigned long)dart_tablebase + i)));
> +

Can you move that marking where it belongs?

> +	if (dart_tablebase == 0 || dart_tablesize == 0)
> +		return;
> +
> +	p = alloc_pages(GFP_KERNEL, 9);
> +	BUG_ON(!p);
> +	dart_copy = page_address(p);
> +}

Not sure how likely is 2MB allocation to succeed. You may need to
prealocate it... And you definitely will need to handle error here.


> --- linux-2.6-git.orig/kernel/power/snapshot.c	2006-12-11 23:34:46.718716759 +0100
> +++ linux-2.6-git/kernel/power/snapshot.c	2006-12-11 23:38:00.152716759 +0100
> @@ -707,6 +707,8 @@ static struct page *saveable_page(unsign
>  		return NULL;
>  	if (PageNosaveFree(page))
>  		return NULL;
> +	if (!page_is_ram(pfn))
> +		return NULL;
>  
>  	return page;
>  }

Could this get some testing in -mm?

Overall, it looks pretty much okay. Thanks...

							Pavel
-- 
Thanks for all the (sleeping) penguins.
