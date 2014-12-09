Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D47E1A0555
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 19:53:46 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Tue, 9 Dec 2014 08:53:41 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7353C2190045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 08:53:09 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB98rcck55771234
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 08:53:38 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB98rbXd016345
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 01:53:37 -0700
Date: Tue, 9 Dec 2014 09:53:33 +0100
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2 1/4] powerpc: drop the ability to tweak SMT mode at
 boot time
Message-ID: <20141209095333.170bf702@bahia.local>
In-Reply-To: <1418098262.527.1.camel@concordia>
References: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20141205151341.11028.47570.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <1417805565.334.15.camel@freescale.com>
 <1418098262.527.1.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 09 Dec 2014 15:11:02 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Fri, 2014-12-05 at 12:52 -0600, Scott Wood wrote:
> > On Fri, 2014-12-05 at 16:14 +0100, Greg Kurz wrote:
> > > The smt-enabled kernel parameter basically leaves unwanted cpus executing
> > > in firmware or wherever they happen to be. The very same applies to the
> > > ibm,smt-enabled DT property which is no more used by anything known. These
> > > are hacks that shoudn't be used in a production environment.
> > > 
> > > Quoting mpe, "there are better ways for firmware to disable SMT".
> > 
> > Those "better ways" don't apply to Freescale chips, where the OS enables
> > (or not) SMT without any interaction with firmware.
> 
> But how does it know there even are SMT threads? From the device tree? So
> just don't present the threads in the device tree?
> 
> cheers
> 
> 

Michael,

Maybe we can first kill the cpu_bootable hook in powernv only, for bug fix.
Then we can take time to do the thing right for all platforms. Thoughts ?

--
Greg
