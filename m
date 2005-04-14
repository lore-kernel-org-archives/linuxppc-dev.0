Return-Path: <rscop@matrix.com.br>
Received: from hermes.digitel.com.br (hermes.digitel.com.br [200.198.105.36])
	by ozlabs.org (Postfix) with ESMTP id DC9B767B68
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 09:37:14 +1000 (EST)
Received: from [10.10.10.4] by hermes.digitel.com.br (GMS
	9.01.3158/NU1492.00.9f6ce814) with ESMTP id pnhbmbaa for
	linuxppc-embedded@ozlabs.org; Thu, 14 Apr 2005 20:27:51 -0200
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <rscop@matrix.com.br>
To: Marco Schramel <Schramel.Linux@go.bartec.de>,
	"PPC_LINUX" <linuxppc-embedded@ozlabs.org>
Date: Thu, 14 Apr 2005 20:24:41 -0300
References: <200504140926.01775.Schramel.Linux@go.bartec.de>
	<a06218f5ec69af94cf7d5f7616eed028@embeddededge.com>
	<200504141454.03704.Schramel.Linux@go.bartec.de>
In-Reply-To: <200504141454.03704.Schramel.Linux@go.bartec.de>
MIME-Version: 1.0
Message-Id: <200504142024.41126.rscop@matrix.com.br>
Subject: Re: CPM uart
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Marco,

On Thursday 14 April 2005 09:54, Marco Schramel wrote:
> Hi Dan,
>
> thanks for your answer.
>
> > > During booting kernel hangs on initializing ttyS2 forever.
> >
> > That is the console port, so take a look at the code for its
> > initialization for something affected by this configuration.
> > What kernel are you using?  There have been lots of
> > updates in recent versions.
>
> I use kernel version 2.4.25 of denx and the uart version is
                       ^^^^^^^^^^^^^^

Perusing that code, I can see that the console routines assume that there=
 are=20
_no_ SMC ports initialized before the SCC ports in rs_table. This should =
be=20
fixed before attempting to run your system again.

I suggest you to seek all smc_scc_num references inside both the console=20
routines and the #ifdef SCC_CONSOLE ... #endif code snippets. They should=
 be=20
subtracted by SCC_NUM_BASE whenever they're used to access SCC-related st=
uff,=20
AFAIK.

HTH,

Ricardo Scop.

        \|/
    ___ -*-
   (@ @)/|\
  /  V  \|  R SCOP Consult.
 /(     )\  Linux-based communications
--^^---^^+------------------------------
rscop@matrix.com.br
+55 51 999-36-777
Porto Alegre, RS - BRazil
