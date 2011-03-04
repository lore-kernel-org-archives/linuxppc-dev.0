Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D123AB70A7
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2011 09:22:43 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p24M2RQi016514
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2011 17:02:27 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EA58038C803B
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2011 17:22:30 -0500 (EST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p24MMVoZ189462
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2011 17:22:32 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p24MMV7Z000486
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2011 15:22:31 -0700
Subject: Re: [PATCH v4 2/2] add icswx support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
In-Reply-To: <1299270417.8833.897.camel@pasglop>
References: <1299086454.28840.10.camel@flin.austin.ibm.com>
	<1299200560.8833.869.camel@pasglop>
	<1299259794.28840.57.camel@flin.austin.ibm.com>
	<1299270417.8833.897.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Mar 2011 16:22:24 -0600
Message-ID: <1299277344.28840.79.camel@flin.austin.ibm.com>
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

On Sat, 2011-03-05 at 07:26 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2011-03-04 at 11:29 -0600, Tseng-Hui (Frank) Lin wrote:
> > On Fri, 2011-03-04 at 12:02 +1100, Benjamin Herrenschmidt wrote:
> > > On Wed, 2011-03-02 at 11:20 -0600, Tseng-Hui (Frank) Lin wrote:
> > > 
> > > > +#define CPU_FTR_ICSWX                  LONG_ASM_CONST(0x1000000000000000)
> > > 
> > > Do we want a userspace visible feature as well ? Or some other way to
> > > inform userspace that we support icswx ?
> > > 
> > Does a user space program really need to know about icswx? Only
> > coprocessor drivers need to know about icswx. Shouldn't user space
> > programs talk to the coprocessor drivers instead? 
> 
> Well, I don't know how you use icswx on P7+, but on Prism it's
> definitely issued directly by userspace.
> 
OK. You've got a point. I wasn't aware of Prism. HFI device driver is
currently the only icswx user on P7. Could you point me to more
information about how Prism uses icswx from user space?

> > Thought about that. However, multiple threads can call use_cop() at the
> > same time. Without the spinlock being setup in advance, how do I
> > guarantee allocating struct copro_data and modifying the pointer in the
> > mm_context to be atomic?
> 
> You don't need to. You allocate and initialize the structure, and you
> compare & swap the pointer. If somebody beat you, you trash your copy. 
> 
Is atomic_cmpxchg() the one to do the trick?

> > > I'm not sure I totally get the point of having an ifdef here. Can't you
> > > make it unconditional ? Or do you expect distros to turn that off in
> > > which case what's the point ?
> > > 
> > There is only one coprocessor, HFI, using icswx at this moment. The lazy
> > switching makes sense. However, in the future, if more types of
> > coprocessors are added, the lazy switching may actually be a bad idea.
> > This option allows users to turn off the lazy switching.
> 
> No user in real life plays with kernel config options. Care to explain
> why the lazy switching would be a problem ?
> 
The lazy switching checks the shadow variable first before setting ACOP
register. This saves mtspr() only if the new value is the same as
current. If there are several coprocessors on the system, the ACOP
register may have to be changed frequently. In that case, the lazy
switching will not save time. In extreme case when the ACOP register
needs to be changed every time, it actually slows down the execution by
the additional shadow variable checking.

> > Same concern as above. I need something initialized in advance to
> > guarantee allocating memory and updating the pointer are safe when it
> > happens in use_cop().
> 
> No you don't, see above.
> 
> Cheers,
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
