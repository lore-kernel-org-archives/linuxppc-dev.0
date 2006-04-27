Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 258A067A00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 21:19:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3RBJ7rl017848
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 07:19:07 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3RBJ7PR202766
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 07:19:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3RBJ71v023862
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 07:19:07 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 06/16] ehca: common include files
Date: Thu, 27 Apr 2006 13:19:06 +0200
References: <4450A183.6030405@de.ibm.com>
In-Reply-To: <4450A183.6030405@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604271319.06844.arnd.bergmann@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 27 April 2006 12:48, Heiko J Schick wrote:

> +/**
> + * ehca_adr_bad - Handle to be used for adress translation mechanisms,
> + * currently a placeholder.
> + */
> +inline static int ehca_adr_bad(void *adr)

'static inline', not 'inline static', by convention.


> +/* We will remove this lines in SVN when it is included in the Linux kernel.
> + * We don't want to introducte unnecessary dependencies to a patched kernel.
> + */
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,17)

Well, you should also remove this for submission, I guess ;-)

> +#define EHCA_EDEB_TRACE_MASK_SIZE 32
> +extern u8 ehca_edeb_mask[EHCA_EDEB_TRACE_MASK_SIZE];
> +#define EDEB_ID_TO_U32(str4) (str4[3] | (str4[2] << 8) | (str4[1] << 16) | \
> +			      (str4[0] << 24))
> +
> +inline static u64 ehca_edeb_filter(const u32 level,
> +				   const u32 id, const u32 line)

'static inline' again. best grep all your source for this, there are probably
more places.

> +{
> +	u64 ret = 0;
> +	u32 filenr = 0;
> +	u32 filter_level = 9;
> +	u32 dynamic_level = 0;
> +
> +	/* This is code written for the gcc -O2 optimizer which should colapse
> +	 * to two single ints filter_level is the first level kicked out by
> +	 * compiler means trace everythin below 6. */
> +	if (id == EDEB_ID_TO_U32("ehav")) {
> +		filenr = 0x01;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("clas")) {
> +		filenr = 0x02;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("cqeq")) {
> +		filenr = 0x03;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("shca")) {
> +		filenr = 0x05;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("eirq")) {
> +		filenr = 0x06;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("lMad")) {
> +		filenr = 0x07;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("mcas")) {
> +		filenr = 0x08;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("mrmw")) {
> +		filenr = 0x09;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("vpd ")) {
> +		filenr = 0x0a;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("e_qp")) {
> +		filenr = 0x0b;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("uqes")) {
> +		filenr = 0x0c;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("PHYP")) {
> +		filenr = 0x0d;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("hcpi")) {
> +		filenr = 0x0e;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("iptz")) {
> +		filenr = 0x0f;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("spta")) {
> +		filenr = 0x10;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("simp")) {
> +		filenr = 0x11;
> +		filter_level = 8;
> +	}
> +	if (id == EDEB_ID_TO_U32("reqs")) {
> +		filenr = 0x12;
> +		filter_level = 8;
> +	}

I guess you can convert that to

switch (id) {
	case EBEB_ID_CLAS:
		...
	case EDEB_ID_CQEQ:
		...
}

> +
> +#ifdef EHCA_USE_HCALL_KERNEL
> +#ifdef CONFIG_PPC_PSERIES
> +
> +#include <asm/paca.h>
> +

You could make everything down from here a separate header
for hcall.
