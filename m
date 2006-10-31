Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 696E467BDC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 02:08:17 +1100 (EST)
Date: Tue, 31 Oct 2006 18:08:16 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] CPM_UART: Fix non-console transmit
Message-ID: <20061031180816.3d32c285@vitb.ru.mvista.com>
In-Reply-To: <Pine.OSF.4.61.0610191549130.318096@kosh.hut.fi>
References: <Pine.OSF.4.61.0610191549130.318096@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Laurent, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 19 Oct 2006 15:52:11 +0300 (EEST)
Kalle Pokki <kalle.pokki@iki.fi> wrote:

> The SMC and SCC hardware transmitter is enabled at the wrong
> place. Simply writing twice to the non-console port, like
> 
> $ echo asdf > /dev/ttyCPM1
> $ echo asdf > /dev/ttyCPM1
> 
> puts the shell into endless uninterruptible sleep, since the
> transmitter is stopped after the first write, and is not enabled
> before the shutdown function of the second write. Thus the transmit
> buffers are never emptied.
> 
> Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

Paul: please apply. 

I am recalling addressing something like the upper, but dunno why it haven't pushed 
upstream. Something around re-use scc/smc did not feel good with this approach, but it is 
much less important than the odd behavior expressed.

-- 
Sincerely, 
Vitaly
