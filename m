Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrVyC2wMQzF1ZP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 07:42:59 +1100 (AEDT)
Date: Tue, 27 Feb 2018 14:42:43 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
Message-ID: <20180227204243.GW21977@gate.crashing.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
 <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
 <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com>
 <603d5335-6220-73f2-d902-b92bc74bc79e@c-s.fr>
 <CA+7wUsys=J8vkEOtzd26B6MGEhfTBRzaA_myuUWNzf24rMvn+A@mail.gmail.com>
 <CAHp75VePco3hNo_vM916CiLzBAd18i=O1TaecD5YEDewvMpYYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VePco3hNo_vM916CiLzBAd18i=O1TaecD5YEDewvMpYYQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 27, 2018 at 05:52:06PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 27, 2018 at 9:44 AM, Mathieu Malaterre <malat@debian.org> wrote:
> > On Tue, Feb 27, 2018 at 8:33 AM, Christophe LEROY
> > <christophe.leroy@c-s.fr> wrote:
> 
> >>>>> Much simpler is just add
> >>>>>
> >>>>> if (ARRAY_SIZE() == 0)
> >>>>>   return;
> 
> >> Or add in front:
> >> if (!ARRAY_SIZE(feature_properties))
> >>         return;
> >
> > (not tested) I believe the compiler still go over the for() loop and
> > will complain about the original unsigned comparison.
> 
> Did you run tests? Did you look into object file?
> 
> In kernel we much rely on the compiling away the code which is
> deterministically not in use.
> Here I'm pretty sure it will compile away entire function.

It does, but it also still warns (this warning is done very early in the
compiler pipeline).


Segher
