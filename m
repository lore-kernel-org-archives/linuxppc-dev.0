Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E4721A067D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jul 2015 11:42:55 +1000 (AEST)
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EE42C14077F
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Jul 2015 11:42:54 +1000 (AEST)
Received: by pabvl15 with SMTP id vl15so64147495pab.1
 for <linuxppc-dev@ozlabs.org>; Fri, 03 Jul 2015 18:42:52 -0700 (PDT)
Subject: Re: [PATCH SLOF v4 1/4] disk-label: simplify gpt-prep-partition?
 routine
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 thuth@redhat.com, segher@kernel.crashing.org
References: <1435836938-22889-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1435836938-22889-2-git-send-email-nikunj@linux.vnet.ibm.com>
Cc: dvaleev@suse.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55973A15.1040609@ozlabs.ru>
Date: Sat, 4 Jul 2015 11:42:45 +1000
MIME-Version: 1.0
In-Reply-To: <1435836938-22889-2-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2015 09:35 PM, Nikunj A Dadhania wrote:
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

If it does not change SLOF behaviour in any way (and it does not, right?), 
it would be nice to see in the commit log.


> ---
>   slof/fs/packages/disk-label.fs | 41 +++++++++++++++--------------------------
>   1 file changed, 15 insertions(+), 26 deletions(-)
>
> diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
> index fe1c25e..f1f083a 100644
> --- a/slof/fs/packages/disk-label.fs
> +++ b/slof/fs/packages/disk-label.fs
> @@ -352,42 +352,31 @@ CONSTANT /gpt-part-entry
>      drop 0
>   ;
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
>   : gpt-prep-partition? ( -- true|false )
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
> +   dup l@-le     GPT-PREP-PARTITION-1 <> IF drop false EXIT THEN
> +   dup 4 + w@-le GPT-PREP-PARTITION-2 <> IF drop false EXIT THEN
> +   dup 6 + w@-le GPT-PREP-PARTITION-3 <> IF drop false EXIT THEN
> +       8 + x@    GPT-PREP-PARTITION-4 =
>   ;
>
>   : load-from-gpt-prep-partition ( addr -- size )
> -   no-gpt? IF drop FALSE EXIT THEN
> +   no-gpt? IF drop false EXIT THEN
>      debug-disk-label? IF
>         cr ." GPT partition found " cr
>      THEN
>      1 read-sector block gpt>part-entry-lba l@-le
>      block-size * to seek-pos
>      block gpt>part-entry-size l@-le to gpt-part-size
> -   block gpt>num-part-entry l@-le dup 0= IF FALSE EXIT THEN
> +   block gpt>num-part-entry l@-le dup 0= IF false EXIT THEN
>      1+ 1 ?DO
>         seek-pos 0 seek drop
>         block gpt-part-size read drop gpt-prep-partition? IF
> @@ -405,7 +394,7 @@ AA26         CONSTANT GPT-PREP-PARTITION-4
>         THEN
>         seek-pos gpt-part-size i * + to seek-pos
>      LOOP
> -   FALSE
> +   false
>   ;
>
>   \ Extract the boot loader path from a bootinfo.txt file
>


-- 
Alexey
