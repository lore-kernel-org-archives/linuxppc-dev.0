Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 58B5BB7D5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 00:31:34 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH][RFC] ibm_newemac and SIOCGMIIREG
Date: Thu, 10 Jun 2010 16:31:29 +0200
References: <4C10EFE0.6030106@harris.com>
In-Reply-To: <4C10EFE0.6030106@harris.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201006101631.29591.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 10 June 2010, Steven A. Falco wrote:
> I believe there is a bug in the way the ibm_newemac driver handles the
> SIOCGMIIREG (and SIOCSMIIREG) ioctl.  The problem is that emac_ioctl
> is handed a "struct ifreq *rq" which contains a user-land pointer to
> an array of 16-bit integers.

Did you actually see a bug here, or just think that this could be
a problem?

> However, emac_ioctl directly accesses the data, which doesn't work.
> I added the following patch to copy the data in and out.
> 
> Please note that this patch was tested in an older kernel (2.6.30)
> because that is what we are using on our custom hardware.  I think
> this is still a problem in the current code, but I'd like reviewers
> to take a look, to be sure.

The ifreq structure passed into the ndo_ioctl function is in kernel
space, it gets copied there by net/core/dev.c:dev_ioctl().
emac_ioctl only accesses the data in that structure, so a copy_from_user
is wrong here as far as I can tell.

	Arnd
