Return-Path: <msalter@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D7C41A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 12:50:15 +1100 (AEDT)
Message-ID: <1448243411.8209.36.camel@redhat.com>
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
From: Mark Salter <msalter@redhat.com>
To: Ming Lei <ming.lei@canonical.com>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Christoph Hellwig <hch@infradead.org>, "James E. J.
 Bottomley" <JBottomley@odin.com>, brking <brking@us.ibm.com>, Linux SCSI
 List <linux-scsi@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org
Date: Sun, 22 Nov 2015 20:50:11 -0500
In-Reply-To: <CACVXFVMAm1niRvXqQXjOXW=ryy41d-ne09wSNbJUq3b9o6vJ7w@mail.gmail.com>
References: <1447838334.1564.2.camel@ellerman.id.au>
 <1447855399.3974.24.camel@redhat.com>
 <1447894964.15206.0.camel@ellerman.id.au>
 <20151119082325.GA11419@infradead.org>
 <1448021448.14769.7.camel@ellerman.id.au>
 <565055C6.5040801@linux.vnet.ibm.com> <20151122005635.1b9ffbe1@tom-T450>
 <1448234410.8209.3.camel@redhat.com>
 <CACVXFVMAm1niRvXqQXjOXW=ryy41d-ne09wSNbJUq3b9o6vJ7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-23 at 08:36 +0800, Ming Lei wrote:
> On Mon, Nov 23, 2015 at 7:20 AM, Mark Salter <msalter@redhat.com> wrote:
> > On Sun, 2015-11-22 at 00:56 +0800, Ming Lei wrote:
> > > On Sat, 21 Nov 2015 12:30:14 +0100
> > > Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
> > > 
> > > > On 20/11/2015 13:10, Michael Ellerman wrote:
> > > > > On Thu, 2015-11-19 at 00:23 -0800, Christoph Hellwig wrote:
> > > > > 
> > > > > > It's pretty much guaranteed a block layer bug, most likely in the
> > > > > > merge bios to request infrastucture where we don't obey the merging
> > > > > > limits properly.
> > > > > > 
> > > > > > Does either of you have a known good and first known bad kernel?
> > > > > 
> > > > > Not me, I've only hit it one or two times. All I can say is I have hit it in
> > > > > 4.4-rc1.
> > > > > 
> > > > > Laurent, can you narrow it down at all?
> > > > 
> > > > It seems that the panic is triggered by the commit bdced438acd8 ("block:
> > > > setup bi_phys_segments after splitting") which has been pulled by the
> > > > merge d9734e0d1ccf ("Merge branch 'for-4.4/core' of
> > > > git://git.kernel.dk/linux-block").
> > > > 
> > > > My system is panicing promptly when running a kernel built at
> > > > d9734e0d1ccf, while reverting the commit bdced438acd8, it can run hours
> > > > without panicing.
> > > > 
> > > > This being said, I can't explain what's going wrong.
> > > > 
> > > > May Ming shed some light here ?
> > > 
> > > Laurent, looks there is one bug in blk_bio_segment_split(), would you
> > > mind testing the following patch to see if it fixes your issue?
> > > 
> > > ---
> > > From 6fc701231dcc000bc8bc4b9105583380d9aa31f4 Mon Sep 17 00:00:00 2001
> > > From: Ming Lei <ming.lei@canonical.com>
> > > Date: Sun, 22 Nov 2015 00:47:13 +0800
> > > Subject: [PATCH] block: fix segment split
> > > 
> > > Inside blk_bio_segment_split(), previous bvec pointer('bvprvp')
> > > always points to the iterator local variable, which is obviously
> > > wrong, so fix it by pointing to the local variable of 'bvprv'.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@canonical.com>
> > > ---
> > >  block/blk-merge.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > > index de5716d8..f2efe8a 100644
> > > --- a/block/blk-merge.c
> > > +++ b/block/blk-merge.c
> > > @@ -98,7 +98,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
> > > 
> > >                       seg_size += bv.bv_len;
> > >                       bvprv = bv;
> > > -                     bvprvp = &bv;
> > > +                     bvprvp = &bvprv;
> > >                       sectors += bv.bv_len >> 9;
> > >                       continue;
> > >               }
> > > @@ -108,7 +108,7 @@ new_segment:
> > > 
> > >               nsegs++;
> > >               bvprv = bv;
> > > -             bvprvp = &bv;
> > > +             bvprvp = &bvprv;
> > >               seg_size = bv.bv_len;
> > >               sectors += bv.bv_len >> 9;
> > >       }
> > 
> > I'm still hitting the BUG even with this patch applied on top of 4.4-rc1.
> 
> OK, looks there are still other bugs, care to share us how to reproduce
> it on arm64?
> 
> thanks,
> Ming

Unfortunately, the best reproducer I have is to boot the platform. I have seen the
BUG a few times post-boot, but I don't have a consistant reproducer. I am using
upstream 4.4-rc1 with this config:

  http://people.redhat.com/msalter/fh_defconfig

With 4.4-rc1 on an APM Mustang platform, I see the BUG about once every 6-7 boots.
On an AMD Seattle platform, about every 9 boots.

I have a script that loops through an ssh command to reboot the platform under test.
I manually install test kernels and then run the script and wait for failure. While
debugging, I have tried more minimal configs with which I have been unable to
reproduce the problem even after several hours of reboots. With the above mentioned
fh_defconfig, I have been able to get a failure within 20 or so boots with most
kernel builds but at certain kernel commits, the failure has taken a longer time to
reproduce.

>From my POV, I can't say which commit causes the problem. So far, I have not been
able to reproduce at all before commit d9734e0d1ccf but I am currently trying to
reproduce with commit 0d51ce9ca1116 (one merge earlier than d9734e0d1ccf).
