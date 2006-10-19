Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Support for MPIC on native cell
Date: Thu, 19 Oct 2006 16:38:50 +0200
References: <1160984707.22522.64.camel@localhost.localdomain>
In-Reply-To: <1160984707.22522.64.camel@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200610191638.50652.arnd.bergmann@de.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: "cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 16 October 2006 09:45, Benjamin Herrenschmidt wrote:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* The MPIC driver will get=
 everything it needs from the
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * device-tree, just pass 0=
 to all arguments
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mpic =3D mpic_alloc(dn, 0, =
0, 0, 0, " MPIC =A0 =A0 ");

Do you expect future users to do the same and just pass zeroes?
If so, maybe we should add a small wrapper like

static inline struct mpic *mpic_probe(struct device_node *dn)
{
	return mpic_alloc(dn, 0, 0, 0, 0, " MPIC     ");
}

in <asm/mpic.h>

	Arnd <><
