Return-Path: <miltonm@bga.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9B47DB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 18:04:17 +1000 (EST)
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 98C96DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 18:04:16 +1000 (EST)
From: Milton Miller <miltonm@bga.com>
To: M. Mohan Kumar <mohan@in.ibm.com>
Subject: Re: [PATCH] Do not inline putprops function
In-Reply-To: <20090805164938.GA2970@in.ibm.com>
Date: Mon, 10 Aug 2009 02:37:49 -0500
Message-ID: <1249889869_10618@mercury.realtime.net>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu Aug 6 at about 02:49:38 EST in 2009, M. Mohan Kumar  wrote:
>
> When I align the dtstruct variable to 8 bytes, I am able to invoke kdump.
> 
> When the line
> 	static unsigned dtstruct[TREEWORDS], *dt;
> changed to 
> 	static unsigned dtstruct[TREEWORDS] __attribute__ ((aligned (8))), *dt;
> 
> kexec-tool works.


Doh.  that is the correct fix.

kexec is creating a version 3 device tree, to be backwards compatible
as far as possible.  (Well, that and it was written before version 3
existed).  This version of the struct has 8-byte alignment for properties
whose value is 8 or more bytes.  As the code directly checks the pointer
when deciding to add the alignment word, the struct memory must start on
an 8 byte boundary.

Mohan, please prepare a patch with the above text in the changelog 
and send it to Simon.

thanks.
milton
