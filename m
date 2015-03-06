Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0131.outbound.protection.outlook.com [157.56.111.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D97EB1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 11:21:39 +1100 (AEDT)
Date: Thu, 5 Mar 2015 18:16:15 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Martin Hicks <mort@bork.org>
Subject: Re: [PATCH 2/2] crypto: talitos: Add AES-XTS Support
Message-ID: <20150305181615.493b173d43249548fae29203@freescale.com>
In-Reply-To: <1424451610-5786-3-git-send-email-mort@bork.org>
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <1424451610-5786-3-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 Feb 2015 12:00:10 -0500
Martin Hicks <mort@bork.org> wrote:

> The newer talitos hardware has support for AES in XTS mode.

Assuming it's the same thing, AES-XCBC gets added with SEC v3.0
h/w.  Assuming hw_supports() doesn't already support this algorithm
combination (technically via the mode bit), this needs to be
reflected in the patch so the driver doesn't think SEC 2.x devices
can do XTS, too.

> +		.desc_hdr_template = DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU |
> +					DESC_HDR_SEL0_AESU |
> +					DESC_HDR_MODE0_AESU_XTS,

...

>  /* primary execution unit mode (MODE0) and derivatives */
>  #define	DESC_HDR_MODE0_ENCRYPT		cpu_to_be32(0x00100000)
>  #define	DESC_HDR_MODE0_AESU_CBC		cpu_to_be32(0x00200000)
> +#define	DESC_HDR_MODE0_AESU_XTS		cpu_to_be32(0x04200000)

I'd prefer these defines be kept as single bit definitions, and keep
their names from the manual.  An XTS-specific definition can be
composed from them either after this, or manually in the
desc_hdr_template assignment above.

Thanks,

Kim
