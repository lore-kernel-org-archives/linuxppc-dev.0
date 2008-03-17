Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.248])
	by ozlabs.org (Postfix) with ESMTP id 3F77ADDF3F
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 10:22:36 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so9050225agc.0
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 16:22:34 -0700 (PDT)
Message-ID: <fa686aa40803171622j2183369ei7b384ada72d329d6@mail.gmail.com>
Date: Mon, 17 Mar 2008 17:22:30 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Gortmaker" <paul.gortmaker@windriver.com>
Subject: Re: powerpc: cuImage.* creation error
In-Reply-To: <20080317224607.GA10732@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080317193652.GA9550@cs181133002.pp.htv.fi>
	<20080317200754.GA7383@windriver.com>
	<fa686aa40803171541t6357d304i2e7e5292f084d09d@mail.gmail.com>
	<20080317224607.GA10732@windriver.com>
Cc: linuxppc-dev@ozlabs.org, Adrian Bunk <bunk@kernel.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 4:46 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> In message: Re: powerpc: cuImage.* creation error
>
>
> on 17/03/2008 Grant Likely wrote:
>
>  > On Mon, Mar 17, 2008 at 2:07 PM, Paul Gortmaker
>  > <paul.gortmaker@windriver.com> wrote:
>  > > In message: powerpc: cuImage.* creation error
>  > >
>  > >  @@ -253,8 +253,8 @@ image-$(CONFIG_TQM8540)                     += cuImage.tqm8540
>  > >   image-$(CONFIG_TQM8541)                        += cuImage.tqm8541
>  > >   image-$(CONFIG_TQM8555)                        += cuImage.tqm8555
>  > >   image-$(CONFIG_TQM8560)                        += cuImage.tqm8560
>  > >  -image-$(CONFIG_SBC8548)                        += cuImage.tqm8548
>  > >  -image-$(CONFIG_SBC8560)                        += cuImage.tqm8560
>  > >  +image-$(CONFIG_SBC8548)                        += cuImage.sbc8548
>  > >  +image-$(CONFIG_SBC8560)                        += cuImage.sbc8560
>  >
>  > No, the suffix in the cuImage targets has a 1:1 relationship with dts
>  > files in arch/powerpc/boot/dts/.  If a file doesn't exist there, then
>  > the target cannot be built.
>
>  You should have both the sbc8548.dts and the sbc8560.dts in your tree.
>  They have been in there for several weeks now.

Heh; oops.  I looked but somehow missed them.  I guess I didn't look
hard enough.

Yes, this looks like the right solution.

>  Author: Paul Gortmaker <paul.gortmaker@windriver.com>
>  Date:   Mon Mar 17 18:33:52 2008 -0400
>
>     wrapper: Add entries for tqm8540 and sbc85xx
>
>     The wrapper script didn't have entries for the TQM8540 board and the
>     SBC8548 or SBC8560 boards.  I've assumed that the TQM8540 console is
>     8250 based and not CPM based by looking at its defconfig.  There was
>     also a trailing * on the TQM8555 entry that I removed too.
>
>
>     Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
