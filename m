Return-Path: <srs0=ud8r=3h=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvHxG1bBCzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 08:35:46 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vvHxG0kQmz8sk1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 08:35:46 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vvHxF4FKNz9s5g
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 08:35:45 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2ULXghg118221
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2017 17:35:38 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29h2j26c81-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2017 17:35:38 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 15:35:37 -0600
Date: Thu, 30 Mar 2017 14:35:32 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, oohall@gmail.com,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 01/10] VAS: Define macros, register fields and
 structures
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490329340.28113.57.camel@neuling.org>
 <20170324213009.GD8330@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170324213009.GD8330@us.ibm.com>
Message-Id: <20170330213532.GA13103@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
> Michael Neuling [mikey@neuling.org] wrote:
> > On Thu, 2017-03-16 at 20:33 -0700, Sukadev Bhattiprolu wrote:
> > > Define macros for the VAS hardware registers and bit-fields as well
> > > as couple of data structures needed by the VAS driver.
> > >=20
> > > > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > > ---
> > > Changelog[v3]
> > > 	- Rename winctx->pid to winctx->pidr to reflect that its a value
> > > 	=A0=A0from the PID register (SPRN_PID), not the linux process id.
> > > 	- Make it easier to split header into kernel/user parts
> > > 	- To keep user interface simple, use macros rather than enum for
> > > 	=A0=A0the threshold-control modes.
> > > 	- Add a pid field to struct vas_window - needed for user space
> > > 	=A0=A0send windows.
> > >=20
> > > Changelog[v2]
> > > 	- Add an overview of VAS in vas-internal.h
> > > 	- Get window context parameters from device tree and drop
> > > 	=A0=A0unnecessary macros.
> > > ---
> > > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0|=A0=A0=A06 +
> > > =A0arch/powerpc/include/asm/vas.h=A0=A0|=A0=A043 +++++
> > > =A0drivers/misc/vas/vas-internal.h | 392 ++++++++++++++++++++++++++++=
++++++++++++
> >=20
> > This is going to have to go through gregkh/lkml if it's drivers/misc.  =
you'll at
> > least need gregkh's ack/ok before mpe will take them (which is what we =
did for
> > CAPI).
> >=20
> > We might want to keep this in arch/powerpc but I'm not sure.
> >=20
>=20
> We will have device nodes accessible to user space so put it here and can
> copy Gregkh next time. But let me know if we should move to arch/powerpc.
>=20

Thinking about this some more, the VAS module itself does not provide
the device nodes. Rather, the drivers that use VAS, like NX-GZIP, will
provide them. So, I am moving the VAS code into arch/powerpc/kernel.

Please let me know of any comments/concerns.

Thanks
Suka
