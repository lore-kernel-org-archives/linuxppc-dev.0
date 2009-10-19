Return-Path: <bergner@vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4D47B7B90
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Oct 2009 11:57:34 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9J0rBd9018519
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2009 18:53:11 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id n9J0vR1m138634
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2009 18:57:27 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9J0vQsn029932
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2009 18:57:26 -0600
Subject: Re: Mixing hard and soft floating point?
From: Peter Bergner <bergner@vnet.ibm.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20091017193454.7978FF15432@gemini.denx.de>
References: <OFC920E57F.DFABC29F-ONC1257652.00421E11-C1257652.0043478A@transmode.se>
	<20091017181224.97FFBF15432@gemini.denx.de>
	<OFEC00B9FB.B03AA854-ONC1257652.00644350-C1257652.00651551@transmode.se>
	<20091017193454.7978FF15432@gemini.denx.de>
Content-Type: text/plain
Date: Sun, 18 Oct 2009 19:57:24 -0500
Message-Id: <1255913844.4930.4.camel@otta>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-10-17 at 21:34 +0200, Wolfgang Denk wrote:
> Dear Joakim Tjernlund,
> > OK, but then you don't mix some libs/apps with soft and other
> > apps/libs with hard FP?
> 
> No, we never tried that. Sounds scary to me.

And dangerous.  Hard-float and soft-float are ABI incompatible, so you
cannot mix and match obj files and libs compiled with those two options.
They all have to be hard-float or they all have to be soft-float.
Think about a function compiled with hard-float calling a soft-float
libm routine.  The hard-float routine will pass its args in via FP
regs and the soft-float lib routine will be looking for them in the
integer registers.

Peter
