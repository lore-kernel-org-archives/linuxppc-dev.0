Return-Path: <serge@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EE47FDE199
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 15:01:43 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0U3wbHt012330
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 20:58:37 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0U41alP231120
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 21:01:36 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0U41aa9023281
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 21:01:36 -0700
Date: Thu, 29 Jan 2009 22:01:30 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Oren Laadan <orenl@cs.columbia.edu>
Subject: Re: [PATCH 1/3] powerpc: bare minimum checkpoint/restart
	implementation
Message-ID: <20090130040130.GB30595@us.ibm.com>
References: <1233182478-27113-1-git-send-email-ntl@pobox.com>
	<1233182478-27113-2-git-send-email-ntl@pobox.com>
	<49814FA2.9060108@cs.columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49814FA2.9060108@cs.columbia.edu>
Cc: containers@lists.osdl.org, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quoting Oren Laadan (orenl@cs.columbia.edu):
> > +static void cr_hdr_init(struct cr_hdr *hdr, __s16 type, __s16 len, __u32 parent)
> > +{
> > +	hdr->type = type;
> > +	hdr->len = len;
> > +	hdr->parent = parent;
> > +}
> > +
> 
> This function is rather generic and useful to non-arch-dependent and other
> architectures code. Perhaps put in a separate patch ?

BTW I disagree here - looking through the patch I found
the use of this fn to be very distracting.  To replace 3
simple in-line assignments, I have to verify the order of
4 weird-looking arguments, and actually first try to
remember what 'cr_hdr_init' is supposed to be and do?

That's not meant to be a complaint, just explanation :)

I prefer dropping its use altogether.  Since I believe
most of the functions calling it in this patch shouldn't
exist anyway (just writing 0xdeadbeef into the file), it
all the more should just go away.

-serge
