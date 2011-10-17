Return-Path: <vinod.koul@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id 99B1EB6F65
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 04:10:03 +1100 (EST)
Subject: Re: [RFC PATCH 1/2] RapidIO: Add DMA Engine support for RIO data
 transfers
From: Vinod Koul <vinod.koul@intel.com>
To: Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <CAJe_ZhdjMTsqSTDwV_zaAQKmCbjOtRVc951wxqKScaCR-DBG9Q@mail.gmail.com>
References: <1317418715-9666-1-git-send-email-alexandre.bounine@idt.com>
 <1317492077.1573.1839.camel@vkoul-udesk3>
 <0CE8B6BE3C4AD74AB97D9D29BD24E55202291E40@CORPEXCH1.na.ads.idt.com>
 <1317965252.1573.2238.camel@vkoul-udesk3>
 <0CE8B6BE3C4AD74AB97D9D29BD24E552022D6C9A@CORPEXCH1.na.ads.idt.com>
 <1318700142.23438.45.camel@vkoul-udesk3>
 <CAJe_ZhdjMTsqSTDwV_zaAQKmCbjOtRVc951wxqKScaCR-DBG9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 Oct 2011 22:31:24 +0530
Message-ID: <1318870884.23438.174.camel@vkoul-udesk3>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, "Bounine,
 Alexandre" <Alexandre.Bounine@idt.com>, Dan <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-10-17 at 21:22 +0530, Jassi Brar wrote:
> On 15 October 2011 23:05, Vinod Koul <vinod.koul@intel.com> wrote:
> 
> > Another alternate approach could be to add one more argument to
> > prep_slave_sg API which allows us to pass additional runtime specific
> > parameters. This can be NULL and unused for existing drivers and used in
> > RIO and any future subsystems which want to use dmaengine.
> > Thoughts...?
> >
> That doesn't sound much different than passing the data via
> dma_chan.private during prep_slave_sg. Only now we add to
> the number of arguments.
Yes agreed, but we already decided and marked it as depreciated.

> And then either this argument would be RapidIO specific (unfair
> to other users) or generic. In latter case what would it look like ?
My initial thoughts were to add an argument which only the specific dmac
knows howto decode and is filled by its client. As i said for existing
users and people who don't require dynamic information wouldn't bother.
The pros
 - allows us to support RIO kind of subsystems where one needs to pass
subsystem specific information for programing the dmac
 - doesn't require us to add subsystem specific stuff in dmaengine,
today its RIO tomorrow some other folks may want to add. We want to
maintain dmaengine as a generic framework, while also trying to support
multiple audiences.
Cons:
 - there is no guarantee;  dmac expects foo and clients pass bar

I am okay if we have alternate way to support this with above goal :)

-- 
~Vinod
