Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C8DBDDF6F
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 02:53:31 +1100 (EST)
Subject: Re: Make sure we populate the initroot filesystem late enough
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1172452660.3971.33.camel@shinybook.infradead.org>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
	<1172452660.3971.33.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 16:51:39 +0100
Message-Id: <1172505099.11949.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	john stultz <johnstul@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-02-25 at 20:17 -0500, David Woodhouse wrote:
> On Sun, 2007-02-25 at 16:24 -0800, Linus Torvalds wrote:
> > Hmm. No, I don't think that should be a problem. free_initmem() only 
> > happens at the very, after do_basic_setup() has been run, which
> > includes all the initcall stuff.
> 
> I'm inclined to agree that it _shouldn't_ be a problem. Nevertheless,
> even this hack seems sufficient to 'fix' it:

Could be a powerpc specific bug in initrd handling... I'm still
traveling so I can't really look at it right now, but I wouldn't be
surprised if some of that code did indeed bitrot.

Ben.

> --- arch/powerpc/mm/init_32.c   2007-02-25 20:06:54.000000000 -0500
> +++ arch/powerpc/mm/init_32.c.not       2007-02-25 20:06:41.000000000 -0500
> @@ -243,13 +243,14 @@ void free_initmem(void)
>  #ifdef CONFIG_BLK_DEV_INITRD
>  void free_initrd_mem(unsigned long start, unsigned long end)
>  {
>         if (start < end)
> -               printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
> +               printk ("NOT Freeing initrd memory: %ldKiB would be freed\n", (end - start) >> 10);
> +       return;
>         for (; start < end; start += PAGE_SIZE) {
>                 ClearPageReserved(virt_to_page(start));
>                 init_page_count(virt_to_page(start));
>                 free_page(start);
>                 totalram_pages++;
>         }
>  }
>  #endif
> 
> 
