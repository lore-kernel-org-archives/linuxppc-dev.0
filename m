Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7rs41SD3zDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 20:59:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 linux-security-module@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
In-Reply-To: <1470313475-20090-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1470313475-20090-2-git-send-email-zohar@linux.vnet.ibm.com>
Date: Tue, 09 Aug 2016 20:59:51 +1000
Message-ID: <87wpjqtdg8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index b5728da..84e8d36 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -102,6 +102,13 @@ struct ima_queue_entry {
>  };
>  extern struct list_head ima_measurements;	/* list of all measurements */
>  
> +/* Some details preceding the binary serialized measurement list */
> +struct ima_kexec_hdr {
> +	unsigned short version;
> +	unsigned long buffer_size;
> +	unsigned long count;
> +} __packed;
> +

Am I understanding it correctly that this structure is passed between kernels?

If so it's an ABI and should use types with well defined sizes, as if it was
going out to userspace, shouldn't it?

cheers
