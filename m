Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdxCs5gx8zDqN4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 19:47:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/12] powerpc/vas: Define macros,
 register fields and structures
In-Reply-To: <1503556688-15412-2-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-2-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 19:47:36 +1000
Message-ID: <87y3q8t1vr.fsf@concordia.ellerman.id.au>
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

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
> new file mode 100644
> index 0000000..c66aaf0
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/vas.h
> @@ -0,0 +1,385 @@
...
> +
> +/*
> + * In-kernel state a VAS window. One per window.
> + */
> +struct vas_window {
> +	/* Fields common to send and receive windows */
> +	struct vas_instance *vinst;
> +	int winid;
> +	bool tx_win;		/* True if send window */
> +	bool nx_win;		/* True if NX window */
> +	bool user_win;		/* True if user space window */
> +	void *hvwc_map;		/* HV window context */
> +	void *uwc_map;		/* OS/User window context */
> +	pid_t pid;		/* Linux process id of owner */
> +
> +	/* Fields applicable only to send windows */
> +	void *paste_kaddr;
> +	char *paste_addr_name;
> +	struct vas_window *rxwin;
> +
> +	/* Feilds applicable only to receive windows */
> +	enum vas_cop_type cop;
> +	atomic_t num_txwins;

Just noticed this. You should probably use the new refcount_t type,
because AFAICS you're using this as a refcount.

cheers
