Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C7838DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 12:41:09 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m1S1eYOE019950
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 12:40:34 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1S1f7Bn3911750
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 12:41:07 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1S1fCkf029921
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 12:41:12 +1100
Date: Thu, 28 Feb 2008 12:41:01 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Jerone Young <jyoung5@us.ibm.com>
Subject: Re: [dtc] breaking out libfdt from dtc so other progs can use it
Message-ID: <20080228014101.GA24330@localhost.localdomain>
References: <1204141243.18831.12.camel@thinkpad.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204141243.18831.12.camel@thinkpad.austin.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 27, 2008 at 01:40:43PM -0600, Jerone Young wrote:
> Currently the dtc source code has libfdt integrated in it. This seems to
> have become place for upstream libfdt changes. Now we all know everyone
> (linux kernel, cuboot) also have their own versions over libfdt. But if
> another userspace app wants to use libfdt , it has to copy it from the
> dtc source and try to maintain it's own copy.
> 
> The question I have is can libfdt be split out from dtc source, and
> become it's own thing. This way other userspace apps can easily download
> it and link with it?
> 
> The reason I ask is I have added dynamic manipulation support of device
> trees in memory into qemu for KVM. But the issue is keeping a copy of
> libfdt in the KVM userspace repository, which is getting some opposition
> (understandably). But this would be much easier if there was a libfdt
> repo for the library so that we wouldn't need to keep our own copy.

Um.. libfdt was moved into the dtc repo for convenience, both for us
writing it (they help to test each other), and for those using it -
don't have to have separate pulls for these closely related tools.

I don't understand why you're finding the merged libfdt inconvenient.
"make" will build both dtc and libfdt, and libfdt can be easily taken
out and embedded on other projects.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
