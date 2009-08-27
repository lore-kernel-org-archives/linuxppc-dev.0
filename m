Return-Path: <FENKES@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 44C8EB7B71
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 19:44:56 +1000 (EST)
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.17.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47E57DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 19:44:53 +1000 (EST)
Received: from d12nrmr1707.megacenter.de.ibm.com
	(d12nrmr1707.megacenter.de.ibm.com [9.149.167.81])
	by mtagate3.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7R9iW5W019525
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 09:44:32 GMT
Received: from d12av06.megacenter.de.ibm.com (d12av06.megacenter.de.ibm.com
	[9.149.165.230])
	by d12nrmr1707.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n7R9iWfs2711720
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 11:44:32 +0200
Received: from d12av06.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av06.megacenter.de.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with
	ESMTP id n7R9iVsF027270
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 11:44:32 +0200
In-Reply-To: <f0e08f230908260815g70de3002pfd0b34f1b17abd6@mail.gmail.com>
References: <200908261337.56128.fenkes@de.ibm.com>
	<f0e08f230908260815g70de3002pfd0b34f1b17abd6@mail.gmail.com>
To: Hal Rosenstock <hal.rosenstock@gmail.com>
MIME-Version: 1.0
Subject: Re: [ewg] [PATCH] IB/ehca: Construct MAD redirect replies from
	request MAD
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFF2257478.FF0FEABE-ONC125761F.00344884-C125761F.00358310@de.ibm.com>
Date: Thu, 27 Aug 2009 11:44:30 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: Hal Rosenstock <hnrose@comcast.net>, OF-EWG <ewg@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hal Rosenstock <hal.rosenstock@gmail.com> wrote on 26.08.2009 17:15:03:

> Thanks for doing this. It looks sane to me. The only issue I recall that 

> appears to be remaining is a better setting of 
ClassPortInfo:RespTimeValue 
> rather than hardcoding. Perhaps using the value from PortInfo is the way 
to go
> (ideally it would be that value from the port to which the the requester 
is 
> being redirected to but that might not be so easy to get from this port.

I don't think that effort will be necessary or even legal. The requestor 
will react to the redirection with another Get(ClassPortInfo) to the 
redirection target, which will reply with its own RespTimeValue, so our 
driver should speak for itself. Since we don't know when our MAD 
processing and sending of the response is going to be scheduled (we're not 
running on real-time constraints here), we play it safe and return 18, 
which amounts to roughly a second. 

Make sense?

Regards
  Joachim
