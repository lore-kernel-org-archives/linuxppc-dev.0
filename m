Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE017.bigfish.com (ch1ehsobe003.messaging.microsoft.com
	[216.32.181.183]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B7209B6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jul 2011 14:17:39 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: hvc_console change results in corrupt oops output
Date: Tue, 5 Jul 2011 04:17:32 +0000
Message-ID: <CAOZdJXW0Lota0ZuEnOHhsU93v7WmvYztEMyfg+UsMKxFdoXNXQ@mail.gmail.com>
References: <20110704205738.742e56d0@kryten>
	<1309787787.14501.268.camel@pasglop>
	<20110704142429.GA2147@linux.vnet.ibm.com>
In-Reply-To: <20110704142429.GA2147@linux.vnet.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Anton Blanchard <anton@samba.org>,
	"borntraeger@de.ibm.com" <borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 4, 2011 at 9:24 AM, Hendrik Brueckner
<brueckner@linux.vnet.ibm.com> wrote:

> I will check this again for my hvc_iucv back-end. =A0Meanwhile a found
> an old thread discussing the same issue. =A0It covers some differences
> between console and ttys which actually does not matter for hvc-backend
> because of the shared put_chars() routine.
>
> You can read the thread on lkml.org: http://lkml.org/lkml/2009/10/15/149

I started that thread.  After much soul searching, we came to the
conclusion that HVC is not compatible with hypervisors that return
BUSY on writes.  So I threw out my HVC driver and rewrote it as a
standard console and TTY driver.  That driver is waiting to be
included in the 3.1 kernel.

--=20
Timur Tabi
Linux kernel developer at Freescale=
