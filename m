Return-Path: <dmitry.kasatkin@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tD0gF4djQzDt0m
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 07:06:01 +1100 (AEDT)
Received: by mail-lf0-x241.google.com with SMTP id 98so8438416lfs.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 12:06:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1477017898-10375-5-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1477017898-10375-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1477017898-10375-5-git-send-email-bauerman@linux.vnet.ibm.com>
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Tue, 8 Nov 2016 22:05:57 +0200
Message-ID: <CACE9dm8x1m7Ndrsy=kztbhj41N6yRf9dtvpJ0QLwMf9Ps-=stQ@mail.gmail.com>
Subject: Re: [Linux-ima-devel] [PATCH v6 04/10] ima: maintain memory size
 needed for serializing the measurement list
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
> In preparation for serializing the binary_runtime_measurements, this patch
> maintains the amount of memory required.
>
> Changelog v5:
> - replace CONFIG_KEXEC_FILE with architecture CONFIG_HAVE_IMA_KEXEC (Thiago)
>
> Changelog v3:
> - include the ima_kexec_hdr size in the binary_runtime_measurement size.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/Kconfig     | 12 +++++++++
>  security/integrity/ima/ima.h       |  1 +
>  security/integrity/ima/ima_queue.c | 53 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 5487827fa86c..370eb2f4dd37 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -27,6 +27,18 @@ config IMA
>           to learn more about IMA.
>           If unsure, say N.
>
> +config IMA_KEXEC
> +       bool "Enable carrying the IMA measurement list across a soft boot"
> +       depends on IMA && TCG_TPM && HAVE_IMA_KEXEC
> +       default n
> +       help
> +          TPM PCRs are only reset on a hard reboot.  In order to validate
> +          a TPM's quote after a soft boot, the IMA measurement list of the
> +          running kernel must be saved and restored on boot.
> +
> +          Depending on the IMA policy, the measurement list can grow to
> +          be very large.
> +
>  config IMA_MEASURE_PCR_IDX
>         int
>         depends on IMA
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 51dc8d57d64d..ea1dcc452911 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -143,6 +143,7 @@ void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
>  struct ima_template_desc *ima_template_desc_current(void);
>  int ima_restore_measurement_entry(struct ima_template_entry *entry);
>  int ima_restore_measurement_list(loff_t bufsize, void *buf);
> +unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
>
>  /*
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 12d1b040bca9..3a3cc2a45645 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -29,6 +29,11 @@
>  #define AUDIT_CAUSE_LEN_MAX 32
>
>  LIST_HEAD(ima_measurements);   /* list of all measurements */
> +#ifdef CONFIG_IMA_KEXEC
> +static unsigned long binary_runtime_size;
> +#else
> +static unsigned long binary_runtime_size = ULONG_MAX;
> +#endif
>
>  /* key: inode (before secure-hashing a file) */
>  struct ima_h_table ima_htable = {
> @@ -64,6 +69,24 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
>         return ret;
>  }
>
> +/*
> + * Calculate the memory required for serializing a single
> + * binary_runtime_measurement list entry, which contains a
> + * couple of variable length fields (e.g template name and data).
> + */
> +static int get_binary_runtime_size(struct ima_template_entry *entry)
> +{
> +       int size = 0;
> +
> +       size += sizeof(u32);    /* pcr */
> +       size += sizeof(entry->digest);
> +       size += sizeof(int);    /* template name size field */
> +       size += strlen(entry->template_desc->name);
> +       size += sizeof(entry->template_data_len);
> +       size += entry->template_data_len;
> +       return size;
> +}
> +

strlen returns len without '\0'. I cannot see how you would know how
to read it back?


>  /* ima_add_template_entry helper function:
>   * - Add template entry to the measurement list and hash table, for
>   *   all entries except those carried across kexec.
> @@ -90,9 +113,30 @@ static int ima_add_digest_entry(struct ima_template_entry *entry, int flags)
>                 key = ima_hash_key(entry->digest);
>                 hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
>         }
> +
> +       if (binary_runtime_size != ULONG_MAX) {
> +               int size;
> +
> +               size = get_binary_runtime_size(entry);
> +               binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
> +                    binary_runtime_size + size : ULONG_MAX;
> +       }
>         return 0;
>  }
>
> +/*
> + * Return the amount of memory required for serializing the
> + * entire binary_runtime_measurement list, including the ima_kexec_hdr
> + * structure.
> + */
> +unsigned long ima_get_binary_runtime_size(void)
> +{
> +       if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
> +               return ULONG_MAX;
> +       else
> +               return binary_runtime_size + sizeof(struct ima_kexec_hdr);
> +};
> +
>  static int ima_pcr_extend(const u8 *hash, int pcr)
>  {
>         int result = 0;
> @@ -106,8 +150,13 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
>         return result;
>  }
>
> -/* Add template entry to the measurement list and hash table,
> - * and extend the pcr.
> +/*
> + * Add template entry to the measurement list and hash table, and
> + * extend the pcr.
> + *
> + * On systems which support carrying the IMA measurement list across
> + * kexec, maintain the total memory size required for serializing the
> + * binary_runtime_measurements.
>   */
>  int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>                            const char *op, struct inode *inode,
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
