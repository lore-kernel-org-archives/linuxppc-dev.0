Return-Path: <mostrows@watson.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C79D3DE035
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 01:12:10 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l18EC34t008690
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 09:12:03 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l18EC394542576
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 07:12:03 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l18EC2ZQ010186
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 07:12:03 -0700
Subject: Re: Kbuild change breaks the ppc64 build
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070208.040003.112623191.davem@davemloft.net>
References: <17867.1342.763881.188430@cargo.ozlabs.ibm.com>
	<20070208.040003.112623191.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 08:12:00 -0600
Message-Id: <1170943920.15584.234.camel@kdsk1.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, olecom@flower.upol.cz,
	torvalds@linux-foundation.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Isn't the extra space there because you've included it in the definition
of "test"?  The attempt at introducing indentation introduces the extra
space character.  Defining test without the internal indentation should
produce the results you are looking for.


-- 
Michal Ostrowski <mostrows@watson.ibm.com>


On Thu, 2007-02-08 at 04:00 -0800, David Miller wrote:

> For some reason $(call ...) invocations add spaces.  I tried
> another test case:
> 
> define test
>  $(shell echo -n)
> endef
> 
> VAR:=$(call test)
> 
> all:
> 	@echo "\'$(VAR)\'"
> 
> And this always prints:
> 
> ' TEST'
> 
> even with GNU Make version 3.81
> 
> If I put a $(strip ...) around the define, the space is
> still there.  If I put the $(strip ...) around VAR's
> $(call), the space goes away.
