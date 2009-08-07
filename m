Return-Path: <ljaenicke@innominate.com>
Received: from home.innominate.com (host2.bln.innominate.com [77.245.32.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DA2A2B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 20:57:02 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by home.innominate.com (Postfix) with ESMTP id A49CD232BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:56:54 +0200 (CEST)
Received: from home.innominate.com ([127.0.0.1])
	by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id YR4JEkEFXQUp for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:56:54 +0200 (CEST)
Received: from lutz.bln.innominate.local (lutz.bln.innominate.local
	[10.1.0.160])
	by home.innominate.com (Postfix) with ESMTP id 8077323143
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:56:54 +0200 (CEST)
Date: Fri, 7 Aug 2009 12:56:54 +0200
From: Lutz Jaenicke <ljaenicke@innominate.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: MPC8313 performance evaluation
Message-ID: <20090807105654.GA20678@lutz.bln.innominate.local>
References: <20090806180035.GA19088@lutz.bln.innominate.local>
	<D7CCA83BB0796C49BC0BB53B6AB1208956D03F@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208956D03F@zch01exm21.fsl.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2009 at 04:08:50PM +0800, Liu Dave-R63238 wrote:
> 
> > Some discussion with the the freescale rep. lead to the CSB frequency
> > of the 8313 (166MHz) being significantly lower than that of the 8343.
> > Is the CSB the critical point here?
> 
> I believe the CSB is critical point here. They are right.

I have performed some additional measurements with other multiplier/divider
settings 

Previous values with CSB=166MHz
> >> With the MPC8313 I get a significantly lower value:
> >> MPC8313@250MHz          12500fps
> >> MPC8313@333MHz          14500fps
> >> MPC8313@416MHz          15500fps      (333MHz type, overclocked)

New value with CSB=200MHz (overclocked)
     MPC8313@400MHz          17500fps

This indeed indicates that the CSB is the limiting factor.
Until a few days ago I have not even been aware of the CSB being a
performance critical component. All of the nice powerpoints explaining
the processors and used for comparing different families shown by the
Freescale Rep include the core frequencies and the DRAM interface
and frequency but do not even mention the CSB...

> > Note: the IXP42x uses an internal bus speed of 133MHz and operates
> > at frame rates similar to the 8343...
> 
> It is possible, IXP42x has the differenet SoC architecture with 83xx.

That is very true indeed, then XScale (ARM) based IXP42x does have
a completely different implementation.

Best regards,
	Lutz
-- 
Dr.-Ing. Lutz Jänicke
CTO
Innominate Security Technologies AG  /protecting industrial networks/
tel: +49.30.921028-200
fax: +49.30.921028-020
Rudower Chaussee 13
D-12489 Berlin, Germany
www.innominate.com

Register Court: AG Charlottenburg, HR B 81603
Management Board: Dirk Seewald
Chairman of the Supervisory Board: Volker Bibelhausen
