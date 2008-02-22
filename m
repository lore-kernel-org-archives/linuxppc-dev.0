Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 06FAEDDF09
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 02:50:40 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so109795anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 07:50:39 -0800 (PST)
Message-ID: <fa686aa40802220750y645c5f15y79377e3bec4d76f@mail.gmail.com>
Date: Fri, 22 Feb 2008 08:50:39 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [PATCH] Add support for binary includes.
In-Reply-To: <1203670971.5771.41.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<fa686aa40802212205p38c3793bg8793740955b1e91@mail.gmail.com>
	<1203670971.5771.41.camel@shinybook.infradead.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 22, 2008 at 2:02 AM, David Woodhouse <dwmw2@infradead.org> wrote:
>
>  On Thu, 2008-02-21 at 23:05 -0700, Grant Likely wrote:
>  > Can I ask; what is the intended usage of such a thing?  How large
>  > would a typical binary blob be?
>
>  Device firmware?

That's what I was wondering about.  Is this really a good idea?
Effectively, in the Linux kernel the device tree is being used as a
big blob of initdata, except that it cannot free the memory allocated
by the device tree when it is complete.  As it is right now, device
trees seem to weigh in between 4-8kB, a pretty insignificant size for
memory that cannot be reclaimed.  However, if firmware blobs start
getting added to the tree that size could balloon pretty quickly.

I'm not actually opposed to the feature, and I understand that it is
needed for the new u-boot image format, but I think we need some usage
guidelines in place when this feature is merged.  As much as possible
I think we should be directing developers to use the existing firmware
loading facilities in the Linux kernel.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
