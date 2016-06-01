Return-Path: <dalias@aerifal.cx>
Received: from brightrain.aerifal.cx (216-12-86-13.cv.mvl.ntelos.net
 [216.12.86.13])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rKl9Y0bzxzDqVp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 08:18:08 +1000 (AEST)
Date: Wed, 1 Jun 2016 18:18:02 -0400
From: Rich Felker <dalias@libc.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: Build regressions/improvements in v4.7-rc1
Message-ID: <20160601221801.GF10893@brightrain.aerifal.cx>
References: <1464593333-10283-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVvK9h2MLVAeB3n8G6hfKJU1Rma2_uVYBTqsFxnRv2YsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdVvK9h2MLVAeB3n8G6hfKJU1Rma2_uVYBTqsFxnRv2YsA@mail.gmail.com>
Sender: Rich Felker <dalias@aerifal.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 30, 2016 at 09:34:07AM +0200, Geert Uytterhoeven wrote:
> >   + /home/kisskb/slave/src/arch/sh/kernel/setup.c: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]:  => 256:2
> 
> sh-randconfig

Nice find. I think I'm incorrectly checking for CONFIG_OF in places
that should actually be checking for CONFIG_OF_FLATTREE. Does that
look right to you? Nothing breaks in actual configurations that make
sense now, only if you enable OF manually without selecting
SH_DEVICE_TREE as your board.

If you can confirm that my assessment is correct I'll include a fix in
my (now-late) pull request.

Rich
