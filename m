Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24FB81A06AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 11:59:48 +1000 (EST)
Received: from mail-vc0-x229.google.com (mail-vc0-x229.google.com
 [IPv6:2607:f8b0:400c:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9410A1400D6
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2014 11:59:47 +1000 (EST)
Received: by mail-vc0-f169.google.com with SMTP id le20so5380401vcb.28
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Aug 2014 18:59:45 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <1407303737-29529-1-git-send-email-mpe@ellerman.id.au>
References: <1407303737-29529-1-git-send-email-mpe@ellerman.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 7 Aug 2014 11:29:25 +0930
Message-ID: <CACPK8Xdqv8B4Euc0S-isjJCyV9dbwos2nQ4sSBXRZSircXfPxg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Add POWER8 features to CPU_FTRS_POSSIBLE/ALWAYS
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2014 at 3:12 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> We have been a bit slack about updating the CPU_FTRS_POSSIBLE and
> CPU_FTRS_ALWAYS masks. When we added POWER8, and also POWER8E we forgot
> to update the ALWAYS mask. And when we added POWER8_DD1 we forgot to
> update both the POSSIBLE and ALWAYS masks.
>
> Luckily this hasn't caused any actual bugs AFAICS. Failing to update the
> ALWAYS mask just forgoes a potential optimisation opportunity. Failing
> to update the POSSIBLE mask for POWER8_DD1 is also OK because it only
> removes a bit rather than adding any.
>
> Regardless they should all be in both masks so as to avoid any future
> bugs when the set of ALWAYS/POSSIBLE bits changes, or the masks
> themselves change.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks for catching that.

Acked-by: Joel Stanley <joel@jms.id.au>
