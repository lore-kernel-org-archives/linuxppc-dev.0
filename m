Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id A62392C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 23:57:37 +1000 (EST)
Date: Sat, 1 Jun 2013 06:58:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: Improve device hotplug initialization
Message-ID: <20130601135809.GA6395@roeck-us.net>
References: <1369762514-27352-1-git-send-email-linux@roeck-us.net>
 <51A5CAC1.6030800@freescale.com>
 <20130531051423.GA15505@roeck-us.net>
 <1369979047.3928.112.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369979047.3928.112.camel@pasglop>
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Chen Yuanquan-B41889 <B41889@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 31, 2013 at 03:44:07PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2013-05-30 at 22:14 -0700, Guenter Roeck wrote:
> > On Wed, May 29, 2013 at 05:30:41PM +0800, Chen Yuanquan-B41889 wrote:
> > > On 05/29/2013 01:35 AM, Guenter Roeck wrote:
> > > >bios_add_device(). Drop explicit calls to pcibios_setup_device();
> > > >this makes pcibios_setup_bus_devices() a noop function which could
> > > >eve
> > > 
> > > Yeah, it's more reasonable to do the irq and DMA related initialization
> > > in one code path for all devices.
> > > 
> > Any comments / feedback on the code itself ?
> 
> Sorry, I haven't had a chance to review it yet, I'm fairly bogged down
> at the moment. I want to tread carefully because the previous iteration
> of changing that stuff did break a few platforms in the end.
> 
Hi Ben,

the comment was actuially directed towards Yuanquan.

No problem, take your time. I did my best to test it, but I agree that this is a
critical area of the code, and it would be desirable to get additional scrutiny
and test feedback.

The code has been running in our system (P2020 and P5040) for several months.
I was preparing a patch for upstream submission when I noticed commit 37f02195b.
After testing ithis commit, I noticed the problems with it and wrote this patch,
which aligns the code with our initial patch. I tested it as good as I could on
our systems as well as with a P5040 evaluation board and an Intel GE PCIe
card.

Thanks,
Guenter
