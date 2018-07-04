Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L9dR2L8kzF1LM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 16:12:40 +1000 (AEST)
Message-ID: <de891d5858b4ea39aeac425fa13260ffd22f7753.camel@russell.cc>
Subject: Re: [PATCH 2/3] powerpc/powernv: DMA operations for discontiguous
 allocation
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, alistair@popple.id.au, aik@ozlabs.ru,
 tpearson@raptorengineering.com
Date: Wed, 04 Jul 2018 16:12:28 +1000
In-Reply-To: <20180629073437.4060-3-ruscur@russell.cc>
References: <20180629073437.4060-1-ruscur@russell.cc>
 <20180629073437.4060-3-ruscur@russell.cc>
Content-Type: multipart/mixed; boundary="=-20EdU+FudRMm7TkKuAZp"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-20EdU+FudRMm7TkKuAZp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2018-06-29 at 17:34 +1000, Russell Currey wrote:

<snip>

> +		/*
> +		 * The TCE isn't being used, so let's try and
> allocate it.
> +		 * Bits 0 and 1 are read/write, and we use bit 2 as
> a "lock"
> +		 * bit.  This is to prevent any race where the value
> is set in
> +		 * the TCE table but the invalidate/mb() hasn't
> finished yet.
> +		 */
> +		entry = cpu_to_be64((addr - offset) | 7);
> +		ret = cmpxchg(&pe->tces[i], tce, entry);
> +		if (ret != tce) {
> +			/* conflict, start looking again just in
> case */
> +			i--;
> +			continue;
> +		}
> +		pnv_pci_phb3_tce_invalidate(pe, 0, 0, addr - offset,
> 1);

This is wrong and won't work outside of PHB3, will make a generic
handler

> +		mb();
> +		/* clear the lock bit now that we know it's active
> */
> +		ret = cmpxchg(&pe->tces[i], entry, cpu_to_be64((addr
> - offset) | 3));
> +		if (ret != entry) {
> +			/* conflict, start looking again just in
> case */
> +			i--;
> +			continue;
> +		}
> +
> +		return (i << phb->ioda.max_tce_order) | offset;
> +	}
> +	/* If we get here, the table must be full, so error out. */
> +	return -1ULL;
> +}
> +
--=-20EdU+FudRMm7TkKuAZp
Content-Type: application/x-desktop; name="qtpass.desktop"
Content-Disposition: attachment; filename="qtpass.desktop"
Content-Transfer-Encoding: base64

W0Rlc2t0b3AgRW50cnldClR5cGU9QXBwbGljYXRpb24KTmFtZT1RdFBhc3MKVmVyc2lvbj0xLjAK
R2VuZXJpY05hbWU9UGFzc3dvcmQgTWFuYWdlcgojR2VuZXJpY05hbWVbYXJfTUFdPQpHZW5lcmlj
TmFtZVtjYV09R2VzdG9yIGRlIGNvbnRyYXNlbnllcwojR2VuZXJpY05hbWVbZGVfREVdPQojR2Vu
ZXJpY05hbWVbZXNfRVNdPQojR2VuZXJpY05hbWVbZnJfQkVdPQojR2VuZXJpY05hbWVbZnJfRlJd
PQojR2VuZXJpY05hbWVbZ2xfRVNdPQojR2VuZXJpY05hbWVbaGVfSUxdPQojR2VuZXJpY05hbWVb
aHVfSFVdPQpHZW5lcmljTmFtZVtubF9OTF09V2FjaHR3b29yZCBCZWhlZXIKI0dlbmVyaWNOYW1l
W3BsX1BMXT0KI0dlbmVyaWNOYW1lW3J1X1JVXT0KI0dlbmVyaWNOYW1lW3N2X1NFXT0KI0dlbmVy
aWNOYW1lW3poX0NOXT0KQ29tbWVudD1HVUkgZm9yIHRoZSBzdGFuZGFyZCB1bml4IHBhc3N3b3Jk
IHN0b3JlCiNDb21tZW50W2FyX01BXT0KQ29tbWVudFtjYV09SW50ZXJmw61jaWUgZ3LDoGZpY2Eg
cGVyIGFsIG1hZ2F0emVtIGRlIGNvbnRyYXNlbnllcyBVTklYIGVzdMOgbmRhcmQKI0NvbW1lbnRb
ZGVfREVdPQojQ29tbWVudFtlc19FU109CiNDb21tZW50W2ZyX0JFXT0KI0NvbW1lbnRbZnJfRlJd
PQojQ29tbWVudFtnbF9FU109CiNDb21tZW50W2hlX0lMXT0KI0NvbW1lbnRbaHVfSFVdPQpDb21t
ZW50W25sX05MXT1HVUkgdm9vciBkZSBzdGFuZGFhcmQgdW5peCB3YWNodHdvb3JkIG9wc2xhZwoj
Q29tbWVudFtwbF9QTF09CiNDb21tZW50W3J1X1JVXT0KI0NvbW1lbnRbc3ZfU0VdPQojQ29tbWVu
dFt6aF9DSF09CkV4ZWM9cXRwYXNzCkljb249cXRwYXNzLWljb24KVGVybWluYWw9ZmFsc2UKQ2F0
ZWdvcmllcz1TZWN1cml0eTtVdGlsaXR5OwpLZXl3b3Jkcz1QYXNzd29yZDtNYW5hZ2VyO1FUOwo=


--=-20EdU+FudRMm7TkKuAZp--
