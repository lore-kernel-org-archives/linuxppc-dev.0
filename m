Return-Path: <kumar.gala@freescale.com>
Received: from motgate7.mot.com (motgate7.mot.com [129.188.136.7])
	by ozlabs.org (Postfix) with ESMTP id 96C2A2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Nov 2004 17:15:29 +1100 (EST)
In-Reply-To: <20041109060109.GA26831@gate.ebshome.net>
References: <20041109060109.GA26831@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <BB7A072F-3216-11D9-89A0-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 9 Nov 2004 00:15:20 -0600
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: Kumar Gala <galak@somerset.sps.mot.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Added MPC8555/8541 security block infrastructure
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > diff -Nru a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
> > --- a/include/asm-ppc/mpc85xx.h=A0=A0=A0=A0=A0=A0 2004-11-08 =
21:33:21 -06:00
>  > +++ b/include/asm-ppc/mpc85xx.h=A0=A0=A0=A0=A0=A0 2004-11-08 =
21:33:21 -06:00
>  > @@ -81,6 +81,7 @@
>  >=A0 #define MPC85xx_IRQ_DUART=A0=A0=A0 (26 + =
MPC85xx_OPENPIC_IRQ_OFFSET)
> >=A0 #define MPC85xx_IRQ_IIC1=A0=A0=A0=A0 (27 + =
MPC85xx_OPENPIC_IRQ_OFFSET)
> >=A0 #define MPC85xx_IRQ_PERFMON=A0 (28 + MPC85xx_OPENPIC_IRQ_OFFSET)
> > +#define MPC85xx_IRQ_SEC2=A0=A0=A0=A0 (29 + =
MPC85xx_OPENPIC_IRQ_OFFSET)
> >=A0 #define MPC85xx_IRQ_CPM=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 (30 =
+=20
> MPC85xx_OPENPIC_IRQ_OFFSET)
> >
> >=A0 /* The 12 external interrupt lines */
>  > @@ -120,6 +121,8 @@
>  >=A0 #define MPC85xx_PCI2_SIZE=A0=A0=A0 (0x01000)
>  >=A0 #define MPC85xx_PERFMON_OFFSET=A0=A0=A0=A0=A0=A0 (0xe1000)
>  >=A0 #define MPC85xx_PERFMON_SIZE (0x01000)
>  > +#define MPC85xx_SEC2_OFFSET=A0 (0x30000)
>  > +#define MPC85xx_SEC2_SIZE=A0=A0=A0 (0x10000)
>  >=A0 #define MPC85xx_UART0_OFFSET (0x04500)
>  >=A0 #define MPC85xx_UART0_SIZE=A0=A0 (0x00100)
>  >=A0 #define MPC85xx_UART1_OFFSET (0x04600)
>  > diff -Nru a/include/asm-ppc/ocp_ids.h b/include/asm-ppc/ocp_ids.h
>  > --- a/include/asm-ppc/ocp_ids.h=A0=A0=A0=A0=A0=A0 2004-11-08 =
21:33:21 -06:00
>  > +++ b/include/asm-ppc/ocp_ids.h=A0=A0=A0=A0=A0=A0 2004-11-08 =
21:33:21 -06:00
>  > @@ -61,6 +61,7 @@
>  >=A0 #define OCP_FUNC_PERFMON=A0=A0=A0=A0 0x00D2=A0 /* Performance =
Monitor */
>  >=A0 #define OCP_FUNC_RGMII=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
0x00D3
>  >=A0 #define OCP_FUNC_TAH =A0=A0=A0=A0=A0=A0=A0 0x00D4
>  > +#define OCP_FUNC_SEC2=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
0x00D5=A0 /* Crypto/Security=20
> 2.0 */
>  >
> >=A0 /* Network 0x0200 - 0x02FF */
>  >=A0 #define OCP_FUNC_EMAC=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
0x0200
>
> I wonder what is the purpose of adding these defines to the header =
file
> and then using them only in one .c file. Are they public interface?
>
> I guess not, and IMHO scattering such stuff among doesn't help
> readability and using new C structure initializers shows exactly what
> each number means anyway.

Well, the SEC2 defines are currently only used in this file at this=20
time.  However, I expect in the future other mpc85??.c files will use=20
these defines.

> For 4xx, for example, we moved all such stuff directly to
>  corresponding ibm4XXX files.

The memory offsets and sizes could most likely move there.

- kumar
