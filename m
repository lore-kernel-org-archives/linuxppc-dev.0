Return-Path: <johnrose@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2961267A70
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 02:18:37 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k51GIYht027551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2006 12:18:34 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k51G6F7i139370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2006 10:18:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k51FuXjj028701
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2006 09:56:34 -0600
Subject: Re: [PATCH] use msleep() for RTAS delays
From: John Rose <johnrose@austin.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1149139866.28307.32.camel@localhost.localdomain>
References: <1149103929.2524.8.camel@sinatra.austin.ibm.com>
	<1149139866.28307.32.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1149177349.9812.16.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Thu, 01 Jun 2006 10:55:49 -0500
Cc: External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben-

> What about putting this whole thing in a helper ? There is a few more
> things I've seen floating around implementing the exact same logic (for
> example Jake's MSI patches).

I don't mind writing this up.  The previous patch fixes a reported bug
with minimal reorg.  If possible, I'd like to restructure on top of
that.

> Or something inside rtas_call
> 
> rtas_call_waitbusy(...);

Certain RTAS calls expect identical inputs between successive calls,
while others (ibm,change-msi) expect modified "sequence" inputs, etc. 
Given this inconsistency, we probably can't handle busy rcs inside
rtas_call().

Thanks-
John
