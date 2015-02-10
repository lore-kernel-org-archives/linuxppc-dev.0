Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C23CF1A0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 16:10:33 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 10 Feb 2015 00:10:30 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E85D238C8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 00:10:28 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A5ASSp29098158
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 05:10:28 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A5ARju027240
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 00:10:28 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 00/18] sync opal.h with firmware
In-Reply-To: <1423540744.19657.12.camel@ellerman.id.au>
References: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1423540744.19657.12.camel@ellerman.id.au>
Date: Tue, 10 Feb 2015 16:10:15 +1100
Message-ID: <m3iofanyh4.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> I'm going to be a total pain, and suggest that this is the wrong approach :)
>
> I was on board until patch 15, where you have to add an #ifdef SKIBOOT to guard
> an include, and you have to remove an include on the Linux side.

(the Linux include was actually not used it seems)

> I think the better solution would be to pull all the common parts out into a
> new file, opal-api.h. That file would define the API between Linux & Skiboot,
> and absolutely nothing else.

Sounds fine.

> Both Linux and Skiboot would continue to have an opal.h, which would include
> opal-api.h, and then anything else needed on either side to make a functioning
> opal.h - eg. other includes & definitions (SG_ENTRIES_PER_NODE).
>
> It would also have the advantage that because opal-api.h is a new file, we can
> get it synced from the beginning and not worry about all the whitespace &
> rearranging patches. ie. there'd just be one patch on both sides to add the new
> file and move definitions into it from opal.h.

Sure. I was doing it bit by bit just so that it was reviewable that I
didn't miss anything or violently screw anything up. Plus, there were
things that should be changed in skiboot as well.

> If you don't violently disagree I'll do a patch for that and we can see how it
> looks?

Not violently :)

I'd go back and do a similar thing to skiboot to make them match again
though, having linux/opal-api.h match skiboot/opal.h would just cause
swearing fits :)
