Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8471567CDD
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:06:22 +1100 (EST)
Date: Wed, 15 Nov 2006 19:06:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 11/16] powerpc: add ps3 platform repository support
Message-ID: <20061115180613.GC18856@lst.de>
References: <4554DAFC.1070804@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4554DAFC.1070804@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 10, 2006 at 12:03:08PM -0800, Geoff Levand wrote:
> + * make_first_field - Make the first field of a repository node name.
> + * @text: Text portion of the field.
> + * @index: Numeric index portion of the field.  Use zero for 'don't care'.
> + *
> + * This routine sets the vendor id to zero (non-vendor specific).
> + * Returns field value.
> + */
> +
> +static u64 make_first_field(const char *text, u64 index)
> +{
> +	u64 n;
> +
> +	strncpy((char *)&n, text, 8);
> +	return ps3pf_vendor_id_none + (n >> 32) + index;
> +}

a strncpy into a const pointer doesn't make any sense.
