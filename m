Return-Path: <torvalds@linux-foundation.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8E014DDE2D
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 14:45:50 +1100 (EST)
Date: Sun, 25 Feb 2007 19:45:50 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Make sure we populate the initroot filesystem late enough
In-Reply-To: <1172452660.3971.33.camel@shinybook.infradead.org>
Message-ID: <Pine.LNX.4.64.0702251940500.12485@woody.linux-foundation.org>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
	<1172452660.3971.33.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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



On Sun, 25 Feb 2007, David Woodhouse wrote:
> 
> I'm inclined to agree that it _shouldn't_ be a problem. Nevertheless,
> even this hack seems sufficient to 'fix' it:

Ok. Clearly something is using that memory. That said, I *suspect* that 
the commit that you bisected to is just showing the problem indirectly. 
The ordering shouldn't make any difference, but it can obviously make a 
huge difference in various allocation patterns etc, thus just showing a 
pre-existing problem more clearly..

Can you try adding something like

	memset(start, 0xf0, end - start);

to before the return? That might give a better idea of exactly what is 
using it after it's free'd, hopefully by having the user trigger some more 
spectacular oops..

It is, of course, also entirely possible that the rootfs unpacking change 
really *was* buggy, and I am just missing something totally obvious. The 
memset() might still make it more obvious, though. Maybe.


>         if (start < end)
> -               printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
> +               printk ("NOT Freeing initrd memory: %ldKiB would be freed\n", (end - start) >> 10);

.. so adding the "memset()" here would be what I'm suggesting ..

> +       return;

.. and you might as well leave the return there, so that nobody else comes 
along and re-uses the memory. That should just improve on the chances of 
the memset() hopefully catching the problem..

		Linus "I don't see anything wrong" Torvalds
