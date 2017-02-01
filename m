Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vD9cf1272zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 04:49:37 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v11HnQfU098125
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 12:49:36 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28bjec600n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 12:49:35 -0500
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 1 Feb 2017 15:49:31 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id ADD2E3520070
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 12:48:55 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v11HnSFY4427876
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 15:49:28 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v11HnS08029921
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 15:49:28 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/pseries: Dynamically increase RMA size
Date: Wed, 01 Feb 2017 15:49:23 -0200
In-Reply-To: <87wpdatqrt.fsf@concordia.ellerman.id.au>
References: <20160805061041.GA31857@us.ibm.com>
 <20160809171131.GA2329@us.ibm.com> <87wpdatqrt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-Id: <2499748.LKgOIUjhgo@morokweng>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Am Mittwoch, 1. Februar 2017, 16:37:58 BRST schrieb Michael Ellerman:
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> > Paul Clarke [pc@us.ibm.com] wrote:
> > ---
> >=20
> > From f9e9e8460206bc3fa7eaa741b9a2bde22870b9e0 Mon Sep 17 00:00:00 2001
>=20
> I know it's been a while but I think it would still be good to get this
> in a shape that we can merge it.

Sorry if this has been tried and didn't work or if I'm missing something=20
obvious:

Instead of this method of trying a small RMA size and rebooting to try a=20
bigger size, could the "min RMA percentage of total RAM" field of the=20
ibm_architecture_vec be used?

LoPAPR says that "The Initial size of the RMA is set to the greater of the=
=20
values indicated by bytes 24-27 [min RMA] or 32 [min RMA percentage of tota=
l=20
RAM] of option vector number 2 =E2=80=9COpen Firmware=E2=80=9D or minimum R=
MA size supported=20
by the platform and capped by the maximum memory defined for the partition =
and=20
the maximum size of the RMA supported by the platform. The respective selec=
ted=20
values are reported in the length of the first memory property."

My understanding is that these patches are intended for big guests with man=
y=20
processors, but the RMA size isn't changed to 512MB outright because of=20
worries that it could affect smaller guests. Since guests with many process=
ors=20
tend to have more RAM as well, specifying a min RMA size of 256MB and a min=
=20
RMA percentage of, say, 10% or 20% could make the host automatically alloca=
te=20
an adequate RMA size in the first boot.

=2D-=20
Thiago Jung Bauermann
IBM Linux Technology Center
