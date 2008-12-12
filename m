Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Michael Ellerman <michael@ellerman.id.au>, benh@kernel.crashing.org
Subject: powerpc/cell/axon-msi: fix MSI after kexec
Date: Fri, 12 Dec 2008 20:19:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812122019.51191.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit d015fe995 'powerpc/cell/axon-msi: Retry on missing interrupt'
has turned a rare failure to kexec on QS22 into a reproducible
error, which we have now analysed.

The problem is that after a kexec, the MSIC hardware still points
into the middle of the old ring buffer. We set up the ring buffer
during reboot, but not the offset into it. On older kernels, this
would cause a storm of thousands of spurious interrupts after a
kexec, which would most of the time get dropped silently.

With the new code, we time out on each interrupt, waiting for
it to become valid. If more interrupts come in that we time
out on, this goes on indefinitely, which eventually leads to
a hard crash.

The solution in this patch is to read the current offset from
the MSIC when reinitializing it. This now works correctly, as
expected.

Reported-by: Dirk Herrendoerfer <d.herrendoerfer@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

Please apply when Dirk and Michael have given their Ack.
Should we have it in 2.6.28? Not sure if going from 'works sometimes'
to 'works never' counts as a regression. Most users won't be impacted,
because they don't use kexec on QS22.

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 442cf36..548fa4e 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -413,6 +422,9 @@ static int axon_msi_probe(struct of_device *device,
 			MSIC_CTRL_IRQ_ENABLE | MSIC_CTRL_ENABLE |
 			MSIC_CTRL_FIFO_SIZE);
 
+	msic->read_offset = dcr_read(msic->dcr_host, MSIC_WRITE_OFFSET_REG)
+				& MSIC_FIFO_SIZE_MASK;
+
 	device->dev.platform_data = msic;
 
 	ppc_md.setup_msi_irqs = axon_msi_setup_msi_irqs;
