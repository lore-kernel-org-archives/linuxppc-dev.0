Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9715ADDDFB
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 10:31:51 +1000 (EST)
Subject: Re: [PATCH v4] ibm_newemac: Parameterize EMAC Multicast Match Handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <1215303343-26410-1-git-send-email-gerickson@nuovations.com>
References: <1215249512-1974-1-git-send-email-gerickson@nuovations.com>
	<1215303343-26410-1-git-send-email-gerickson@nuovations.com>
Content-Type: text/plain
Date: Sun, 06 Jul 2008 10:31:39 +1000
Message-Id: <1215304299.8970.24.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-07-05 at 17:15 -0700, Grant Erickson wrote:
> +       union {
> +               /* Registers unique to EMAC4 implementations */
> +               struct {
> +                       u32 iaht1;      /* Reset, R     */
> +                       u32 iaht2;      /* Reset, R     */
> +                       u32 iaht3;      /* Reset, R     */
> +                       u32 iaht4;      /* Reset, R     */
> +                       u32 gaht1;      /* Reset, R     */
> +                       u32 gaht2;      /* Reset, R     */
> +                       u32 gaht3;      /* Reset, R     */
> +                       u32 gaht4;      /* Reset, R     */
> +                       u32 lsah;
> +                       u32 lsal;
> +                       u32 ipgvr;      /* Reset,    T  */
> +                       u32 stacr;      /* Special      */
> +                       u32 trtr;       /* Special      */
> +                       u32 rwmr;       /* Reset        */
> +                       u32 octx;
> +                       u32 ocrx;
> +                       u32 ipcr;
> +               };
> +               /* Registers unique to EMAC4SYNC implementations */
> +               struct {
> +                       u32 mahr;       /* Reset, R, T  */
> +                       u32 malr;       /* Reset, R, T  */
> +                       u32 mmahr;      /* Reset, R, T  */
> +                       u32 mmalr;      /* Reset, R, T  */
> +                       u32 rsvd0[4];
> +                       u32 lsah;
> +                       u32 lsal;
> +                       u32 ipgvr;      /* Reset, T     */
> +                       u32 stacr;
> +                       u32 trtr;
> +                       u32 rwmr;       /* Reset        */
> +                       u32 octx;
> +                       u32 ocrx;
> +                       u32 rsvd1;
> +                       u32 revid;
> +                       u32 rsvd2[2];
> +                       u32 iaht[8];    /* Reset, R     */
> +                       u32 gaht[8];    /* Reset, R     */
> +                       u32 tpc;        /* Reset, T     */
> +               };
> +       };

Getting there :-) I note that all your sub-structs are unnamed. How does
the compiler knows which one to use to get to, for example, "lsah" ?

Thanks for working on that btw !

Cheers,
Ben.
