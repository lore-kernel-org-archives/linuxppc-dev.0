Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6DA45B729F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 10:46:33 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3176DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 10:46:32 +1000 (EST)
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Frysinger <vapier.adi@gmail.com>
In-Reply-To: <8bd0f97a0906181655jd68835fg10fe0783b6a6068d@mail.gmail.com>
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
	<8bd0f97a0906181655jd68835fg10fe0783b6a6068d@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 19 Jun 2009 10:46:14 +1000
Message-Id: <1245372374.16880.0.camel@pasglop>
Mime-Version: 1.0
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-06-18 at 19:55 -0400, Mike Frysinger wrote:
> On Sat, Jun 13, 2009 at 03:10, Paul Mackerras wrote:
> > +typedef struct {
> > +       long long counter;
> > +} atomic64_t;
> 
> lack of volatile seems odd compared to:
> include/linux/types.h:
> typedef struct {
>     volatile int counter;
> } atomic_t;

Since the counter is only accessed within a spinlock, the volatile
wouldn't be very useful here.

Cheers,
Ben.
