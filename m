Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBCFF1A1079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 17:10:03 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 88C0B1401AD
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2015 17:10:03 +1000 (AEST)
Date: Tue, 23 Jun 2015 09:09:57 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF 2/5] introduce 8-byte LE helpers
Message-ID: <20150623090957.6ce52982@thh440s>
In-Reply-To: <1434959987-8530-3-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1434959987-8530-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1434959987-8530-3-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 22 Jun 2015 13:29:44 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  slof/fs/little-endian.fs       | 6 ++++++
>  slof/fs/packages/disk-label.fs | 4 ++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/slof/fs/little-endian.fs b/slof/fs/little-endian.fs
> index f2e4e8d..6b4779e 100644
> --- a/slof/fs/little-endian.fs
> +++ b/slof/fs/little-endian.fs
> @@ -17,6 +17,9 @@ here c@ ef = CONSTANT ?littleendian
>  
>  ?bigendian [IF]
>  
> +: x!-le >r xbflip r> x! ;
> +: x@-le x@ xbflip ;
> +
>  : l!-le  >r lbflip r> l! ;
>  : l@-le  l@ lbflip ;
>  
> @@ -47,6 +50,9 @@ here c@ ef = CONSTANT ?littleendian
>  
>  [ELSE]
>  
> +: x!-le x! ;
> +: x@-le x@ ;
> +
>  : l!-le  l! ;
>  : l@-le  l@ ;
>  
> diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
> index 2305eee..2cf1b85 100644
> --- a/slof/fs/packages/disk-label.fs
> +++ b/slof/fs/packages/disk-label.fs
> @@ -384,8 +384,8 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>           debug-disk-label? IF
>              ." GPT PReP partition found " cr
>           THEN
> -         block gpt-part-entry>first-lba x@ xbflip
> -         block gpt-part-entry>last-lba x@ xbflip
> +         block gpt-part-entry>first-lba x@-le
> +         block gpt-part-entry>last-lba x@-le
>           over - 1+                 ( addr offset len )
>           swap                      ( addr len offset )
>           block-size * to part-offset

Reviewed-by: Thomas Huth <thuth@redhat.com>
