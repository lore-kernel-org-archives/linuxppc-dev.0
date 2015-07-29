Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C4F61A0960
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 13:05:57 +1000 (AEST)
Received: by pdjr16 with SMTP id r16so82452278pdj.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 20:05:55 -0700 (PDT)
Subject: Re: [SLOF PATCH 2/2] fbuffer: Use a smaller cursor
To: Thomas Huth <thuth@redhat.com>, slof@lists.ozlabs.org,
 nikunj@linux.vnet.ibm.com
References: <1438078795-14360-1-git-send-email-thuth@redhat.com>
 <1438078795-14360-3-git-send-email-thuth@redhat.com>
Cc: gkurz@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55B8430C.8060008@ozlabs.ru>
Date: Wed, 29 Jul 2015 13:05:48 +1000
MIME-Version: 1.0
In-Reply-To: <1438078795-14360-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/28/2015 08:19 PM, Thomas Huth wrote:
> Drawing the cursor in the frame buffer memory is a very, very
> slow operation. So let's simply switch to a "underscore" cursor
> instead of the full block cursor to save some precious cycles.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   slof/fs/fbuffer.fs | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
> index 0128c07..542c431 100644
> --- a/slof/fs/fbuffer.fs
> +++ b/slof/fs/fbuffer.fs
> @@ -98,7 +98,8 @@ CREATE bitmap-buffer 400 4 * allot
>
>   : fb8-toggle-cursor ( -- )
>   	line# fb8-line2addr column# fb8-columns2bytes +
> -	char-height 0 ?DO
> +	char-height 3 - screen-width screen-depth * * +
> +	3 0 ?DO


Why not just:

-	char-height 0 ?DO
+	1 0 ?DO

? What is this magic with screen-width about?


>   		dup char-width screen-depth * invert-region
>   		screen-width screen-depth * +
>   	LOOP drop
>


-- 
Alexey
