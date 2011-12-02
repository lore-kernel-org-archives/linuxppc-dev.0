Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from earthlight.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
 [81.2.110.250])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F325CB6F67
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 22:47:58 +1100 (EST)
Date: Fri, 2 Dec 2011 11:49:30 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/3] serial: make bugs field not specific to 8250 type
 uarts.
Message-ID: <20111202114930.74b65569@lxorguk.ukuu.org.uk>
In-Reply-To: <CAP=VYLpn7kJJ6we3diqhCR+QzjQtzTmkEzSP-uw07=udJKYK6g@mail.gmail.com>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
 <1322783258-20443-2-git-send-email-paul.gortmaker@windriver.com>
 <20111202005150.2e9fde43@bob.linux.org.uk>
 <CAP=VYLpn7kJJ6we3diqhCR+QzjQtzTmkEzSP-uw07=udJKYK6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> If you have an idea in mind how arch/platform code should cleanly
> pass data about known uart bugs to the uart driver, then let me know
> what you have in mind.  I've no real attachment to what I proposed
> here -- it just happened to be the solution I thought would be the least
> offensive.  If there is a better idea floating around, I'll go ahead and
> try to implement it.

My first guess is that "the uart driver" is our first historical mistake.
Non standard 8250ish uarts should be their own platform driver which uses
8250.c for support.

Things like 8250_dw.c is perhaps more the style we want to be looking at
for other devices and adjusting 8250.c as needed to export or split
methods up so they can be used as helpers.

Alan
