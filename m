Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3FC51A0E4F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 03:42:55 +1100 (AEDT)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 86A5A1402A6
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2015 03:42:52 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/3] powerpc/nvram: move generic code for nvram and
 pstore
Date: Fri, 30 Jan 2015 17:42:45 +0100
Message-ID: <1939177.TRC136ehpt@wuerfel>
In-Reply-To: <20150130151400.13976.90106.stgit@localhost.localdomain>
References: <20150130151247.13976.88337.stgit@localhost.localdomain>
 <20150130151400.13976.90106.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 30 January 2015 20:44:00 Hari Bathini wrote:
> With minor checks, we can move most of the code for nvram
> under pseries to a common place to be re-used by other
> powerpc platforms like powernv. This patch moves such
> common code to arch/powerpc/kernel/nvram_64.c file.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Can you make this y2038-safe in the process, possibly as a
follow-up patch?

> +extern unsigned long last_rtas_event;

time64_t

> +	}
> +	oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
> +	oops_hdr->report_length = cpu_to_be16(zipped_len);
> +	oops_hdr->timestamp = cpu_to_be64(get_seconds());
> +	return 0;

ktime_get_real_seconds()

> +static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
> +				int *count, struct timespec *time, char **buf,
> +				bool *compressed, struct pstore_info *psi)

This has to remain timespec for now but can later be changed to timespec64
when the API gets changed.

> +		oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
> +		oops_hdr->report_length = cpu_to_be16(text_len);
> +		oops_hdr->timestamp = cpu_to_be64(get_seconds());

ktime_get_real_seconds()

	Arnd
