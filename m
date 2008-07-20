Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id C6F43DDDD8
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 06:17:17 +1000 (EST)
Date: Sun, 20 Jul 2008 15:17:08 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] Don't panic when EEH_MAX_FAILS is exceeded
Message-ID: <20080720201708.GP9594@localdomain>
References: <488383D4.9000602@us.ibm.com>
	<20080720145858.5be92934@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080720145858.5be92934@lappy.seanm.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan wrote:
> On Sun, 20 Jul 2008 11:28:36 -0700
> "Mike Mason" <mmlnx@us.ibm.com> wrote:
> 
> > This patch changes the EEH_MAX_FAILS action from panic to printing an
> > error message.  Panicking under under this condition is too harsh.
> > Although performance will be affected and the device may not recover,
> > the system is still running, which at the very least, should allow
> > for a more graceful shutdown.  The panic() is now wrapped in a DEBUG
> > statement for development purposes.  The patch also removes the
> > msleep() within a spinlock, which is not allowed.
> 
> Why can you not msleep within a spinlock? And when was this change
> brought in?

Giving up the cpu while holding a spinlock risks locking up the system
in the worst case -- if another task tries to acquire the held lock it
can spin indefinitely.
