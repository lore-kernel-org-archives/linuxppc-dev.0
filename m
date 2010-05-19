Return-Path: <markn@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 008BAB7D70
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 May 2010 16:50:32 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4J6kuXJ003742
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 16:46:56 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4J6hHOs1425600
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 16:43:17 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4J6oWFq010671
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 16:50:32 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, michael@ellerman.id.au
Subject: Re: [PATCH] powerpc/pseries: Make request_ras_irqs() available to
	other pseries code
Date: Wed, 19 May 2010 16:54:42 +1000
References: <201005172233.01183.markn@au1.ibm.com>
	<201005191635.43544.markn@au1.ibm.com>
	<1274250954.7574.1.camel@concordia>
In-Reply-To: <1274250954.7574.1.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201005191654.42483.markn@au1.ibm.com>
Cc: Tseng-hui Lin <tsenglin@us.ibm.com>, engebret@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 19 May 2010 16:35:54 Michael Ellerman wrote:
> On Wed, 2010-05-19 at 16:35 +1000, Mark Nelson wrote:
> > Hi Michael,
> > 
> > Thanks for looking over these patches!
> ..
> > > 
> > > Existing code I know, but the error handling in here is a little lax,
> > > what's not going to work if we miss some or all of the interrupts?
> > 
> > That's a good point. For the existing code, if we miss an EPOW event
> > it just means that the event won't be logged (as that's all we do with
> > those events at the moment, although there is a comment saying
> > that it should be fixed to take appropriate action depending upon the
> > type of power failure); but it's a bigger problem if we miss one of the
> > RAS errors because then we could miss a fatal event that we should halt
> > the machine on. And for the upcoming IO events it's even worse as we'd
> > miss an interrupt from the device...
> 
> Yeah that's what I was thinking.
> 
> > I would do it in a follow-on patch rather than this one, but what would
> > be a good course of action if we can't request the interrupt?
> 
> Yes a follow on patch is the way to do it.
> 
> There shouldn't be that many reasons the request fails, other than
> ENOMEM, or broken device tree perhaps. It's definitely worth a
> WARN_ON(), people notice those at least.

That sounds good. I'll do a simple follow-on patch that adds the
WARN_ON().

Thanks!
Mark
