Return-Path: <fenkes@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8C3F7DDF04
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 18:56:12 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l4A8u7cO072132
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 08:56:07 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l4A8u7Go3334330
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 10:56:07 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l4A8tuYR006204
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 10:55:57 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 1/6] IB/ehca: Serialize hypervisor calls in
	ehca_register_mr()
Date: Thu, 10 May 2007 10:55:46 +0200
References: <200705091347.57470.fenkes@de.ibm.com>
In-Reply-To: <200705091347.57470.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705101055.46433.fenkes@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 09 May 2007 13:47, Joachim Fenkes wrote:

> --- a/drivers/infiniband/hw/ehca/hcp_if.c
> +++ b/drivers/infiniband/hw/ehca/hcp_if.c
> @@ -154,7 +154,9 @@ static long ehca_plpar_hcall9(unsigned l
>  			      unsigned long arg9)
>  {
>  	long ret;
> -	int i, sleep_msecs;
> +	int i, sleep_msecs, lock_is_set =3D 0;
> +	unsigned long flags;
> +
> =20
>  	ehca_gen_dbg("opcode=3D%lx arg1=3D%lx arg2=3D%lx arg3=3D%lx arg4=3D%lx "
>  		     "arg5=3D%lx arg6=3D%lx arg7=3D%lx arg8=3D%lx arg9=3D%lx",
> @@ -162,10 +164,18 @@ static long ehca_plpar_hcall9(unsigned l

Whoops, that's one too many empty line...
Roland, when you apply this patch, could you apply the following patch on t=
op:

=2D-- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -157,7 +157,6 @@ static long ehca_plpar_hcall9(unsigned l
        int i, sleep_msecs, lock_is_set =3D 0;
        unsigned long flags;

=2D
        ehca_gen_dbg("opcode=3D%lx arg1=3D%lx arg2=3D%lx arg3=3D%lx arg4=3D=
%lx "
                     "arg5=3D%lx arg6=3D%lx arg7=3D%lx arg8=3D%lx arg9=3D%l=
x",
                     opcode, arg1, arg2, arg3, arg4, arg5, arg6, arg7,


Thanks!
  Joachim

=2D-=20
Joachim Fenkes =A0-- =A0eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH =A0-- =A0Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220 =A0-- =A071032 Boeblingen =A0-- =A0Germany
eMail: fenkes@de.ibm.com =A0-- =A0Phone: +49 7031 16 1239
