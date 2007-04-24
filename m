Return-Path: <FENKES@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05513DDE20
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 22:25:42 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l3OCPZw6164460
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 12:25:35 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3OCPaRi3965004
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 14:25:36 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3OCPZ6e025074
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 14:25:35 +0200
In-Reply-To: <ada3b2q7v9t.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH] eHCA: Add "Modify Port" verb
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF9075E217.B145AD0F-ONC12572C7.0042D705-C12572C7.00443EC9@de.ibm.com>
Date: Tue, 24 Apr 2007 14:25:34 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
	OF-General <general@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier <rdreier@cisco.com> wrote on 23.04.2007 21:20:14:

>  > +   if (hipz_h_query_port(shca->ipz_hca_handle, port, rblock) != 
H_SUCCESS) {
>  > +      ehca_err(&shca->ib_device, "Can't query port properties");
>  > +      ret = -EINVAL;
>  > +      goto modify_port1;
>  > +   }
>  > +
>  > +   cap = (rblock->capability_mask | props->set_port_cap_mask)
>  > +      & ~props->clr_port_cap_mask;
>  > +
>  > +   hret = hipz_h_modify_port(shca->ipz_hca_handle, port,
>  > +              cap, props->init_type, port_modify_mask);
> 
> Is this thread-safe?  What if two different bits are set at the same
> time from two different threads?  It seems that both calls could get
> the same result from hipz_h_query_port(), and then the second call to
> hipz_h_modify_port() would overwrite the first call.

Yes, you're so right.
 
> You could look at the implementation in mthca to see the locking I
> used there.

I'll do that, thanks for the hint!

Joachim

---
Joachim Fenkes  --  eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH  --  Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220  --  71032 Boeblingen  --  Germany
eMail: fenkes@de.ibm.com  --  Phone: +49 7031 16 1239 
