Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBBCB1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 17:08:52 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A2092140157
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2015 17:08:52 +1000 (AEST)
Date: Tue, 23 Jun 2015 09:08:43 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF 1/5] disk-label: simplify gpt-prep-partition? routine
Message-ID: <20150623090843.6a4cf0a7@thh440s>
In-Reply-To: <1434959987-8530-2-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1434959987-8530-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1434959987-8530-2-git-send-email-nikunj@linux.vnet.ibm.com>
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

On Mon, 22 Jun 2015 13:29:43 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  slof/fs/packages/disk-label.fs | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
> index fe1c25e..2305eee 100644
> --- a/slof/fs/packages/disk-label.fs
> +++ b/slof/fs/packages/disk-label.fs
> @@ -352,31 +352,21 @@ CONSTANT /gpt-part-entry
>     drop 0
>  ;
>  
> -\ Check for GPT PReP partition GUID
> -9E1A2D38     CONSTANT GPT-PREP-PARTITION-1
> -C612         CONSTANT GPT-PREP-PARTITION-2
> -4316         CONSTANT GPT-PREP-PARTITION-3
> -AA26         CONSTANT GPT-PREP-PARTITION-4
> -8B49521E5A8B CONSTANT GPT-PREP-PARTITION-5
> +\ Check for GPT PReP partition GUID. Only first 3 blocks are
> +\ byte-swapped treating last two blocks as contigous for simplifying
> +\ comparison
> +9E1A2D38            CONSTANT GPT-PREP-PARTITION-1
> +C612                CONSTANT GPT-PREP-PARTITION-2
> +4316                CONSTANT GPT-PREP-PARTITION-3
> +AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>  
>  : gpt-prep-partition? ( -- true|false )
> -   block gpt-part-entry>part-type-guid l@-le GPT-PREP-PARTITION-1 = IF
> -      block gpt-part-entry>part-type-guid 4 + w@-le
> -      GPT-PREP-PARTITION-2 = IF
> -         block gpt-part-entry>part-type-guid 6 + w@-le
> -         GPT-PREP-PARTITION-3 = IF
> -            block gpt-part-entry>part-type-guid 8 + w@
> -            GPT-PREP-PARTITION-4 = IF
> -               block gpt-part-entry>part-type-guid a + w@
> -               block gpt-part-entry>part-type-guid c + l@ swap lxjoin
> -               GPT-PREP-PARTITION-5 = IF
> -                   TRUE EXIT
> -               THEN
> -            THEN
> -         THEN
> -      THEN
> -   THEN
> -   FALSE
> +   block gpt-part-entry>part-type-guid
> +   dup l@-le     GPT-PREP-PARTITION-1 <> IF DROP FALSE EXIT THEN
> +   dup 4 + w@-le GPT-PREP-PARTITION-2 <> IF DROP FALSE EXIT THEN
> +   dup 6 + w@-le GPT-PREP-PARTITION-3 <> IF DROP FALSE EXIT THEN
> +       8 + x@    GPT-PREP-PARTITION-4 <> IF FALSE EXIT THEN
> +   TRUE
>  ;
>  
>  : load-from-gpt-prep-partition ( addr -- size )

Also change DROP, FALSE and TRUE to lowercase, as Segher
suggested with patch 3? Apart from that, looks fine to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
