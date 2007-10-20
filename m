Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 02971DDE9D
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 15:47:30 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so594114wag
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 22:47:30 -0700 (PDT)
Message-ID: <fa686aa40710192247u294b9329p538bbaf715610040@mail.gmail.com>
Date: Fri, 19 Oct 2007 23:47:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Michal Simek" <Monstr@seznam.cz>
Subject: Re: [microblaze-uclinux] RE: [PATCH v3] Device tree bindings for
	Xilinx devices
In-Reply-To: <1300.2720-24480-247293449-1192847306@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071019234347.38C1111C006B@mail3-dub.bigfish.com>
	<1300.2720-24480-247293449-1192847306@seznam.cz>
Cc: Leonid <Leonid@a-k-a.net>, Arnd Bergmann <arnd@arndb.de>,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org,
	Wolfgang Reissnegger <wre@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/19/07, Michal Simek <Monstr@seznam.cz> wrote:
> Hi Steve and all,
> >Here's a full .dts generated using an updated version of
> >gen_mhs_devtree.py, following the proposal.
> >It happens to be a microblaze system, but you get the idea.
>
> I think that is no good idea generate dts with all information.
> Especially information about PVR - number 2 means - Full PVR and you can
> obtain information directly from PVR. It is waste of memory space.
>                         xilinx,pvr = <2>;
>
> In my opinion will be better generate only parameters which you want not all.
> That smells with unusable parameters.

That is the hard part about crafting the dts; deciding which
parameters the OS is going to care about and which ones are
irrelevant.  The goal is to sufficiently and uniquely describe the
board so that the OS can easily figure out what exactly what it needs
to do to drive the board, but not to try and describe every aspect
which it knows about.  Anything that is pollable (ie. USB devices)
doesn't need to be in the tree.

It's also important to remember that the device tree will *never* be
perfect.  Eventually something will come up that the device tree
doesn't describe well(a bug/quirk, something described poorly, etc).
In this case, as long as the device tree is specific enough to
identify which version of the board it is running on; we can alwasy
add platform specific fixups for that unique system.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
