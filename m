Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CDD63DE0E8
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 03:44:11 +1100 (EST)
Date: Mon, 10 Mar 2008 11:50:17 -0500
From: Olof Johansson <olof@lixom.net>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Confused about usercopy_64.c
Message-ID: <20080310165017.GA24812@lixom.net>
References: <47D56419.6000704@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47D56419.6000704@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 10, 2008 at 11:38:49AM -0500, Timur Tabi wrote:
> I'm confused about something in usercopy_64.c:
> 
> unsigned long copy_from_user(void *to, const void __user *from, unsigned long n)
> {
> 	if (likely(access_ok(VERIFY_READ, from, n)))
> 		n = __copy_from_user(to, from, n);
> 	else
> 		memset(to, 0, n);
> 	return n;
> }
> 
> If access_ok() returns false, then that means that we cannot copy the data from
> user-space.  So why are we returning 'n'?  Shouldn't we return zero, to let the
> caller know that the function failed?

copy_from_user() returns number of bytes _not_ copied.


-Olof
