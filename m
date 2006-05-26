Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp4.wanadoo.fr (smtp4.wanadoo.fr [193.252.22.27])
	by ozlabs.org (Postfix) with ESMTP id 6B50D67B16
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 02:20:36 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0407.wanadoo.fr (SMTP Server) with ESMTP id 805E81C003EF
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 18:20:29 +0200 (CEST)
Date: Fri, 26 May 2006 18:15:18 +0200
To: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on powerp c pl
	atform
Message-ID: <20060526161517.GB11778@powerlinux.fr>
References: <1147935734.17679.93.camel@localhost.localdomain>
	<446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca>
	<20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca>
	<20060526114245.GA32330@powerlinux.fr>
	<44770065.8070907@rtr.ca> <20060526141535.GA7084@powerlinux.fr>
	<447722FF.9020202@rtr.ca> <20060526160156.GA11778@powerlinux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060526160156.GA11778@powerlinux.fr>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Alexandre.Bounine@tundra.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Mark Lord <liml@rtr.ca>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 26, 2006 at 06:01:56PM +0200, Sven Luther wrote:
> > Can you access the disk?  Eg.  hexdump -C /dev/sda
> 
> Trying to partition the disk with parted yielded the last set of debug
> messages, and a : 

Interesting. Using dd, i am able to write some stuff to disk :

dd if=/dev/sda of=/tmp/blah count=1 -> hexdump /tmp/blah yields only 0s.
dd if=/dev/random of=/dev/sda count=4 (count = 4, because /dev/random outputs blocks of 128 bytes)
dd if=/dev/sda of=/tmp/blah count=1 -> hexdump /tmp/blah yield random non-0 content

Trying to write past the first block, seems to freeze the disk or someting, at
least dd doesn't come back without me ctr-c'ing it.

Friendly,

Sven Luther
