Return-Path: <jwboyer@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id 7631CDE69D
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 05:59:48 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so2463257rvf.9
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 10:59:47 -0800 (PST)
Date: Thu, 28 Feb 2008 12:59:40 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: jyoung5@us.ibm.com
Subject: Re: [dtc] breaking out libfdt from dtc so other progs can use it
Message-ID: <20080228125940.78f7f2b6@vader.jdub.homelinux.org>
In-Reply-To: <1204216244.6676.13.camel@thinkpad.austin.ibm.com>
References: <1204141243.18831.12.camel@thinkpad.austin.ibm.com>
	<20080228014101.GA24330@localhost.localdomain>
	<1204216244.6676.13.camel@thinkpad.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Feb 2008 10:30:44 -0600
Jerone Young <jyoung5@us.ibm.com> wrote:

> 
> On Thu, 2008-02-28 at 12:41 +1100, David Gibson wrote:
> > On Wed, Feb 27, 2008 at 01:40:43PM -0600, Jerone Young wrote:
> > > Currently the dtc source code has libfdt integrated in it. This seems to
> > > have become place for upstream libfdt changes. Now we all know everyone
> > > (linux kernel, cuboot) also have their own versions over libfdt. But if
> > > another userspace app wants to use libfdt , it has to copy it from the
> > > dtc source and try to maintain it's own copy.
> > > 
> > > The question I have is can libfdt be split out from dtc source, and
> > > become it's own thing. This way other userspace apps can easily download
> > > it and link with it?
> > > 
> > > The reason I ask is I have added dynamic manipulation support of device
> > > trees in memory into qemu for KVM. But the issue is keeping a copy of
> > > libfdt in the KVM userspace repository, which is getting some opposition
> > > (understandably). But this would be much easier if there was a libfdt
> > > repo for the library so that we wouldn't need to keep our own copy.
> > 
> > Um.. libfdt was moved into the dtc repo for convenience, both for us
> > writing it (they help to test each other), and for those using it -
> > don't have to have separate pulls for these closely related tools.
> > 
> > I don't understand why you're finding the merged libfdt inconvenient.
> > "make" will build both dtc and libfdt, and libfdt can be easily taken
> > out and embedded on other projects.
> 
> The reason for all the contention is that libfdt is more of a shared
> userspace library. Even though dtc really has been the only user of it

Actually, in it's current form, it's not.  It's built to be statically
linked, not as a shared library (.a vs. .so).

> in userspace at the moment, now I want to add it's use to qemu. What
> many are thinking about is the maintenance of the library. There are
> still fixes going in the libfdt in dtc. 

You still haven't explained why maintenance is harder or somehow less
doable by having it in the dtc repo.  Maintenance is very much the
concern of the upstream developers, which seem to be saying it's not a
problem for them...

> If it where broken out of dtc it would be easier to pickup and pull
> fixes from it. Even package it so programs can easily build it
> standalone.

That's akin to saying libcrypto should be broken out to be completely
standalone from openssl.  That doesn't make sense either.

josh
