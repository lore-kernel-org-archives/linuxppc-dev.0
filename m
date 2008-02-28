Return-Path: <jyoung5@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6943DE274
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 04:34:48 +1100 (EST)
Received: from e6.ny.us.ibm.com ([192.168.1.106])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1SGZjEh030474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:35:45 -0500
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1SGWpgP022586
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:32:52 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1SGUi1Z136662
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:30:45 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1SGUiON000321
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:30:44 -0700
Subject: Re: [dtc] breaking out libfdt from dtc so other progs can use it
From: Jerone Young <jyoung5@us.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20080228014101.GA24330@localhost.localdomain>
References: <1204141243.18831.12.camel@thinkpad.austin.ibm.com>
	<20080228014101.GA24330@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 10:30:44 -0600
Message-Id: <1204216244.6676.13.camel@thinkpad.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-02-28 at 12:41 +1100, David Gibson wrote:
> On Wed, Feb 27, 2008 at 01:40:43PM -0600, Jerone Young wrote:
> > Currently the dtc source code has libfdt integrated in it. This seems to
> > have become place for upstream libfdt changes. Now we all know everyone
> > (linux kernel, cuboot) also have their own versions over libfdt. But if
> > another userspace app wants to use libfdt , it has to copy it from the
> > dtc source and try to maintain it's own copy.
> > 
> > The question I have is can libfdt be split out from dtc source, and
> > become it's own thing. This way other userspace apps can easily download
> > it and link with it?
> > 
> > The reason I ask is I have added dynamic manipulation support of device
> > trees in memory into qemu for KVM. But the issue is keeping a copy of
> > libfdt in the KVM userspace repository, which is getting some opposition
> > (understandably). But this would be much easier if there was a libfdt
> > repo for the library so that we wouldn't need to keep our own copy.
> 
> Um.. libfdt was moved into the dtc repo for convenience, both for us
> writing it (they help to test each other), and for those using it -
> don't have to have separate pulls for these closely related tools.
> 
> I don't understand why you're finding the merged libfdt inconvenient.
> "make" will build both dtc and libfdt, and libfdt can be easily taken
> out and embedded on other projects.

The reason for all the contention is that libfdt is more of a shared
userspace library. Even though dtc really has been the only user of it
in userspace at the moment, now I want to add it's use to qemu. What
many are thinking about is the maintenance of the library. There are
still fixes going in the libfdt in dtc. 

If it where broken out of dtc it would be easier to pickup and pull
fixes from it. Even package it so programs can easily build it
standalone.

It's not often any userspace app needs libfdt. But now with
virtualization userspace apps actually can see the device tree in guest
memory and do have all sort of fun with it easily because of libfdt. 

> 
