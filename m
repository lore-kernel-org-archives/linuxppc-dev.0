Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAE5E1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 19:32:52 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1AC2B140082
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 19:32:51 +1000 (AEST)
Date: Mon, 27 Apr 2015 11:32:29 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/4] pci: Support 64-bit address translation
Message-ID: <20150427113229.294bf50d@thh440s>
In-Reply-To: <1430121753-24818-3-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1430121753-24818-3-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au,
 Adrian Reber <adrian@lisas.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 27 Apr 2015 13:32:31 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  slof/fs/translate.fs | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/slof/fs/translate.fs b/slof/fs/translate.fs
> index e2633e5..9654f24 100644
> --- a/slof/fs/translate.fs
> +++ b/slof/fs/translate.fs
> @@ -33,11 +33,9 @@
>        dup l@ FF AND 0<> ( prop_type address data cfgspace_offset? )
>        3 pick 0= ( prop_type address data cfgspace_offset? reg_prop? )
>        AND NOT IF 
> -         2dup 8 + ( prop_type address data address data' )
> -         2dup l@ 2 pick 8 + l@ + <= -rot l@  >= and  IF
> +         2dup 4 + ( prop_type address data address data' )
> +         2dup @ 2 pick 8 + @ + <= -rot @  >= and  IF
>              l@ 03000000 and 18 rshift nip
> -            \ no 64bit translations supported pretend it is 32bit
> -            dup 3 = IF  1-  THEN
>              ( prop_type type )
>              swap drop ( type )
>              UNLOOP EXIT

Phew, translate-address stuff ... one of my "favorites" ;-)
I wonder whether this will break "legacy" code like board-js2x ...
there might have been a reason for this "pretend it is 32bit" hack
(I've put Adrian Reber on CC:, maybe he still remembers why this was
needed).

Anyway, I think we can fix that up as soon as somebody tries to run the
js2x code again (I still have a YDL PowerStation at home somewhere,
maybe I will have enough spare time to reactivate it one day).

And since your changes itself looks fine to me:

Reviewed-by: Thomas Huth <thuth@redhat.com>
