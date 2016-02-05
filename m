Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20A191A0243
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 21:22:29 +1100 (AEDT)
Date: Fri, 5 Feb 2016 11:22:24 +0100
From: Petr Mladek <pmladek@suse.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Jiri Kosina <jikos@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Torsten Duwe <duwe@lst.de>,
 live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
Message-ID: <20160205102222.GD3305@pathway.suse.cz>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de>
 <56B1AAE5.10500@linaro.org>
 <alpine.LNX.2.00.1602030952220.22727@cbobk.fhfr.pm>
 <20160203112449.GA27247@lst.de> <56B31A7C.2050803@linaro.org>
 <20160204110224.GD731@pathway.suse.cz>
 <CAKTCnznB8WQGbuJkek7nhnXW6FSBR+Mk__jeNfpgfpTf8G9MMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKTCnznB8WQGbuJkek7nhnXW6FSBR+Mk__jeNfpgfpTf8G9MMA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 2016-02-05 15:40:27, Balbir Singh wrote:
> On Thu, Feb 4, 2016 at 10:02 PM, Petr Mladek <pmladek@suse.com> wrote:
> For big endian builds I saw
> 
> Dump of assembler code for function alloc_pages_current:
>    0xc000000000256f00 <+0>:    mflr    r0
>    0xc000000000256f04 <+4>:    std     r0,16(r1)
>    0xc000000000256f08 <+8>:    bl      0xc000000000009e5c <.mcount>
>    0xc000000000256f0c <+12>:    mflr    r0
> 
> The offset is 8 bytes. Your earlier patch handled this by adding 16, I
> suspect it needs revisiting

It seems to be one of the funcitons that do not access any global
symbol. gcc does not produce TOC handling in this case when
compiled with -mprofile-kernel. I believe that it is a gcc bug.
More details can be found in the thread starting at
http://thread.gmane.org/gmane.linux.kernel/2134759/focus=2141996

Best Regards,
Petr
