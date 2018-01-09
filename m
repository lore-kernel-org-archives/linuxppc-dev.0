Return-Path: <srs0=nsyw=ee=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG4W52vjDzF0ds
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 19:07:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zG4W448fNz8tMZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 19:07:28 +1100 (AEDT)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zG4W40lhdz9sNV
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2018 19:07:28 +1100 (AEDT)
Date: Tue, 9 Jan 2018 09:05:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jon Masters <jcm@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, mikey@neuling.org,
 Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, npiggin@gmail.com,
 linuxppc-dev@ozlabs.org, oohall@gmail.com,
 Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 09/11] powerpc/64s: Allow control of RFI flush via sysfs
Message-ID: <20180109080527.GA32120@kroah.com>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-9-mpe@ellerman.id.au>
 <alpine.DEB.2.20.1801081818060.1735@nanos>
 <87y3l880js.fsf@concordia.ellerman.id.au>
 <f4a66b7c-0ee0-07da-b327-42ba6a8c704b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f4a66b7c-0ee0-07da-b327-42ba6a8c704b@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 09, 2018 at 01:06:23AM -0500, Jon Masters wrote:
> Knowing that the IBM team was going to post with this sysfs interface,
> our trees contain the rfi_flush file. I mentioned it to some folks on
> this end (because we know we don't want to add things in sysfs
> generally, debugfs is a good substitute, per Andrea, and I raised this
> with him yesterday as a concern in the backport here) but in the end it
> seemed reasonable to pull this in because it was what got posted, and as
> Michael says, it's gone into other distro kernels beyond just ours.

What distro kernels end up enabling does not really reflect on what we
end up doing in mainline.  The api for this should NOT be arch-specific
if at all possible, that way lies madness.  Do you want to write
userspace tools to handle the 60+ different arch implementations?

Don't let the fragmentation problems of the period in which no one was
allowed to talk to each other, result in a unchangable mess, that would
be insane.

thanks,

greg k-h
