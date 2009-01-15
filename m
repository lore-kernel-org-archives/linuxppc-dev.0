Return-Path: <chandru@in.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 968DEDE2F5
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 19:13:01 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id n0F8Nn4i052678
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 19:23:50 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0F85OSK148346
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 19:05:24 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0F85NHX022403
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 19:05:24 +1100
From: Chandru <chandru@in.ibm.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
Date: Thu, 15 Jan 2009 13:35:27 +0530
References: <200812241325.49404.chandru@in.ibm.com>
	<1231444992.23462.138.camel@nimitz>
	<200901091637.24658.chandru@in.ibm.com>
In-Reply-To: <200901091637.24658.chandru@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901151335.27649.chandru@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 09 January 2009 16:37:24 Chandru wrote:
> On Friday 09 January 2009 01:33:12 Dave Hansen wrote:
> > Now I'm even more confused.  Could you please send a fully changelogged
> > patch that describes the problem, and how this fixes it?  This just
> > seems like an off-by-one error, which isn't what I thought we had before
> > at all.
> > 
> > I'm also horribly confused why PFN_UP is needed here.  Is 'physbase' not
> > page aligned?  reserve_size looks like it *has* to be.  'end_pfn' is
> > always (as far as I have ever seen in the kernel) the pfn of the page
> > after the area we are interested in and we treat it as such in that
> > function.  In the case of an unaligned physbase, that wouldn't be true.
> > 
> > Think of the case where we have a 1-byte reservation.  start_pfn will
> > equal end_pfn and we won't go into that while loop at *all* and won't
> > reserve anything.
> > 
> > Does 'end_pfn' need fixing?
> > 
> 
> Attached is the console log with debug command line parameters enabled and 
> with couple of more debug statements added to the code.  Please take a look at it. 
> 
> thanks,
> Chandru
> 

Hello Dave, From the debug console output, if there is anything you can add here,
pls let me know.

thanks 
