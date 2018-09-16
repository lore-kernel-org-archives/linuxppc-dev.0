Return-Path: <breno.debian@gmail.com>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42D0yQ6kBBzF1p5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 06:21:15 +1000 (AEST)
Received: by mail-qt0-f196.google.com with SMTP id k38-v6so13515154qtk.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Sep 2018 13:21:15 -0700 (PDT)
Subject: Re: [PATCH] powerpc/tm: Fix HFSCR bit for no suspend case
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, Michael Neuling <mikey@neuling.org>
References: <20180911030756.19583-1-mikey@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <ff27c6c4-9a7b-1851-9635-4e8ad0fcff93@debian.org>
Date: Sun, 16 Sep 2018 17:21:09 -0300
MIME-Version: 1.0
In-Reply-To: <20180911030756.19583-1-mikey@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/11/2018 12:07 AM, Michael Neuling wrote:
> Currently on P9N DD2.1 we end up taking infinite TM facility
> unavailable exceptions on the first TM usage by userspace.
> 
> In the special case of TM no suspend (P9N DD2.1), Linux is told TM is
> off via CPU dt-ftrs but told to (partially) use it via
> OPAL_REINIT_CPUS_TM_SUSPEND_DISABLED. So HFSCR[TM] will be off from
> dt-ftrs but we need to turn it on for the no suspend case.
> 
> This patch fixes this by enabling HFSCR TM in this case.
> 
> Cc: stable@vger.kernel.org # 4.15+
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Tested-by: Breno Leitao <leitao@debian.org>
