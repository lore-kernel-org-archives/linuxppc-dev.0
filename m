Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C566DDF4C
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 21:17:54 +1100 (EST)
Date: Wed, 10 Dec 2008 10:17:45 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH] fork_init: fix division by zero
Message-ID: <20081210101745.GG28946@ZenIV.linux.org.uk>
References: <200812092044.40649.yur@emcraft.com>
	<Pine.LNX.4.64.0812100944080.25126@vixen.sonytel.be>
	<503391615.20081210130113@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <503391615.20081210130113@emcraft.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 10, 2008 at 01:01:13PM +0300, Yuri Tikhonov wrote:

> >> +     max_threads = mempages * PAGE_SIZE / (8 * THREAD_SIZE);
> >                       ^^^^^^^^^^^^^^^^^^^^
> >> +#endif
> 
> > Can't this overflow, e.g. on 32-bit machines with HIGHMEM?
> 
>  The multiplier here is not PAGE_SIZE, but [PAGE_SIZE / (8 * 
> THREAD_SIZE)], and this value is expected to be rather small (2, 4, or 
> so).

x * y / z is parsed as (x * y) / z, not x * (y / z).

Only assignment operators (and ?:, in a sense that a ? b : c ? d : e is
parsed as a ? b : (c ? d : e)) are right-to-left.  The rest is left-to-right.
