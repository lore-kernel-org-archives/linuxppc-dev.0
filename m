Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ADC1B2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 01:07:11 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [PATCH 2/3] powerpc: Bail out of KGDB when we've been triggered
Date: Wed, 22 Aug 2012 15:07:00 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B7059AE7E7@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1345632192-19810-1-git-send-email-tiejun.chen@windriver.com>
 <1345632192-19810-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1345632192-19810-2-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jason.wessel@windriver.com" <jason.wessel@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2012 at 5:43 AM, Tiejun Chen <tiejun.chen@windriver.com> wr=
ote:

> +int kgdb_skipexception(int exception, struct pt_regs *regs)
> +{
> +       if (kgdb_isremovedbreak(regs->nip))
> +               return 1;
> +
> +       return 0;
> +}

int kgdb_skipexception(int exception, struct pt_regs *regs)
{
        return !!kgdb_isremovedbreak(regs->nip));
}

If the caller only cares about zero vs. non-zero, you can drop the !!.

--=20
Timur Tabi
Linux kernel developer at Freescale=
