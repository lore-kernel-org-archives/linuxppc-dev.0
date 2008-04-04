Return-Path: <hollisb@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D5E5DE19F
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 02:56:18 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m34FuEPf026555
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 11:56:14 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m34FuEJG299378
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 11:56:14 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m34FuEhM023992
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 11:56:14 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: jyoung5@us.ibm.com
Subject: Re: [kvm-ppc-devel] [PATCH] [v2] Add idle wait support for
	=?iso-8859-1?q?44x=09platforms?=
Date: Fri, 4 Apr 2008 10:56:13 -0500
References: <afed3e5de82ab6c0ac8d.1207292794@thinkpadL>
	<835D8B13-CF90-4013-A172-8243BF93DE52@pobox.com>
	<1207323761.6634.6.camel@thinkpadL>
In-Reply-To: <1207323761.6634.6.camel@thinkpadL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804041056.14082.hollisb@us.ibm.com>
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	Jimi Xenidis <jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 04 April 2008 10:42:41 Jerone Young wrote:
> > > +{
> > > +=A0=A0=A0unsigned long msr_save;
> > > +
> > > +=A0=A0=A0msr_save =3D mfmsr();
> > > +=A0=A0=A0/* set wait state MSR */
> > > +=A0=A0=A0mtmsr(msr_save|MSR_WE|MSR_EE|MSR_CE);
> >
> > Did we decide to drop MSR_DE?
>
> Hollis argued it down on an earlier email on kvm-ppc-devel. Though I did
> have it in one of the earlier patches.

I didn't comment either way. However, looking at the 440 user manual now, i=
t=20
seems clear that DE should be set to allow JTAG debugger events.

=2D-=20
Hollis Blanchard
IBM Linux Technology Center
