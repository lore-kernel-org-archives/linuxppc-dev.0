Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A869467B79
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 09:04:10 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8KN47U0015942
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 19:04:07 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8KN47KU253736
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 17:04:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8KN463K017626
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 17:04:06 -0600
Date: Wed, 20 Sep 2006 18:04:06 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Hang with isync
Message-ID: <20060920230406.GU29167@austin.ibm.com>
References: <d6dada100609181828j1804f4f5ic0d1dd8a225980c@mail.gmail.com>
	<d6dada100609191816q75d1455cobeb1e0bd21dab8a8@mail.gmail.com>
	<1158788111.6002.310.camel@localhost.localdomain>
	<d6dada100609201531oefd71ch8557067bbf77484e@mail.gmail.com>
	<1158791893.6002.327.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1158791893.6002.327.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 21, 2006 at 08:38:13AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2006-09-20 at 15:31 -0700, Manoj Sharma wrote:
> > This is the stack trace.
> > 
> > Registers:
> > GPR00: 00069030 

This is the MSR and it has the user-mode bit set, which is surely wrong. 
This is not how one gets to user space.

00048000 

The MSR had this or'ed into it, which is setting the user-mode bit. 
Surely that's wrong.

--linas
