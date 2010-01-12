Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [RFC,PATCH 0/7 v2] Common struct clk implementation
Message-Id: <1263279511.160127.576969496193.0.gpush@pororo>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Tue, 12 Jan 2010 17:58:31 +1100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

These patches are an attempt to allow platforms to share clock code. At
present, the definitions of struct clk are local to platform code, which
makes allocating and initialising cross-platform clock sources
difficult.

The first two patches are for the architecture-independent kernel code,
introducing the common clk API. The remaining patches are specific to
the ARM 'versatile' and 'realview' platforms.  I've included them in
this series to illustrate how the clock API is used, by using a generic
interface for the icst307 clock, and sharing it between realview and
versatile.

Ben Herrenschmidt is looking at using common struct clk code for powerpc
too, hence the kernel-wide approach.

Comments most welcome.

Cheers,


Jeremy

--
v2:
 * no longer ARM-specific
 * use clk_operations

---
Jeremy Kerr (7):
      Add a common struct clk
      Generic support for fixed-rate clocks
      arm/versatile: use generic struct clk
      arm/versatile: remove oscoff from clk_versatile
      arm/realview: use generic struct clk
      arm/icst307: use common struct clk, unify realview and versatile clocks
      arm/icst307: remove icst307_ps_to_vco
