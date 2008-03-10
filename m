Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DDBB3DDF47
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 03:53:38 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Confused about usercopy_64.c
References: <47D56419.6000704@freescale.com>
Date: Mon, 10 Mar 2008 17:53:31 +0100
In-Reply-To: <47D56419.6000704@freescale.com> (Timur Tabi's message of "Mon\,
	10 Mar 2008 11\:38\:49 -0500")
Message-ID: <jeabl6ikqc.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi <timur@freescale.com> writes:

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
> user-space.  So why are we returning 'n'?

To tell the caller that the function failed.  The result is the number
of bytes _left_ to be copying, ie. zero means success.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
