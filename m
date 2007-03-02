Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>,
	<cbe-oss-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 02 Mar 2007 22:32:43 +1100
Subject: [PATCH 0/5] Support 64K pages mapping of SPE local stores on 4K
	kernel
Message-Id: <1172835163.743765.616483133775.qpush@grosgo>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This serie of patches supports userland mappings of SPE local stores
using 64K hardware pages rather than 4K on a kernel using 4K pages to
improve performances.

The current version of this serie relies on a hack to the generic code
which is probably not acceptable upsteam. I have plans to do a proper
fix but haven't had time to do it yet.

The first patch of the serie is fairly independant of the rest and
should be applied to 2.6.21 as I beleive it fixes a bug with handling
of huge pages from SPEs.

This drop fixes a bug in the previous version where the wrong PTE could
be used by the hash code causing a failure to hash when accessing a
64K mapping. I also added the missing symbol exports for modules as
pointed out by Michael.
