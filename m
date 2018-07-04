Return-Path: <bhe@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L75w2ZVSzF1Qp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 14:18:44 +1000 (AEST)
Date: Wed, 4 Jul 2018 12:18:34 +0800
From: Baoquan He <bhe@redhat.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Josh Triplett <josh@joshtriplett.org>,
 kbuild test robot <fengguang.wu@intel.com>, Borislav Petkov <bp@suse.de>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 David Airlie <airlied@linux.ie>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>, Keith Busch <keith.busch@intel.com>,
 Jon Derrick <jonathan.derrick@intel.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, brijesh.singh@amd.com,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 baiyaowei@cmss.chinamobile.com, richard.weiyang@gmail.com,
 devel@linuxdriverproject.org, linux-input <linux-input@vger.kernel.org>,
 linux-nvdimm@lists.01.org, devicetree <devicetree@vger.kernel.org>,
 linux-pci@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, "David S. Miller" <davem@davemloft.net>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Gustavo Padovan <gustavo@padovan.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>, linux-parisc@vger.kernel.org,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 1/4] resource: Move reparent_resources() to
 kernel/resource.c and make it public
Message-ID: <20180704041834.GA2762@MiWiFi-R3L-srv>
References: <20180612032831.29747-1-bhe@redhat.com>
 <20180612032831.29747-2-bhe@redhat.com>
 <CAHp75Vd6v4+RTq-5uw_BJpT6=w2KGjTfU+rEst6+8igs2cyntw@mail.gmail.com>
 <20180612093812.GC1820@MiWiFi-R3L-srv>
 <CAHp75Vf_kBLkE6v=JyOdfNoWktWEfKs7JzRP1XEc4TeuT5xqfw@mail.gmail.com>
 <CAHp75Vdaqj+n=F7wSB9PFGpf9Ok2XZzKcq_H0DzmtjmN-4UUfw@mail.gmail.com>
 <20180703145503.GA1225@MiWiFi-R3L-srv>
 <CAHp75VeEjhcYF4Fy4O_srdv_nEGGjGwAHhZufscB_tiLQVQ=FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VeEjhcYF4Fy4O_srdv_nEGGjGwAHhZufscB_tiLQVQ=FQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/18 at 11:57pm, Andy Shevchenko wrote:
> On Tue, Jul 3, 2018 at 5:55 PM, Baoquan He <bhe@redhat.com> wrote:
> > On 06/12/18 at 05:24pm, Andy Shevchenko wrote:
> >> On Tue, Jun 12, 2018 at 5:20 PM, Andy Shevchenko
> >> <andy.shevchenko@gmail.com> wrote:
> 
> >> > I briefly looked at the code and error codes we have, so, my proposal
> >> > is one of the following
> >>
> >> >  - use -ECANCELED (not the best choice for first occurrence here,
> >> > though I can't find better)
> >>
> >> Actually -ENOTSUPP might suit the first case (although the actual
> >> would be something like -EOVERLAP, which we don't have)
> >
> > Sorry for late reply, and many thanks for your great suggestion.
> >
> 
> > I am fine to use -ENOTSUPP as the first returned value, and -ECANCELED
> > for the 2nd one.
> 
> I have no strong opinion, but I like (slightly better) this approach ^^^

Done, post v6 in this way, many thanks.

> 
> > Or define an enum as you suggested inside the function
> > or in header file.
> 
> >
> > Or use -EBUSY for the first case because existing resource is
> > overlapping but not fully contained by 'res'; and -EINVAL for
> > the 2nd case since didn't find any one resources which is contained by
> > 'res', means we passed in a invalid resource.
> >
> > All is fine to me, I can repost with each of them.
> 
> >> >  - use positive integers (or enum), like
> >> >   #define RES_REPARENTED 0
> >> >   #define RES_OVERLAPPED 1
> >> >   #define RES_NOCONFLICT 2
> 
> -- 
> With Best Regards,
> Andy Shevchenko
