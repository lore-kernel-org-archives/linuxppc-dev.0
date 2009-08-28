Return-Path: <FENKES@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1855DB7BFB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 22:59:16 +1000 (EST)
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.17.166])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BB4FDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 22:59:11 +1000 (EST)
Received: from d12nrmr1507.megacenter.de.ibm.com
	(d12nrmr1507.megacenter.de.ibm.com [9.149.167.1])
	by mtagate6.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7SCx1r3008753
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 12:59:01 GMT
Received: from d12av06.megacenter.de.ibm.com (d12av06.megacenter.de.ibm.com
	[9.149.165.230])
	by d12nrmr1507.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n7SCwq3g3596290
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 14:59:00 +0200
Received: from d12av06.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av06.megacenter.de.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with
	ESMTP id n7SCwqr7027817
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 14:58:52 +0200
In-Reply-To: <f0e08f230908270631j3e159f3fgb0034eb41acdac7b@mail.gmail.com>
References: <200908261337.56128.fenkes@de.ibm.com>	
	<f0e08f230908260815g70de3002pfd0b34f1b17abd6@mail.gmail.com>
	<OFF2257478.FF0FEABE-ONC125761F.00344884-C125761F.00358310@de.ibm.com>
	<f0e08f230908270631j3e159f3fgb0034eb41acdac7b@mail.gmail.com>
To: Hal Rosenstock <hal.rosenstock@gmail.com>
MIME-Version: 1.0
Subject: Re: [ewg] [PATCH] IB/ehca: Construct MAD redirect replies from
	request MAD
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFA25F14CC.CE7042E9-ONC1257620.00453C46-C1257620.00474D70@de.ibm.com>
Date: Fri, 28 Aug 2009 14:58:49 +0200
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

Hal Rosenstock <hal.rosenstock@gmail.com> wrote on 27.08.2009 15:31:40:

> I don't think it should be hard coded. IMO it would be better to default 
to 18
> and somehow able to be adjusted (via a (dynamic) module parameter ?).

I don't see how making this a parameter would benefit any end user, while 
on the other hand it clutters up our parameter list.

Changing RespTimeValue won't influence the IB performance or user-visible 
behavior of our driver in any way, and in fact, all RespTimeValue says is 
"Please use a timeout of one second for all future MADs you send me", only 
there won't be any more MADs in the future because we just redirected the 
client to someone else. So, the RespTimeValue field is a don't care in the 
redirection scenario. Setting it to an arbitrary, but legal value isn't 
much more than a concession towards any broken clients that may be out 
there.

Given that you seem to like the rest of the code and Jason hasn't spoken 
up yet, I think we can have Roland merge this patch. Roland, what do you 
think?

Regards,
  Joachim
