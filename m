Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CA01CB70EA
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2011 10:07:37 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p24MsmPR014393
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2011 15:54:48 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p24N7YdP101036
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2011 16:07:34 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p24N7YwV001267
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Mar 2011 16:07:34 -0700
Subject: Re: [PATCH v4 2/2] add icswx support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
In-Reply-To: <1299278441.8833.915.camel@pasglop>
References: <1299086454.28840.10.camel@flin.austin.ibm.com>
	<1299200560.8833.869.camel@pasglop>
	<1299259794.28840.57.camel@flin.austin.ibm.com>
	<1299270417.8833.897.camel@pasglop>
	<1299277344.28840.79.camel@flin.austin.ibm.com>
	<1299278441.8833.915.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Mar 2011 17:07:33 -0600
Message-ID: <1299280053.28840.96.camel@flin.austin.ibm.com>
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

On Sat, 2011-03-05 at 09:40 +1100, Benjamin Herrenschmidt wrote:

> > The lazy switching checks the shadow variable first before setting ACOP
> > register. This saves mtspr() only if the new value is the same as
> > current. If there are several coprocessors on the system, the ACOP
> > register may have to be changed frequently. In that case, the lazy
> > switching will not save time. In extreme case when the ACOP register
> > needs to be changed every time, it actually slows down the execution by
> > the additional shadow variable checking.
> 
> By how much ? Is it even measurable ?
> 
I don't have any measurable numbers. That's why I made it an option in
case people wants to disable it. I do agree that the kernel has so many
options that we should refrain from adding more. If the chance that the
lazy switching slows down the execution is really low, we should just
take out the option. Is there any one has an idea how much the numbers
are?

> Cheers,
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
