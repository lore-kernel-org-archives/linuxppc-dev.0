Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A3A2DDF18
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 07:28:16 +1100 (EST)
Date: Thu, 11 Dec 2008 20:28:00 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][v2] fork_init: fix division by zero
Message-ID: <20081211202800.GQ28946@ZenIV.linux.org.uk>
References: <200812101950.51958.yur@emcraft.com>
	<20081211121635.ff58193f.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081211121635.ff58193f.akpm@linux-foundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: wd@denx.de, dzu@denx.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, miltonm@bga.com,
	Geert.Uytterhoeven@sonycom.com, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 11, 2008 at 12:16:35PM -0800, Andrew Morton wrote:
> > +#if (8 * THREAD_SIZE) > PAGE_SIZE
> >  	max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
> > +#else
> > +	max_threads = mempages * (PAGE_SIZE / (8 * THREAD_SIZE));
> > +#endif
> 
> The expression you've chosen here can be quite inacccurate, because
> ((PAGE_SIZE / (8 * THREAD_SIZE)) is a small number.  The way to
> preserve accuracy is
> 
> 	max_threads = (mempages * PAGE_SIZE) / (8 * THREAD_SIZE);
> 
> so how about avoiding the nasty ifdefs and doing

Are you sure?  Do they actually cross the page boundaries?
