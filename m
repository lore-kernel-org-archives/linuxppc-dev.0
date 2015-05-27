Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39C761A1765
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 19:25:03 +1000 (AEST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 27 May 2015 10:25:00 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7C24017D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 10:25:52 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4R9OvHe20774980
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 09:24:57 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4R9Ouxl015617
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 03:24:56 -0600
Date: Wed, 27 May 2015 11:24:48 +0200
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] fbuffer: improve toggle cursor performance
Message-ID: <20150527112448.6a6c78fb@bahia.local>
In-Reply-To: <20150527075934.1d3a49db@thh440s>
References: <20150527001113.2506.23159.stgit@bahia.huguette.org>
 <20150527075934.1d3a49db@thh440s>
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

On Wed, 27 May 2015 07:59:34 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On Wed, 27 May 2015 02:11:13 +0200
> Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:
> 
> > SLOF currently calls hv-logical-load and hv-logical-store for every pixel
> > when enabling or disabling the cursor. This is suboptimal when writing one
> > char at a time to the console since terminal-write always toggles the cursor.
> > And this is precisely what grub is doing when the user wants to edit a menu
> > entry... the result is an incredibly slow and barely usable interface.
> > 
> > The inner loop in fb8-toggle-cursor handles a contiguous region: it can be
> > converted to hv-logical-memop. The result is 32 times less hcalls per char
> > and a serious improvement in grub usability.
> 
> Good idea for an optimization!
> 

Heh no big deal... the hardest part was to find that the LOAD/STORE avalanche
was coming from these rb@ and rb! words. SLOF is still a mysterious beast to
me :)

> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > ---
> >  slof/fs/fbuffer.fs |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
> > index 756f05a..46b59bf 100644
> > --- a/slof/fs/fbuffer.fs
> > +++ b/slof/fs/fbuffer.fs
> > @@ -99,8 +99,8 @@ CREATE bitmap-buffer 400 4 * allot
> >  : fb8-toggle-cursor ( -- )
> >  	line# fb8-line2addr column# fb8-columns2bytes +
> >  	char-height 0 ?DO
> > -		char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP
> > -		screen-width screen-depth * + char-width screen-depth * -
> > +		dup dup 0 char-width screen-depth * 1 hv-logical-memop drop
> > +		screen-width screen-depth * +
> >  	LOOP drop
> >  ;
> 
> If you use hv-logical-memop in this file here, you definitely break
> board-js2x, since this is bare metal and hv-logical-memop is not
> defined there.
> 

Of course, this is common code... I'll remember for next time. :)

> I think you should either move the new function to board-qemu and handle
> it there like it is done for hcall-invert-screen already, or we could
> think of introducing a helper function that is defined by each board
> which does the xor operation on a memory region (that way we could
> maybe also unify hcall-invert-screen and fb8-invert-screen again).
> 

I guess the first proposal is the obvious fix. From there, we can
work out a patchset for the second proposal.

>  Thomas
> 

Cheers.

--
Greg
