Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E68EA1A03A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:36:54 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 10 Feb 2016 19:36:52 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 28D8A2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:36:50 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1A9acrq45875346
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:36:46 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1A9aHUg029896
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:36:17 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 12/18] cxl: Add guest-specific code
In-reply-to: <1454765345-7417-13-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-13-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 20:35:17 +1100
Message-Id: <1455095080-sup-4400@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reiterating the comment I made on the internal review, I would at some
point like to see an effort to refactor this and reduce the amount of
duplicated code between it and the native version, but that can come
later once this is in.

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Excerpts from Frederic Barrat's message of 2016-02-07 00:28:59 +1100:
> +static int read_vpd(struct cxl *adapter, struct cxl_afu *afu)
...
> +        buf = (u32 *) vpd;
> +        for (i = 0; i*4 < len; i += 4) {
> +            if ((i+3)*4 < len)
> +                pr_devel("%.8x %.8x %.8x %.8x\n",
> +                buf[i], buf[i + 1], buf[i + 2], buf[i + 3]);
> +            else if ((i+2)*4 < len)
> +                pr_devel("%.8x %.8x %.8x\n",
> +                buf[i], buf[i + 1], buf[i + 2]);
> +            else if ((i+1)*4 < len)
> +                pr_devel("%.8x %.8x\n",
> +                buf[i], buf[i + 1]);
> +            else
> +                pr_devel("%.8x\n", buf[i]);

Similar overly verbose debug print out like the I commented on in the
other patch.
