Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk [81.2.110.251])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA0D22C0096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 00:48:17 +1000 (EST)
Date: Tue, 14 Aug 2012 15:52:27 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART delay in receive
Message-ID: <20120814155227.018988da@pyramind.ukuu.org.uk>
In-Reply-To: <201208141426.q7EEQSPc003956@localhost.localdomain>
References: <201208141426.q7EEQSPc003956@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Aug 2012 16:26:28 +0200
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Hello,
> 
> I'm not sure who to address this Patch to either
> 
> It fixes a delay issue with CPM UART driver on Powerpc MPC8xx.
> The problem is that with the actual code, the driver waits 32 IDLE patterns before returning the received data to the upper level. It means for instance about 1 second at 300 bauds.
> This fix limits to one byte the waiting period.

Take a look how the 8250 does it - I think you want to set the value
based upon the data rate. Your patch will break it for everyone doing
high seed I/O.

Alan
