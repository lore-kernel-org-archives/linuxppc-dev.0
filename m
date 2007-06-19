Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2816DDEE3
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 06:40:34 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1I0kPm-0002cP-RO
	for linuxppc-dev@ozlabs.org; Tue, 19 Jun 2007 22:35:03 +0200
Received: from 069-064-229-129.pdx.net ([69.64.229.129])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 22:35:02 +0200
Received: from shemminger by 069-064-229-129.pdx.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 22:35:02 +0200
To: linuxppc-dev@ozlabs.org
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: 2.6.22: ERROR: "__ucmpdi2" [drivers/net/s2io.ko] undefined!
Date: Tue, 19 Jun 2007 13:10:21 -0700
Message-ID: <20070619131021.1c814098@localhost.localdomain>
References: <20070619190253.GA19419@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <20070619190253.GA19419@aepfle.de>
Sender: news <news@sea.gmane.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 19 Jun 2007 21:02:53 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> 
> What happend to __ucmpdi2 from David Woodhouse?
> google has a few hits about stuff like this on 32bit powerpc with gcc 4.1.2:
> 
> ERROR: "__ucmpdi2" [drivers/net/s2io.ko] undefined!
> 
> using the drivers/net/s2io* files from 2.6.21 with 2.6.22-rc5 fixes the
> compile.
> 
> 25805dcf9d83098cf5492117ad2669cd14cc9b24 adds two u64 >>= 48 followed by
> a switch statement (line 2889 and 6816).

Probably the "switch(err) {" needs a cast to a smaller type (like u8).
-- 
Stephen Hemminger <shemminger@linux-foundation.org>
