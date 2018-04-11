Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LgbL0kY7zDrnm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 20:42:21 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id v5-v6so1097025plo.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 03:42:21 -0700 (PDT)
Date: Wed, 11 Apr 2018 20:42:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] powerpc/config: powernv_defconfig updates
Message-ID: <20180411204209.6f7e1a05@roar.ozlabs.ibm.com>
In-Reply-To: <CAKTCnzmsrU1WCW54ZuX=1oSGt2Pv3wSZ=NYR-692ZmzkowC0nw@mail.gmail.com>
References: <20180411091203.28141-1-npiggin@gmail.com>
 <CAKTCnzmsrU1WCW54ZuX=1oSGt2Pv3wSZ=NYR-692ZmzkowC0nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 11 Apr 2018 20:04:45 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> On Wed, Apr 11, 2018 at 7:12 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > For consideration:
> >
> > * Add IPv6 support built in + additional modules - Because it's 2018 maan.
> > * Add DEFERRED_STRUCT_PAGE_INIT - Let's see what breaks.  
> 
> We did not find any benefits with this on a P8 in terms of boot time
> with large memory. May be worth reinvestigating

Worth putting in the defconfig just for testing until then?

> 
> > * Add PPC_MEMTRACE - Small powernv debugfs driver for getting hardware traces.
> > * Add MEMORY_FAILURE - Machine check exceptions can now drive memory failure.

         ^^^^
Okay for this one?

> > * Turn on FANOTIFY - This is the current filesystem notification feature.
> > * Turn on SCOM_DEBUGFS - Handy for hardware/firmware debugging, security risk?  
> 
> Yep, should not be in defconfig, IMHO

Why not? Honest question, I hear some things about secure
boot when I ask about this option but I'm not quite sure why, or
what we are securing here.

If the firmware does not want us to mess with scoms, it should
restrict the call, no?


> > * Turn on async SCSI scanning - Let's see what breaks.
> >
> > * Make a bunch of USB hid drivers modules.
> > * Make SCSI SG, SR, and FC modules - FC is huge.
> > * Make video drivers (except AST GPU) modules - Also huge.
> > * Add MLX5 driver as a module - Popular demand.
> > * Make PCI serial driver a module - Uncommon?
> >
> > * Get rid of /dev/port - Not used.
> > * Remove legacy BSD ttys - Long dead.
> > * Remove IDE - Deprecated and replaced with ATA.
> > * Remove WIRELESS - Until we get POWER9 laptops.
> > * Remove RAW - Long deprecated in favour of direct IO.
> > * Remove floppy, parport, and PS2 input devices - not supported.
> > * Remove virtio drivers, ballooning - We're host only.  
> 
> I still think its good to have them, may be as modules? Should I
> switch to powerpc64le_defconfig for a single config with everything --
> same kernel as guest and bare metal?

Well powernv_defconfig never supports PAPR guest. I think the ppc64
defconfig does both (and pseries has no bare metal).

Is there a reason to use them in host? And if yes, which ones? We
could easily make them as modules.

Thanks,
Nick
