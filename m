Return-Path: <SRS0+02e0b4ce1b2593a63242+1880+infradead.org+arjan@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C96F9DDE41
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 07:03:42 +1100 (EST)
Date: Thu, 16 Oct 2008 13:02:37 -0700
From: Arjan van de Ven <arjan@infradead.org>
To: David Miller <davem@davemloft.net>
Subject: Re: powerpc allmodconfig
Message-ID: <20081016130237.4984967c@infradead.org>
In-Reply-To: <20081016.124923.222595655.davem@davemloft.net>
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<20081015.220247.262683261.davem@davemloft.net>
	<1224169039.735.57.camel@johannes.berg>
	<20081016.124923.222595655.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@linux-foundation.org, bzolnier@gmail.com, marek.vasut@gmail.com,
	tiwai@suse.de, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, mark.fasheh@oracle.com,
	linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	johannes@sipsolutions.net, linux-ext4@vger.kernel.org,
	dwmw2@infradead.org, dan.j.williams@intel.com, mchehab@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 16 Oct 2008 12:49:23 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:
> #endif
> #define __WARN() warn_on_slowpath(__FILE__, __LINE__)
> #define __WARN_printf(arg...) warn_slowpath(__FILE__, __LINE__, arg)
> #else
> #define __WARN_printf(arg...) __WARN()

the easiest way I suppose would be to do

#define __WARN_printf(arg..) do { printk(arg); __WARN(); } while (0)

any obvious problems with this ?


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
