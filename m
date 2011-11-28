Return-Path: <acrux_it@libero.it>
Received: from outrelay06.libero.it (outrelay06.libero.it [212.52.84.110])
 by ozlabs.org (Postfix) with ESMTP id 0EBB41007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 06:57:00 +1100 (EST)
Date: Mon, 28 Nov 2011 20:56:55 +0100
From: acrux <acrux_it@libero.it>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: sam460ex, sm501 incorrect device id with kernel >=linux-2.6.39
Message-Id: <20111128205655.fc4d3249.acrux_it@libero.it>
In-Reply-To: <CA+5PVA592G1RVdj_C+NMFQ8nHx=0-eaF9Hn3NZ8VabpCTQGi1Q@mail.gmail.com>
References: <20111127173748.9f235741.acrux_it@libero.it>
 <CA+5PVA592G1RVdj_C+NMFQ8nHx=0-eaF9Hn3NZ8VabpCTQGi1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 28 Nov 2011 07:12:38 -0500
Josh Boyer <jwboyer@gmail.com> wrote:

> On Sun, Nov 27, 2011 at 11:37 AM, acrux <acrux_it@libero.it> wrote:
> >
> > Acube Sam460ex has SM502 as onboard video.
> > I got this with any kernel newer than 2.6.38.x thus the framebuffer
> > is lost too:
> >
> > root@sam4x0:~# diff dmesg-2.6.38.8 dmesg-2.6.39.4
> > 1,2c1,3
> > < Using PowerPC 44x Platform machine description
> > < Linux version 2.6.38.8-Sam460ex (root@sam4x0) (gcc version 4.5.3
> > (CRUX PPC) ) #1 Fri Nov 11 22:07:53 CET 2011
> > ---
> >> Using Canyonlands machine description
> >> Initializing cgroup subsys cpu
> 
> You seem to have switched from using the generic PowerPC 44x platform,
> to using a Canyonlands kernel and/or DTB.  Not sure why that is, but
> it's probably not helping your issues at all.
> 

i think it was only a cosmetic change as it was always used
Canyonlands platform and his own proper dtb.


> >> Linux version 2.6.39.4-Sam460ex (root@sam4x0) (gcc version 4.5.3
> >> (CRUX PPC) ) #1 Fri Nov 11 19:06:02 CET 2011
> > 17c18
> > [cut]
> > 161,179c165,167
> > < sm501 0001:00:06.0: SM501 At f5480000: Version 050100c0, 64 Mb,
> > IRQ 19
> 
> > ---
> >> sm501 0001:00:06.0: incorrect device id c0000105
> 
> Something is reading the device ID in the wrong endian (and probably
> everything else).
> 

it seems to be an endianess issue but i didn't find when it was
introduced.  Really strange this kind of issue was never noticed
bumping from 2.6.38.x to 2.6.39.x .

--nico
-- 
GNU/Linux on Power Architecture
CRUX PPC - http://cruxppc.org/
