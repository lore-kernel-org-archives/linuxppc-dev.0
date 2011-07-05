Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5DC3B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jul 2011 23:51:24 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: hvc_console change results in corrupt oops output
Date: Tue, 5 Jul 2011 13:51:09 +0000
Message-ID: <4E1316CC.9090000@freescale.com>
References: <20110704205738.742e56d0@kryten>
	<1309787787.14501.268.camel@pasglop>
	<20110704142429.GA2147@linux.vnet.ibm.com>
	<CAOZdJXW0Lota0ZuEnOHhsU93v7WmvYztEMyfg+UsMKxFdoXNXQ@mail.gmail.com>
	<1309846963.14501.270.camel@pasglop>
In-Reply-To: <1309846963.14501.270.camel@pasglop>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
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

Benjamin Herrenschmidt wrote:

> That is a fun conclusion considering that hvc has been written for the
> pseries hypervisor which ... can return BUSY on writes :-)

Go read the original thread.  The problem is that tty writes and console=20
writes are treated the same by the hvc client driver.  If a client driver=20
detects that the hypervisor is busy, it has the choice of either spinning=20
or returning right away.  Spinning is not acceptable for tty output, so=20
all drivers return right away.  hvc then drops the unwritten characters.

According to Hendrik, this is still happening.

> We just need to fix HVC properly.

Where were you two years ago?  I complained about the problem, and even=20
posted a hackish "fix".  The response I got was tepid -- some=20
acknowledgement that the problem exists, but no real desire to fix it by=20
anyone.

So I had no choice but to abandon hvc.  And frankly, I still don't=20
understand why it exists.  Since then, I wrote a very nice console/tty=20
driver, and I have no plans to return to hvc even if the problem is fixed.

--=20
Timur Tabi
Linux kernel developer at Freescale=
