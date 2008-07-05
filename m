Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D739DDE19
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 08:45:19 +1000 (EST)
Subject: Re: [PATCH v3] ibm_newemac: Parameterize EMAC Multicast Match Handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <1215249512-1974-1-git-send-email-gerickson@nuovations.com>
References: <C48F0E18.101F1%gerickson@nuovations.com>
	<1215249512-1974-1-git-send-email-gerickson@nuovations.com>
Content-Type: text/plain
Date: Sun, 06 Jul 2008 08:45:09 +1000
Message-Id: <1215297909.8970.22.camel@pasglop>
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

On Sat, 2008-07-05 at 02:18 -0700, Grant Erickson wrote:
> --- a/drivers/net/ibm_newemac/emac.h
> +++ b/drivers/net/ibm_newemac/emac.h
> @@ -41,14 +41,7 @@ struct emac_regs {
>         u32 vtpid;              /* Reset, R, T  */
>         u32 vtci;               /* Reset, R, T  */
>         u32 ptr;                /* Reset,    T  */
> -       u32 iaht1;              /* Reset, R     */
> -       u32 iaht2;              /* Reset, R     */
> -       u32 iaht3;              /* Reset, R     */
> -       u32 iaht4;              /* Reset, R     */
> -       u32 gaht1;              /* Reset, R     */
> -       u32 gaht2;              /* Reset, R     */
> -       u32 gaht3;              /* Reset, R     */
> -       u32 gaht4;              /* Reset, R     */
> +       u32 reserved[8];/* Chip-dependent */
>         u32 lsah;
>         u32 lsal;
>         u32 ipgvr;              /* Reset,    T  */

Mostly looks good. I don't like "reserved" here tho...

Are lsah, lsal and ipgvr still meaningful here ?

If not, just remove everything past "ptr"...

Another option would have been to have emac regs be something
like

struct emac_regs {
	all the common regs
	.../...
	union (
		struct emac4_add_regs {
			emac4 additional regs
		};
		struct emac4sync_add_regs {
			emac4sync additional regs
		}
	};
};

Ben.
