Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F3DE567BAB
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 06:31:18 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB4JVFnI002219
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Dec 2006 14:31:15 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB4JVF5q461520
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Dec 2006 12:31:15 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB4JVFs5030757
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Dec 2006 12:31:15 -0700
Date: Mon, 4 Dec 2006 13:31:14 -0600
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
Message-ID: <20061204193114.GD4798@austin.ibm.com>
References: <45707469.9060604@austin.ibm.com>
	<1165247338.18104.21.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1165247338.18104.21.camel@localhost>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 04, 2006 at 09:48:58AM -0600, Will Schmidt wrote:
> 
> You could eliminate the temp variable rtas_poweron_auto_token, and
> rewrite as something like:
> 
>                if (rtas_token("ibm,power-off-ups") == RTAS_UNKNOWN_SERVICE) {
>                        rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
>                        printk(KERN_EMERG "Power-off called instead %d\n", rc );

Heh. I encouraged Manish to create the temp variable in an earlier round
of reviews. My personal taste is that nested subroutine calls are both
ugly and hard to debug, e.g. if rtas_token() for some reason returns
unexpected values, etc.

--linas
