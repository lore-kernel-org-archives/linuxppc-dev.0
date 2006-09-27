Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0151F67BC7
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 22:55:37 +1000 (EST)
Date: Wed, 27 Sep 2006 16:55:56 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Message-ID: <20060927165556.04c8d5d7@vitb.ru.mvista.com>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 27 Sep 2006 20:02:56 +0800
"Li Yang-r58472" <LeoLi@freescale.com> wrote:

> > -----Original Message-----
> > From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> > Sent: Wednesday, September 27, 2006 7:56 PM
> > To: Paul Mackerras
> > Cc: Li Yang-r58472; linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
> > 
> > On Wed, 27 Sep 2006 16:39:11 +1000
> > Paul Mackerras <paulus@samba.org> wrote:
> > 
> > > Li Yang writes:
> > >
> > > > +#define BCSR_PHYS_ADDR		((uint)0xf8000000)
> > > > +#define BCSR_SIZE		((uint)(32 * 1024))
> > >
> > > This sort of thing should really be in the device tree.
> > >
> > Just a suggestion, but for the similar aim in pq2 I have those stuff
> in memory node :
> > 
> > +memory {
> > +               device_type = "memory";
> > +               linux,phandle = <300>;
> > +               reg = <00000000 4000000 f4500000 00000020>;
> > +       };
> > the second pair is about bcsr and its size.
> > 
> > Just in case this may help (and wondering if I'm not violating
> something :) )
> 
> Well, this can make it work.  But I would prefer to use a new node
> because the BCSR is by no means a memory type of device.  I have made my
> change to use node like this:
> 
>         bcsr@f8000000 {
>                 device_type = "board-control";
>                 reg = <f8000000 8000>;
>         };
> 

I though about that approach, but saw somewhere a reference that we should not summon new node types without utter necessity, and utilized memory because bcsr is memory-mapped stuff. I can hardly imagine bcsr as a device (which would require respective spec inclusion btw).

hence let's open a discussion what others think about that. The problem seems common (and for some boards 
is called somewhat else apparently), but at this point we should come to some conclusion, document it, and use it.

-- 
Sincerely, 
Vitaly
