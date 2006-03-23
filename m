Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch 06/13] powerpc: cell interrupt controller updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <abergman@de.ibm.com>
In-Reply-To: <20060323203521.862355000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060323203521.862355000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 09:15:52 +1100
Message-Id: <1143152153.4257.28.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, stk@de.ibm.com,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	hpenner@de.ibm.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-03-23 at 00:00 +0100, Arnd Bergmann wrote:
> plain text document attachment (cell-pic-updates-3.diff)
> The current interrupt controller setup on Cell is done
> in a rather ad-hoc way with device tree properties
> that are not standardized at all.
> 
> In an attempt to do something that follows the OF standard
> (or at least the IBM extensions to it) more closely,
> we have now come up with this patch. It still provides
> a fallback to the old behaviour when we find older firmware,
> that hack can not be removed until the existing customer
> installations have upgraded.

BTW... You still use __ioremap(...,PAGE_NO_CACHE); which I think won't
give you guarded... I wouldn'd do that if I were you... The accessors
should have barriers but still...

Ben.
