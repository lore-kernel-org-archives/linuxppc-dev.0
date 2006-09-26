Return-Path: <vbordug@ru.mvista.com>
Date: Tue, 26 Sep 2006 20:28:46 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Pelton, Dave" <dpelton@ciena.com>
Subject: Re: fs_enet - support for SCC on CPM2?
Message-ID: <20060926202846.4a47f8fc@vitb.ru.mvista.com>
In-Reply-To: <3B9518857C91E345AA1806A6F53C0EB7019F342B@onmxm01.ciena.com>
References: <3B9518857C91E345AA1806A6F53C0EB7019F342B@onmxm01.ciena.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 26 Sep 2006 11:22:30 -0400
"Pelton, Dave" <dpelton@ciena.com> wrote:

> > -----Original Message-----
> > From: Matt Hevern
> <snip>
> > 
> > I am trying to compile for an freescale 82xx (CPM2) series 
> > processor, with ethernet on an SCC. (kernel 2.6.x)  From what 
> > i can see, in the file drivers/net/fs_enet/fs_enet-main.c,
> > the config option "CONFIG_FS_ENET_HAS_SCC"  pulls in 
> > "fs_scc_ops" which are defined in 
> > drivers/net/fs_enet/mac-scc.c, but this file  does not seem 
> > to have support for 82xx series, failing with various compile errors:
> <snip>
> > It seems like these errors are mostly due to the driver being tailored
> for 8xx series.
> <snip>
> 
> I had the same problem trying to use fs_enet for 82xx SCC Ethernet and
> came to the same conclusion.  The FCC could not be used instead of the
> SCC because of pin limitations in the hardware design.  I ended up using
> the "old" SCC Ethernet driver by disabling CONFIG_FS_ENET_HAS_SCC and
> enabling CONFIG_SCC_ENET (Under CPM2 options in kernel config).  This
> does not use the new platform bus structure, and arch/ppc/8260_io/enet.c
> may require some board specific tweaks, but it does work.
> 

Scc Ethernet on 82xx was not supported because the hardware it was developed on 
did not support such an option at all.

That was the reason why scc_enet is "tailored" for 8xx. If there is a desire and HW to
make it work, please go ahead, I'll assist as per time permits, and make sure the stuff 
will be merged upstream.

Obsoleted things like 8260_io may disappear sooner or later (I bet sooner is more probably...)

-- 
Sincerely, 
Vitaly
