Return-Path: <dave@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80C7CB7B96
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 03:03:42 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9LFv1Zx018096
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 09:57:02 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n9LG3aWa170372
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 10:03:37 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9LG3Ues006222
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 10:03:32 -0600
Subject: Re: [PATCH 3/5 v4] Export memory_sysdev_class
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4ADF1E42.3020907@austin.ibm.com>
References: <4ADF1C49.2030201@austin.ibm.com> <4ADF1E42.3020907@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 21 Oct 2009 09:03:29 -0700
Message-Id: <1256141009.23737.22.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-10-21 at 09:44 -0500, Nathan Fontenot wrote:
> Export the memory_sysdev_class structure.  This is needed so we can create
> a 'release' file in sysfs in addition to the existing 'probe' file in
> order to support DLPAR removal of memory on the powerpc/pseries platform.
> The new 'release' file will be powerpc/pseries only.

Please do it in generic code.  You may only need it on ppc today, but
somebody else is going to want the same thing tomorrow on another arch.

It's also nice to keep all of the stuff doing the actual sysfs munging
in one place.  I know it'll cost a few stubs for calling in and out of
arch code, but it should save some work down the road for somebody else.

-- Dave
