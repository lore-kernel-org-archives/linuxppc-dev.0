Return-Path: <galak@kernel.crashing.org>
Subject: Re: [RFC:PATCH 02/03] powerpc: Add definitions for Debug Registers on
	BookE Platforms
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091210155721.6697.40863.sendpatchset@norville.austin.ibm.com>
Date: Thu, 10 Dec 2009 20:41:53 -0600
Message-Id: <1134F495-6623-437F-AF1F-64D0A87BA112@kernel.crashing.org>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155721.6697.40863.sendpatchset@norville.austin.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 10, 2009, at 9:57 AM, Dave Kleikamp wrote:

> +#define DBCR1_IAC1US	0xC0000000	/* Instr Addr Cmp 1 Sup/User   =
*/
> +#define DBCR1_IAC1ER	0x30000000	/* Instr Addr Cmp 1 Eff/Real */
> +#define DBCR1_IAC1ER_01	0x10000000	/* reserved */
> +#define DBCR1_IAC1ER_10	0x20000000	/* Instr Addr Cmp 1 =
Eff/Real MSR[IS]=3D0 */
> +#define DBCR1_IAC1ER_11	0x30000000	/* Instr Addr Cmp 1 =
Eff/Real MSR[IS]=3D1 */
> +#define DBCR1_IAC2US	0x0C000000	/* Instr Addr Cmp 2 Sup/User   =
*/
> +#define DBCR1_IAC2ER	0x03000000	/* Instr Addr Cmp 2 Eff/Real */
> +#define DBCR1_IAC2ER_01	0x01000000	/* reserved */
> +#define DBCR1_IAC2ER_10	0x02000000	/* Instr Addr Cmp 2 =
Eff/Real MSR[IS]=3D0 */
> +#define DBCR1_IAC2ER_11	0x03000000	/* Instr Addr Cmp 2 =
Eff/Real MSR[IS]=3D1 */
> +#define DBCR1_IAC12M	0x00C00000	/* Instr Addr 1-2 range enable =
*/
> +#define DBCR1_IAC12M_R	0x00400000	/* Instr Addr 1-2 =
reserved state */
> +#define DBCR1_IAC12M_I	0x00800000	/* Instr Addr 1-2 range =
inclusive */
> +#define DBCR1_IAC12M_X	0x00C00000	/* Instr Addr 1-2 range =
eXclusive */
> +#define DBCR1_IAC12A_T	0x00010000	/* Instr Addr 1-2 range =
Toggle */
> +#define DBCR1_IAC3US	0x0000C000	/* Instr Addr Cmp 3 Sup/User   =
*/
> +#define DBCR1_IAC3ER	0x00003000	/* Instr Addr Cmp 3 Eff/Real */
> +#define DBCR1_IAC3ER_01	0x00001000	/* reserved */
> +#define DBCR1_IAC3ER_10	0x00002000	/* Instr Addr Cmp 3 =
Eff/Real MSR[IS]=3D0 */
> +#define DBCR1_IAC3ER_11	0x00003000	/* Instr Addr Cmp 3 =
Eff/Real MSR[IS]=3D1 */
> +#define DBCR1_IAC4US	0x00000C00	/* Instr Addr Cmp 4 Sup/User   =
*/
> +#define DBCR1_IAC4ER	0x00000300	/* Instr Addr Cmp 4 Eff/Real */
> +#define DBCR1_IAC4ER_01	0x00000100	/* Instr Addr Cmp 4 =
Eff/Real MSR[IS]=3D0 */
> +#define DBCR1_IAC4ER_10	0x00000200	/* Instr Addr Cmp 4 =
Eff/Real MSR[IS]=3D0 */
> +#define DBCR1_IAC4ER_11	0x00000300	/* Instr Addr Cmp 4 =
Eff/Real MSR[IS]=3D1 */
> +#define DBCR1_IAC34M	0x000000C0	/* Instr Addr 3-4 range enable =
*/
> +#define DBCR1_IAC34M_R	0x00000040	/* Instr Addr 3-4 =
reserved state */
> +#define DBCR1_IAC34M_I	0x00000080	/* Instr Addr 3-4 range =
inclusive */
> +#define DBCR1_IAC34M_X	0x000000C0	/* Instr Addr 3-4 range =
eXclusive */
> +#define DBCR1_IAC34A_T	0x00000001	/* Instr Addr 3-4 range =
Toggle */
> +
> +#define DBCR1_USER_DEBUG	(DBCR1_IAC12M | DBCR1_IAC34M)
> +#define DBCR1_BASE_REG_VALUE	(DBCR1_IAC1US | DBCR1_IAC1ER_10 | \
> +				 DBCR1_IAC2US | DBCR1_IAC2ER_10 | \
> +				 DBCR1_IAC3US | DBCR1_IAC3ER_10 | \
> +				 DBCR1_IAC4US | DBCR1_IAC4ER_10)

We are we using MSR[IS] IS=3D0, why not just any Eff address?  In the =
future we might have user as IS =3D 1, and kernel as IS =3D 0.

- k=
