Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D6261A115C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 19:01:47 +1000 (AEST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 27 May 2015 10:01:42 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C4EA7219005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 10:01:18 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4R91bin25296898
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 09:01:38 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4R91bil014028
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 03:01:37 -0600
Date: Wed, 27 May 2015 11:01:32 +0200
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] fbuffer: improve toggle cursor performance
Message-ID: <20150527110132.430fff05@bahia.local>
In-Reply-To: <87egm2a9lh.fsf@abhimanyu.in.ibm.com>
References: <20150527001113.2506.23159.stgit@bahia.huguette.org>
 <87egm2a9lh.fsf@abhimanyu.in.ibm.com>
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

On Wed, 27 May 2015 10:41:06 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> Greg Kurz <gkurz@linux.vnet.ibm.com> writes:
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
> >
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
> 
> Why did you drop "char-width screen-depth * -" in the new code? This is
> not me mentioned in the description.
> 

This is because the current inner loop increments the address. When the loop
ends, we're pointing at the next char, that is char-width * screen-depth bytes
too far.

In the new code, the address is duped on the stack before calling hv-logical-memop,
so we don't need to fix it when proceeding to next line.

In my first attempt, I forgot to drop the subtraction and got an interesting
visual result :)

> Regards
> Nikunj

Cheers.

--
Greg
