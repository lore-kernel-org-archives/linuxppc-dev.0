Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5BA0BDDF70
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 23:00:25 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m9GBwhrd451658
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 11:58:43 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9GBwhJZ3543070
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 12:58:43 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9GBwgra018998
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 12:58:42 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC PATCH 4/5] hvc_console: Add tty window resizing
Date: Thu, 16 Oct 2008 13:58:40 +0200
References: <20081014091247.433079967@linux.vnet.ibm.com>
	<20081014091413.306993844@linux.vnet.ibm.com>
	<200810162241.29883.rusty@rustcorp.com.au>
In-Reply-To: <200810162241.29883.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810161358.40428.borntraeger@de.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Donnerstag, 16. Oktober 2008 schrieb Rusty Russell:
> > The patch provides the hvc_resize() function to update the terminal
> > window dimensions (struct winsize) for a specified hvc console.
> > The function stores the new window size and schedules a function
> > that finally updates the tty winsize and signals the change to
> > user space (SIGWINCH).
> > Because the winsize update must acquire a mutex and might sleep,
> > the function is scheduled instead of being called from hvc_poll()
> > or khvcd.
> 
> I want this functionality for lguest, too.  But I don't see anything which 
> uses this call yet?   Are we going to use the config_change notifier from 
> virtio?  (Which IIRC neither S/390 nor lguest have plumbed in).

I have some prototype patches for virtio_console, but did not find the time to 
finish them.

Christian
