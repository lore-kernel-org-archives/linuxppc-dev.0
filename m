Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7376FDDF25
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 09:29:51 +1000 (EST)
Subject: Re: function calls from identify_cpu()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <481B7CB4.90103@hypersurf.com>
References: <481B7CB4.90103@hypersurf.com>
Content-Type: text/plain
Date: Sat, 03 May 2008 09:29:40 +1000
Message-Id: <1209770980.26383.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-05-02 at 13:42 -0700, Kevin Diggs wrote:
> I added:
> 
> int __init iDoNothingUseful(struct cpu_spec *s,struct cpu_spec *t)
> {
>          return s-t;
> }
> 
> right before the definition of identify_cpu() in cputable.c and:
> 
> //                      (void) (*PTRRELOC(&iDoNothingUseful))(s,t);
>                          (void) iDoNothingUseful(s,t);
> 
> right before the return s; in the match block and it will not boot? Can 
> someone please explain what might be going on?

Why are you trying to muck around with that code in the first
place ? :-)

What are you trying to achieve ?

Cheers,
Ben.
