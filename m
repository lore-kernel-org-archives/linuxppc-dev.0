Return-Path: <SRS0+d6cead0195db3fcd630e+1282+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B70ADDE27
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 12:17:16 +1100 (EST)
Subject: Re: Make sure we populate the initroot filesystem late enough
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
Content-Type: text/plain
Date: Sun, 25 Feb 2007 20:17:40 -0500
Message-Id: <1172452660.3971.33.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
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

On Sun, 2007-02-25 at 16:24 -0800, Linus Torvalds wrote:
> Hmm. No, I don't think that should be a problem. free_initmem() only 
> happens at the very, after do_basic_setup() has been run, which
> includes all the initcall stuff.

I'm inclined to agree that it _shouldn't_ be a problem. Nevertheless,
even this hack seems sufficient to 'fix' it:

--- arch/powerpc/mm/init_32.c   2007-02-25 20:06:54.000000000 -0500
+++ arch/powerpc/mm/init_32.c.not       2007-02-25 20:06:41.000000000 -0500
@@ -243,13 +243,14 @@ void free_initmem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
        if (start < end)
-               printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+               printk ("NOT Freeing initrd memory: %ldKiB would be freed\n", (end - start) >> 10);
+       return;
        for (; start < end; start += PAGE_SIZE) {
                ClearPageReserved(virt_to_page(start));
                init_page_count(virt_to_page(start));
                free_page(start);
                totalram_pages++;
        }
 }
 #endif


-- 
dwmw2
