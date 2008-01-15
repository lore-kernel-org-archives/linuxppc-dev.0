Return-Path: <dhbaird@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by ozlabs.org (Postfix) with ESMTP id 159E7DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 11:14:17 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1093650nzh.39
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Jan 2008 16:14:15 -0800 (PST)
Message-ID: <440abda90801141614u777edfbndc5d2c61f927dd4f@mail.gmail.com>
Date: Mon, 14 Jan 2008 17:14:14 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem booting Linux 2.6 on Virtex-4
In-Reply-To: <20080114210954.AC436CF8050@mail36-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <440abda90801132112y76f2899by4ef582c9b58fd6b6@mail.gmail.com>
	<62D97388-4D65-4B40-A0D1-847963FF0A16@upb.de>
	<440abda90801141211m52bd0a3bk67014c6df2bf406c@mail.gmail.com>
	<20080114210954.AC436CF8050@mail36-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Steve,

On Jan 14, 2008 2:09 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> What kernel version are you targeting? Are you using arch/powerpc or arch/ppc?  V4 has a data cache errata, which isn't currently in mainline arch/powerpc.

I am using arch/ppc/, but to be honest, I don't yet know what the
difference is between those two trees.

Also, I am still learning how to use git, but it appears that I am
using this version:

    Tags: v2.6.24-rc7

I am actually using OpenEmbedded which executes the following commands
to get the Linux tree:

     git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
     cd linux-2.6
     git clone git://git.secretlab.ca/git/linux-2.6-virtex.git  master

>         if((mfpvr() & 0xfffff000) == 0x20011000) {
>             /* PPC errata 213: only for Virtex-4 FX */
>             __asm__("mfccr0  0\n\t"
>                     "oris    0,0,0x50000000@h\n\t"
>                     "mtccr0  0"
>                     : : : "0");
>         }

I tried out this code snippit, but it did not help :-(  I also looked
in head.S and found that this was already in there:

    #if defined(CONFIG_XILINX_VIRTEX_4_FX)
      /* PPC errata 213: only for Virtex-4 FX */
      mfccr0  0
      oris    0,0,0x50000000@h
      mtccr0  0
    #endif

Today, I tried a completely fresh design in EDK 9.2i (whereas I had
been using 9.1i).  I tried the design found in
EDKexamples/Virtex4_PPC_Example_9_2.zip.  This design works :-)  I am
not sure why it works (or rather, why the other one did not work), but
it works.

-David

(P.S. - Sorry I forgot to send to this to the list on the first try)
