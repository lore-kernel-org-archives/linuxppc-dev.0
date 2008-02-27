Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 81171DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 07:32:42 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1RKWAuH016752
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 15:32:10 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1RKWchh218322
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 13:32:38 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1RKWccK008070
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 13:32:38 -0700
Date: Wed, 27 Feb 2008 14:31:01 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: jyoung5@us.ibm.com
Subject: Re: [dtc] breaking out libfdt from dtc so other progs can use it
Message-ID: <20080227143101.7a262aae@zod.rchland.ibm.com>
In-Reply-To: <1204141243.18831.12.camel@thinkpad.austin.ibm.com>
References: <1204141243.18831.12.camel@thinkpad.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 27 Feb 2008 13:40:43 -0600
Jerone Young <jyoung5@us.ibm.com> wrote:

> Currently the dtc source code has libfdt integrated in it. This seems to
> have become place for upstream libfdt changes. Now we all know everyone
> (linux kernel, cuboot) also have their own versions over libfdt. But if
> another userspace app wants to use libfdt , it has to copy it from the
> dtc source and try to maintain it's own copy.
> 
> The question I have is can libfdt be split out from dtc source, and
> become it's own thing. This way other userspace apps can easily download
> it and link with it?

Downloading isn't changed at all by splitting it out to it's own repo.

> The reason I ask is I have added dynamic manipulation support of device
> trees in memory into qemu for KVM. But the issue is keeping a copy of
> libfdt in the KVM userspace repository, which is getting some opposition
> (understandably). But this would be much easier if there was a libfdt
> repo for the library so that we wouldn't need to keep our own copy.

It seems the real crux of your issue is that you want distros to
provide a libfdt package.  That can be done by creating a subpackage
off of the dtc package.  The harder part for certain distros will be
either convincing them to allow the static libfdt to exist, or creating
a shared library for it instead.

josh
