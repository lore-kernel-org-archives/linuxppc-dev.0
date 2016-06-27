Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdGQt4PCkzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 14:38:30 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5R4cR09067062
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 00:38:27 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sp4yd87u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 00:38:27 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 26 Jun 2016 22:38:23 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Oliver O'Halloran" <oohall@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/boot: Add OPAL console to epapr wrappers
In-Reply-To: <1466772481-11424-1-git-send-email-oohall@gmail.com>
References: <1466754085-8230-1-git-send-email-oohall@gmail.com>
 <1466772481-11424-1-git-send-email-oohall@gmail.com>
Date: Mon, 27 Jun 2016 14:38:13 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87shvzcklm.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:
> This patch adds an OPAL console backend to the powerpc boot wrapper so
> that decompression failures inside the wrapper can be reported to the
> user. This is important since it typically indicates data corruption in
> the firmware and other nasty things.
>
> Currently this only works when building a little endian kernel. When
> compiling a 64 bit BE kernel the wrapper is always build 32 bit to be
> compatible with some 32 bit firmwares. BE support will be added at a
> later date. Another limitation of this is that only the "raw" type of
> OPAL console is supported, however machines that provide a hvsi console
> also provide a raw console so this is not an issue in practice.
>
> Actually-written-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org

(with addition of (C) headers suggested below)

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>

One thing to think of is if we really need anything printed except the
error message. Out of these three lines of output (for a corrupted
zImage.epapr), only the last line gives any real information.

5343492: (5343490): zImage starting: loaded at 0x0000000020010000 (sp: 0x0000000020ee2ed8)
5507562: (5507560): Allocating 0x159efd4 bytes for kernel ...
5557104: (5557102): gunzipping (0x0000000000000000 <- 0x000000002001e000:0x0000000020ee05c0)...inflate returned -3 msg: invalid block type

Although this should likely be addressed in another patch.

> ---
>  arch/powerpc/boot/Makefile     |  4 +-
>  arch/powerpc/boot/opal-calls.S | 49 +++++++++++++++++++++++
>  arch/powerpc/boot/opal.c       | 88 ++++++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/boot/ops.h        |  1 +
>  arch/powerpc/boot/ppc_asm.h    |  4 ++
>  arch/powerpc/boot/serial.c     |  2 +
>  arch/powerpc/boot/types.h      | 12 ++++++
>  7 files changed, 158 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/boot/opal-calls.S
>  create mode 100644 arch/powerpc/boot/opal.c
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 8fe78a3efc92..00cf88aa9a23 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -70,7 +70,7 @@ $(addprefix $(obj)/,$(zlib) cuboot-c2k.o gunzip_util.o main.o): \
>  libfdt       := fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
>  libfdtheader := fdt.h libfdt.h libfdt_internal.h
>
> -$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o): \
> +$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o): \
>  	$(addprefix $(obj)/,$(libfdtheader))
>
>  src-wlib-y := string.S crt0.S crtsavres.S stdio.c main.c \
> @@ -78,7 +78,7 @@ src-wlib-y := string.S crt0.S crtsavres.S stdio.c main.c \
>  		ns16550.c serial.c simple_alloc.c div64.S util.S \
>  		gunzip_util.c elf_util.c $(zlib) devtree.c stdlib.c \
>  		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
> -		uartlite.c mpc52xx-psc.c
> +		uartlite.c mpc52xx-psc.c opal.c opal-calls.S
>  src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
>  src-wlib-$(CONFIG_44x) += 4xx.c ebony.c bamboo.c
>  src-wlib-$(CONFIG_8xx) += mpc8xx.c planetcore.c fsl-soc.c
> diff --git a/arch/powerpc/boot/opal-calls.S b/arch/powerpc/boot/opal-calls.S
> new file mode 100644
> index 000000000000..1f3c097e1552
> --- /dev/null
> +++ b/arch/powerpc/boot/opal-calls.S
> @@ -0,0 +1,49 @@

Needs (C) header.

> +#include "ppc_asm.h"
> +#include "../include/asm/opal-api.h"
> +
> +	.text
> +
> +#define OPAL_CALL(name, token)				\
> +	.globl name;					\
> +name:							\
> +	li	r0, token;				\
> +	b	opal_call;
> +
> +opal_call:
> +	mflr	r11
> +	std	r11,16(r1)
> +	mfcr	r12
> +	stw	r12,8(r1)
> +	mr	r13,r2
> +
> +	/* Set opal return address */
> +	ld	r11,opal_return@got(r2)
> +	mtlr	r11
> +	mfmsr	r12
> +
> +	/* switch to BE when we enter OPAL */
> +	li	r11,MSR_LE
> +	andc	r12,r12,r11
> +	mtspr	SPRN_HSRR1,r12
> +
> +	/* load the opal call entry point and base */
> +	ld	r11,opal@got(r2)
> +	ld	r12,8(r11)
> +	ld	r2,0(r11)
> +	mtspr	SPRN_HSRR0,r12
> +	hrfid
> +
> +opal_return:
> +	FIXUP_ENDIAN
> +	mr	r2,r13;
> +	lwz	r11,8(r1);
> +	ld	r12,16(r1)
> +	mtcr	r11;
> +	mtlr	r12
> +	blr
> +
> +OPAL_CALL(opal_console_write,			OPAL_CONSOLE_WRITE);
> +OPAL_CALL(opal_console_read,			OPAL_CONSOLE_READ);
> +OPAL_CALL(opal_console_write_buffer_space,	OPAL_CONSOLE_WRITE_BUFFER_SPACE);
> +OPAL_CALL(opal_poll_events,			OPAL_POLL_EVENTS);
> +OPAL_CALL(opal_console_flush,			OPAL_CONSOLE_FLUSH);
> diff --git a/arch/powerpc/boot/opal.c b/arch/powerpc/boot/opal.c
> new file mode 100644
> index 000000000000..d0f54443caa9
> --- /dev/null
> +++ b/arch/powerpc/boot/opal.c
> @@ -0,0 +1,88 @@
> +#include "ops.h"
> +#include "stdio.h"
> +#include "io.h"
> +#include <libfdt.h>
> +#include "../include/asm/opal-api.h"

Needs (C) header.

> +
> +/* Global OPAL struct used by opal-call.S */
> +struct opal {
> +	u64 base;
> +	u64 entry;
> +} opal;
> +
> +static u32 opal_con_id;
> +
> +int64_t opal_console_write(int64_t term_number, u64 *length, const u8 *buffer);
> +int64_t opal_console_read(int64_t term_number, uint64_t *length, u8 *buffer);
> +int64_t opal_console_write_buffer_space(uint64_t term_number, uint64_t *length);
> +int64_t opal_console_flush(uint64_t term_number);
> +int64_t opal_poll_events(uint64_t *outstanding_event_mask);
> +
> +static int opal_con_open(void)
> +{
> +	return 0;
> +}
> +
> +static void opal_con_putc(unsigned char c)
> +{
> +	int64_t rc;
> +	uint64_t olen, len;
> +
> +	do {
> +		rc = opal_console_write_buffer_space(opal_con_id, &olen);
> +		len = be64_to_cpu(olen);
> +		if (rc)
> +			return;
> +		opal_poll_events(NULL);
> +	} while (len < 1);
> +
> +
> +	olen = cpu_to_be64(1);
> +	opal_console_write(opal_con_id, &olen, &c);
> +}
> +
> +static void opal_con_close(void)
> +{
> +	opal_console_flush(opal_con_id);
> +}
> +
> +static void opal_init(void)
> +{
> +	void *opal_node;
> +
> +	opal_node = finddevice("/ibm,opal");
> +	if (!opal_node)
> +		return;
> +	if (getprop(opal_node, "opal-base-address", &opal.base, sizeof(u64)) < 0)
> +		return;
> +	opal.base = be64_to_cpu(opal.base);
> +	if (getprop(opal_node, "opal-entry-address", &opal.entry, sizeof(u64)) < 0)
> +		return;
> +	opal.entry = be64_to_cpu(opal.entry);
> +}
> +
> +#ifdef __powerpc64__
> +int opal_console_init(void *devp, struct serial_console_data *scdp)
> +{
> +	opal_init();
> +
> +	if (devp) {
> +		int n = getprop(devp, "reg", &opal_con_id, sizeof(u32));
> +		if (n != sizeof(u32))
> +			return -1;
> +		opal_con_id = be32_to_cpu(opal_con_id);
> +	} else
> +		opal_con_id = 0;
> +
> +	scdp->open = opal_con_open;
> +	scdp->putc = opal_con_putc;
> +	scdp->close = opal_con_close;
> +
> +	return 0;
> +}
> +#else
> +int opal_console_init(void *devp, struct serial_console_data *scdp)
> +{
> +	return -1;
> +}
> +#endif
> diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
> index 5e75e1c5518e..e19b64ef977a 100644
> --- a/arch/powerpc/boot/ops.h
> +++ b/arch/powerpc/boot/ops.h
> @@ -89,6 +89,7 @@ int mpsc_console_init(void *devp, struct serial_console_data *scdp);
>  int cpm_console_init(void *devp, struct serial_console_data *scdp);
>  int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp);
>  int uartlite_console_init(void *devp, struct serial_console_data *scdp);
> +int opal_console_init(void *devp, struct serial_console_data *scdp);
>  void *simple_alloc_init(char *base, unsigned long heap_size,
>  			unsigned long granularity, unsigned long max_allocs);
>  extern void flush_cache(void *, unsigned long);
> diff --git a/arch/powerpc/boot/ppc_asm.h b/arch/powerpc/boot/ppc_asm.h
> index 35ea60c1f070..b03373d8b386 100644
> --- a/arch/powerpc/boot/ppc_asm.h
> +++ b/arch/powerpc/boot/ppc_asm.h
> @@ -61,6 +61,10 @@
>
>  #define SPRN_TBRL	268
>  #define SPRN_TBRU	269
> +#define SPRN_HSRR0	0x13A	/* Hypervisor Save/Restore 0 */
> +#define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
> +
> +#define MSR_LE		0x0000000000000001
>
>  #define FIXUP_ENDIAN						   \
>  	tdi   0, 0, 0x48; /* Reverse endian of b . + 8		*/ \
> diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
> index 167ee9433de6..e04c1e4063ae 100644
> --- a/arch/powerpc/boot/serial.c
> +++ b/arch/powerpc/boot/serial.c
> @@ -132,6 +132,8 @@ int serial_console_init(void)
>  	else if (dt_is_compatible(devp, "xlnx,opb-uartlite-1.00.b") ||
>  		 dt_is_compatible(devp, "xlnx,xps-uartlite-1.00.a"))
>  		rc = uartlite_console_init(devp, &serial_cd);
> +	else if (dt_is_compatible(devp, "ibm,opal-console-raw"))
> +		rc = opal_console_init(devp, &serial_cd);
>
>  	/* Add other serial console driver calls here */
>
> diff --git a/arch/powerpc/boot/types.h b/arch/powerpc/boot/types.h
> index 31393d17a9c1..cda474cd63c8 100644
> --- a/arch/powerpc/boot/types.h
> +++ b/arch/powerpc/boot/types.h
> @@ -12,6 +12,18 @@ typedef short			s16;
>  typedef int			s32;
>  typedef long long		s64;
>
> +
> +/* required for opal-api.h */
> +typedef u8  uint8_t;
> +typedef u16 uint16_t;
> +typedef u32 uint32_t;
> +typedef u64 uint64_t;
> +typedef s8  int8_t;
> +typedef s16 int16_t;
> +typedef s32 int32_t;
> +typedef s64 int64_t;
> +
> +
>  #define min(x,y) ({ \
>  	typeof(x) _x = (x);	\
>  	typeof(y) _y = (y);	\
> -- 
> 2.5.5
>

-- 
Stewart Smith
OPAL Architect, IBM.
