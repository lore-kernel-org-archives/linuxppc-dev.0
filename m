Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [194.196.100.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BD23EB6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jul 2011 00:24:37 +1000 (EST)
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p64EOVgK030878
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2011 14:24:31 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p64EOUOq2576522
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2011 15:24:30 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p64EOTnK018142
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2011 08:24:30 -0600
Date: Mon, 4 Jul 2011 16:24:29 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: hvc_console change results in corrupt oops output
Message-ID: <20110704142429.GA2147@linux.vnet.ibm.com>
References: <20110704205738.742e56d0@kryten>
	<1309787787.14501.268.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309787787.14501.268.camel@pasglop>
Cc: borntraeger@de.ibm.com, brueckner@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 04, 2011 at 11:56:27PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2011-07-04 at 20:57 +1000, Anton Blanchard wrote:
> 
>  .../...
> 
> > The hypervisor gives us a busy return, so we could retry a number of
> > times instead of dropping it on the floor. We'd need to do it in the
> > hvc_console driver - the tty drivers share the same backend
> > functions so we can't hide it in the pseries put_chars function.
> 
> For kernel console, I don't see why not wait forever ... If the
> underlying backend really lost the connection it can always return a
> negative error no ?
> 
> Or we could have "well defined" return codes for "wait forever" vs.
> "drop this" ... maybe return -EAGAIN.

I will check this again for my hvc_iucv back-end.  Meanwhile a found
an old thread discussing the same issue.  It covers some differences
between console and ttys which actually does not matter for hvc-backend
because of the shared put_chars() routine.

You can read the thread on lkml.org: http://lkml.org/lkml/2009/10/15/149


Kind regards,
  Hendrik
