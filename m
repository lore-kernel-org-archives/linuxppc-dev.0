Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com
 [IPv6:2a00:1450:400c:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B37981A011E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 20:22:36 +1100 (AEDT)
Received: by mail-wm0-x22c.google.com with SMTP id 123so43814353wmz.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 01:22:36 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20160106092715.GA23148@mwanda>
References: <20160106092715.GA23148@mwanda>
Date: Mon, 18 Jan 2016 17:22:32 +0800
Message-ID: <CADRPPNR+xoTgU=Da+zCxFk8Ecn-p+syB8p7nfkGcC+PdUzYN5g@mail.gmail.com>
Subject: Re: [POWERPC] Add QUICC Engine (QE) infrastructure
From: Li Yang <leoli@freescale.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Zhao Qiang <qiang.zhao@nxp.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 6, 2016 at 5:27 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Li Yang,
>
> The patch 986585385131: "[POWERPC] Add QUICC Engine (QE)
> infrastructure" from Oct 3, 2006, leads to the following static
> checker warning:
>
>         drivers/soc/fsl/qe/qe_ic.c:412 qe_ic_set_priority()
>         error: buffer overflow 'qe_ic_info' 44 <= 127
>
> drivers/soc/fsl/qe/qe_ic.c
>    401  /* Set Priority level within its group, from 1 to 8 */
>    402  int qe_ic_set_priority(unsigned int virq, unsigned int priority)
>    403  {
>    404          struct qe_ic *qe_ic = qe_ic_from_irq(virq);
>    405          unsigned int src = virq_to_hw(virq);
>    406          u32 temp;
>    407
>    408          if (priority > 8 || priority == 0)
>    409                  return -EINVAL;
>    410          if (src > 127)
>
> The 127 isn't right here, I'm not sure where that value comes from.  It
> should be >= ARRAY_SIZE(qe_ic_info).


Hi Dan,

Thanks for pointing this out.  127 should be the theoretical up
boundary of QEIC. You are right that we should have a stricter check.
And maybe a more serious issue is that we didn't check the overflow at
the host_map() stage.

Regards,
Leo
