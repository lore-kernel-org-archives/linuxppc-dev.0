Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 22359DDF32
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 21:16:04 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m54BFjVI266530
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 11:15:45 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m54BFiH01528050
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 12:15:44 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m54BFiYA023972
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 12:15:44 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions with
	callbacks
Date: Wed, 4 Jun 2008 13:15:42 +0200
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806031445.22561.borntraeger@de.ibm.com>
	<200806041013.40692.rusty@rustcorp.com.au>
In-Reply-To: <200806041013.40692.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806041315.42593.borntraeger@de.ibm.com>
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Mittwoch, 4. Juni 2008 schrieb Rusty Russell:
> Two questions.  Is it possible to make the timer backoff a third kind of 
> notifier?

I can try. The timer handling code is sprinkled a bit in hvc_console but it 
should be possible.

> And is it possible to make the dependency static, rather than  
> dynamic, or does someone need two options at runtime?

Not sure. Some drivers pass get the irq number from another component. If the 
number is 0, the console is poll driven, otherwise irq driven.
