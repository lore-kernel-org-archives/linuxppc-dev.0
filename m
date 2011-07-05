Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A1871007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jul 2011 16:23:05 +1000 (EST)
Subject: Re: hvc_console change results in corrupt oops output
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tabi Timur-B04825 <B04825@freescale.com>
In-Reply-To: <CAOZdJXW0Lota0ZuEnOHhsU93v7WmvYztEMyfg+UsMKxFdoXNXQ@mail.gmail.com>
References: <20110704205738.742e56d0@kryten>
	<1309787787.14501.268.camel@pasglop>
	<20110704142429.GA2147@linux.vnet.ibm.com>
	<CAOZdJXW0Lota0ZuEnOHhsU93v7WmvYztEMyfg+UsMKxFdoXNXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Jul 2011 16:22:43 +1000
Message-ID: <1309846963.14501.270.camel@pasglop>
Mime-Version: 1.0
Cc: "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-07-05 at 04:17 +0000, Tabi Timur-B04825 wrote:
> On Mon, Jul 4, 2011 at 9:24 AM, Hendrik Brueckner
> <brueckner@linux.vnet.ibm.com> wrote:
> 
> > I will check this again for my hvc_iucv back-end.  Meanwhile a found
> > an old thread discussing the same issue.  It covers some differences
> > between console and ttys which actually does not matter for hvc-backend
> > because of the shared put_chars() routine.
> >
> > You can read the thread on lkml.org: http://lkml.org/lkml/2009/10/15/149
> 
> I started that thread.  After much soul searching, we came to the
> conclusion that HVC is not compatible with hypervisors that return
> BUSY on writes. 

That is a fun conclusion considering that hvc has been written for the
pseries hypervisor which ... can return BUSY on writes :-)

> So I threw out my HVC driver and rewrote it as a
> standard console and TTY driver.  That driver is waiting to be
> included in the 3.1 kernel.

Sucktastic.

We just need to fix HVC properly.

Cheers,
Ben.
