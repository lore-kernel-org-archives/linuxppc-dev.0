Return-Path: <SRS0+d6cead0195db3fcd630e+1282+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6685DDE20
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 11:44:40 +1100 (EST)
Subject: Re: Make sure we populate the initroot filesystem late enough
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
Content-Type: text/plain
Date: Sun, 25 Feb 2007 19:45:04 -0500
Message-Id: <1172450704.3971.30.camel@shinybook.infradead.org>
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
> happens at the very, after do_basic_setup() has been run, which includes 
> all the initcall stuff.

> However, it's an interesting observation. How sure are you that it's this 
> commit that triggers it. You say "This seems to be what's triggering ..", 
> I'm wondering how firm that is.. 

I found it with git-bisect. The Fedora kernel has been broken on this
particular 512MiB Mac Mini for a while, and now I've reverted the patch
it seems to be fine again. So I'm fairly sure. I'll be surer in a few
minutes once the full RPM build has finished with the patch reverted.

Of course, it could easily be an entirely separate bug which by some
bizarre coincidence is just triggered by this.

-- 
dwmw2
