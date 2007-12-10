Return-Path: <FENKES@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E58E7DDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 04:57:51 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id lBAHvknR108414
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 17:57:46 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lBAHvlKI2732104
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 18:57:47 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lBAHvkxC015697
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 18:57:47 +0100
In-Reply-To: <OF85E31FAA.DADA6039-ONC12573AA.005439C8-C12573AA.005A132E@LocalDomain>
To: Arnd Bergmann <arnd@arndb.de>, "OF-EWG" <ewg@lists.openfabrics.org>,
	"OF-General" <general@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Roland Dreier <rdreier@cisco.com>, Roland Dreier <rolandd@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF9AA24809.F691A5CC-ONC12573AD.006155D6-C12573AD.0062ABE2@de.ibm.com>
Date: Mon, 10 Dec 2007 18:59:16 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, guys,

> We're taking this to the firmware architects at the moment, but they're 
not 
> very fond of the idea of reporting the absence of bugs through 
capability 
> flags, as this could quickly lead to the exhaustion of flag bits. We'll 
let 
> the discussion stew for a bit, but if we don't get this flag, we'll have 
to 
> resort to the CPU features.

The architects have spoken, and we're getting a capability flag for this. 
I'll repost my patch with new autodetection code that doesn't involve 
checking the processor version.
 
> >  > Regarding the performance problem, have you checked whether 
converting all
> >  > your spin_lock_irqsave to spin_lock/spin_lock_irq improves your 
performance
> >  > on the older machines? Maybe it's already fast enough that way.
> > 
> > It does seem that the only places that the hcall_lock is taken also
> > use msleep, so they must always be in process context.  So you can
> > safely just use spin_lock(), right?
>
> As Arnd said, there are hCalls that will never return H_LONG_BUSY_*, 
such as 
> H_QUERY_PORT and chums, so they will never sleep. The surrounding 
functions, 
> though, are not prepared to be called from interrupt context (GFP_KERNEL 
comes
> to mind), so I agree that a simple spin_lock() will suffice. Thanks, 
Arnd, for
> pointing this out.

As I pointed out in my earlier mail, there's still an issue with 
map_phys_fmr possibly sleeping. Let's keep the irqsave for the time being 
and revisit this part once we find a solution to map_phys_fmr.

Regards,
  Joachim
