Return-Path: <benh@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9C90100867
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2011 09:40:44 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p24MZBIL024695
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Mar 2011 09:35:11 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p24Meg6p2203790
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Mar 2011 09:40:42 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p24MegAo013706
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Mar 2011 09:40:42 +1100
Subject: Re: [PATCH v4 2/2] add icswx support
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
In-Reply-To: <1299277344.28840.79.camel@flin.austin.ibm.com>
References: <1299086454.28840.10.camel@flin.austin.ibm.com>
	<1299200560.8833.869.camel@pasglop>
	<1299259794.28840.57.camel@flin.austin.ibm.com>
	<1299270417.8833.897.camel@pasglop>
	<1299277344.28840.79.camel@flin.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 05 Mar 2011 09:40:41 +1100
Message-ID: <1299278441.8833.915.camel@pasglop>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-03-04 at 16:22 -0600, Tseng-Hui (Frank) Lin wrote:

> > Well, I don't know how you use icswx on P7+, but on Prism it's
> > definitely issued directly by userspace.
> > 
> OK. You've got a point. I wasn't aware of Prism. HFI device driver is
> currently the only icswx user on P7. Could you point me to more
> information about how Prism uses icswx from user space?

Let's ignore that for now, there's a whole infrastructure for it and it
hasn't been published yet, maybe later this year... We can look at
exposing the feature to userspace then.

> > You don't need to. You allocate and initialize the structure, and you
> > compare & swap the pointer. If somebody beat you, you trash your copy. 
> > 
> Is atomic_cmpxchg() the one to do the trick?

No, just cmpxchg()

> The lazy switching checks the shadow variable first before setting ACOP
> register. This saves mtspr() only if the new value is the same as
> current. If there are several coprocessors on the system, the ACOP
> register may have to be changed frequently. In that case, the lazy
> switching will not save time. In extreme case when the ACOP register
> needs to be changed every time, it actually slows down the execution by
> the additional shadow variable checking.

By how much ? Is it even measurable ?

Cheers,
Ben.
