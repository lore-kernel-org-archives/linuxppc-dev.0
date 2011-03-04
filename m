Return-Path: <benh@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4F54B70A4
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2011 07:27:00 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id p24KLqe1008489
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Mar 2011 07:21:52 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p24KQxGh2351312
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Mar 2011 07:26:59 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p24KQwl2016931
	for <linuxppc-dev@ozlabs.org>; Sat, 5 Mar 2011 07:26:58 +1100
Subject: Re: [PATCH v4 2/2] add icswx support
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
In-Reply-To: <1299259794.28840.57.camel@flin.austin.ibm.com>
References: <1299086454.28840.10.camel@flin.austin.ibm.com>
	<1299200560.8833.869.camel@pasglop>
	<1299259794.28840.57.camel@flin.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 05 Mar 2011 07:26:57 +1100
Message-ID: <1299270417.8833.897.camel@pasglop>
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

On Fri, 2011-03-04 at 11:29 -0600, Tseng-Hui (Frank) Lin wrote:
> On Fri, 2011-03-04 at 12:02 +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2011-03-02 at 11:20 -0600, Tseng-Hui (Frank) Lin wrote:
> > 
> > > +#define CPU_FTR_ICSWX                  LONG_ASM_CONST(0x1000000000000000)
> > 
> > Do we want a userspace visible feature as well ? Or some other way to
> > inform userspace that we support icswx ?
> > 
> Does a user space program really need to know about icswx? Only
> coprocessor drivers need to know about icswx. Shouldn't user space
> programs talk to the coprocessor drivers instead? 

Well, I don't know how you use icswx on P7+, but on Prism it's
definitely issued directly by userspace.

> Thought about that. However, multiple threads can call use_cop() at the
> same time. Without the spinlock being setup in advance, how do I
> guarantee allocating struct copro_data and modifying the pointer in the
> mm_context to be atomic?

You don't need to. You allocate and initialize the structure, and you
compare & swap the pointer. If somebody beat you, you trash your copy. 

> > I'm not sure I totally get the point of having an ifdef here. Can't you
> > make it unconditional ? Or do you expect distros to turn that off in
> > which case what's the point ?
> > 
> There is only one coprocessor, HFI, using icswx at this moment. The lazy
> switching makes sense. However, in the future, if more types of
> coprocessors are added, the lazy switching may actually be a bad idea.
> This option allows users to turn off the lazy switching.

No user in real life plays with kernel config options. Care to explain
why the lazy switching would be a problem ?

> Same concern as above. I need something initialized in advance to
> guarantee allocating memory and updating the pointer are safe when it
> happens in use_cop().

No you don't, see above.

Cheers,
Ben.
