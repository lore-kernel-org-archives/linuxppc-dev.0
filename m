Return-Path: <dmitry.kasatkin@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tD0GC0B13zDvTd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 06:47:47 +1100 (AEDT)
Received: by mail-lf0-x244.google.com with SMTP id 98so8405906lfs.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 11:47:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1477017898-10375-4-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1477017898-10375-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1477017898-10375-4-git-send-email-bauerman@linux.vnet.ibm.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Tue, 8 Nov 2016 21:47:42 +0200
Message-ID: <CACE9dm-ev-5uTrP5C=mFAgJVA0A2Hhp+_-ewRSfKyFmGcF9N8Q@mail.gmail.com>
Subject: Re: [Linux-ima-devel] [PATCH v6 03/10] ima: permit duplicate
 measurement list entries
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-ima-devel <linux-ima-devel@lists.sourceforge.net>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 21, 2016 at 5:44 AM, Thiago Jung Bauermann
<bauerman@linux.vnet.ibm.com> wrote:
> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
>
> Measurements carried across kexec need to be added to the IMA
> measurement list, but should not prevent measurements of the newly
> booted kernel from being added to the measurement list. This patch
> adds support for allowing duplicate measurements.
>
> The "boot_aggregate" measurement entry is the delimiter between soft
> boots.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/ima_queue.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 4b1bb7787839..12d1b040bca9 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -65,11 +65,12 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
>  }
>
>  /* ima_add_template_entry helper function:
> - * - Add template entry to measurement list and hash table.
> + * - Add template entry to the measurement list and hash table, for
> + *   all entries except those carried across kexec.
>   *
>   * (Called with ima_extend_list_mutex held.)
>   */
> -static int ima_add_digest_entry(struct ima_template_entry *entry)
> +static int ima_add_digest_entry(struct ima_template_entry *entry, int flags)
>  {
>         struct ima_queue_entry *qe;
>         unsigned int key;
> @@ -85,8 +86,10 @@ static int ima_add_digest_entry(struct ima_template_entry *entry)
>         list_add_tail_rcu(&qe->later, &ima_measurements);
>
>         atomic_long_inc(&ima_htable.len);
> -       key = ima_hash_key(entry->digest);
> -       hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
> +       if (flags) {

It looks lile "bool", not flags in fact.


> +               key = ima_hash_key(entry->digest);
> +               hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
> +       }
>         return 0;
>  }
>
> @@ -126,7 +129,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>                 }
>         }
>
> -       result = ima_add_digest_entry(entry);
> +       result = ima_add_digest_entry(entry, 1);
>         if (result < 0) {
>                 audit_cause = "ENOMEM";
>                 audit_info = 0;
> @@ -155,7 +158,7 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry)
>         int result = 0;
>
>         mutex_lock(&ima_extend_list_mutex);
> -       result = ima_add_digest_entry(entry);
> +       result = ima_add_digest_entry(entry, 0);
>         mutex_unlock(&ima_extend_list_mutex);
>         return result;
>  }
> --
> 2.7.4
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-ima-devel mailing list
> Linux-ima-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-ima-devel



-- 
Thanks,
Dmitry
