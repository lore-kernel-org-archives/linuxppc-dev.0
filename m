Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10B952C0108
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 15:10:27 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 10:35:22 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3B159125804E
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 10:41:55 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3P5AEUI9306386
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 10:40:14 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3P5AG4J023955
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 05:10:18 GMT
Message-ID: <5178BAB8.6020001@linux.vnet.ibm.com>
Date: Thu, 25 Apr 2013 10:40:16 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 7/8] powerpc/pseries: Read of-config partition via
 pstore
References: <20130424061807.7341.909.stgit@aruna-ThinkPad-T420>
 <20130424062052.7341.18551.stgit@aruna-ThinkPad-T420>
 <CAGXu5jKCafNaLCOcvo2+eoVGuP0rGP3e_OOg-YdkCFT_zc8k9g@mail.gmail.com>
In-Reply-To: <CAGXu5jKCafNaLCOcvo2+eoVGuP0rGP3e_OOg-YdkCFT_zc8k9g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jkenisto@linux.vnet.ibm.com, Tony Luck <tony.luck@intel.com>,
 mahesh@linux.vnet.ibm.com, Colin Cross <ccross@android.com>,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org, paulus@samba.org,
 anton@samba.org, Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 25 April 2013 02:13 AM, Kees Cook wrote:

Hi Kees,

> On Tue, Apr 23, 2013 at 11:20 PM, Aruna Balakrishnaiah
> <aruna@linux.vnet.ibm.com> wrote:
>> This patch set exploits the pstore subsystem to read details of
>> of-config partition in NVRAM to a separate file in /dev/pstore.
>> For instance, of-config partition details will be stored in a
>> file named [of-nvram-5].
>>
>> Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
>> Reviewed-by: Jim Keniston <jkenisto@us.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/nvram.c |   55 +++++++++++++++++++++++++++-----
>>   fs/pstore/inode.c                      |    3 ++
>>   include/linux/pstore.h                 |    1 +
>>   3 files changed, 50 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
>> index b118382..de448af 100644
>> --- a/arch/powerpc/platforms/pseries/nvram.c
>> +++ b/arch/powerpc/platforms/pseries/nvram.c
>> @@ -132,9 +132,16 @@ static size_t oops_data_sz;
>>   static struct z_stream_s stream;
>>
>>   #ifdef CONFIG_PSTORE
>> +static struct nvram_os_partition of_config_partition = {
>> +       .name = "of-config",
>> +       .index = -1,
>> +       .os_partition = false
>> +};
>> +
>>   static enum pstore_type_id nvram_type_ids[] = {
>>          PSTORE_TYPE_DMESG,
>>          PSTORE_TYPE_RTAS,
>> +       PSTORE_TYPE_OF,
>>          -1
>>   };
>>   static int read_type;
>> @@ -332,10 +339,15 @@ int nvram_read_partition(struct nvram_os_partition *part, char *buff,
>>
>>          tmp_index = part->index;
>>
>> -       rc = ppc_md.nvram_read((char *)&info, sizeof(struct err_log_info), &tmp_index);
>> -       if (rc <= 0) {
>> -               pr_err("%s: Failed nvram_read (%d)\n", __FUNCTION__, rc);
>> -               return rc;
>> +       if (part->os_partition) {
>> +               rc = ppc_md.nvram_read((char *)&info,
>> +                                       sizeof(struct err_log_info),
>> +                                       &tmp_index);
>> +               if (rc <= 0) {
>> +                       pr_err("%s: Failed nvram_read (%d)\n", __FUNCTION__,
>> +                                                                       rc);
>> +                       return rc;
>> +               }
>>          }
>>
>>          rc = ppc_md.nvram_read(buff, length, &tmp_index);
>> @@ -344,8 +356,10 @@ int nvram_read_partition(struct nvram_os_partition *part, char *buff,
>>                  return rc;
>>          }
>>
>> -       *error_log_cnt = info.seq_num;
>> -       *err_type = info.error_type;
>> +       if (part->os_partition) {
>> +               *error_log_cnt = info.seq_num;
>> +               *err_type = info.error_type;
>> +       }
>>
>>          return 0;
>>   }
>> @@ -516,7 +530,7 @@ static int nvram_pstore_write(enum pstore_type_id type,
>>   }
>>
>>   /*
>> - * Reads the oops/panic report and ibm,rtas-log partition.
>> + * Reads the oops/panic report, rtas and of-config partition.
>>    * Returns the length of the data we read from each partition.
>>    * Returns 0 if we've been called before.
>>    */
>> @@ -525,9 +539,11 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
>>                                  struct pstore_info *psi)
>>   {
>>          struct oops_log_info *oops_hdr;
>> -       unsigned int err_type, id_no;
>> +       unsigned int err_type, id_no, size = 0;
>>          struct nvram_os_partition *part = NULL;
>>          char *buff = NULL;
>> +       int sig = 0;
>> +       loff_t p;
>>
>>          read_type++;
>>
>> @@ -542,10 +558,29 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
>>                  time->tv_sec = last_rtas_event;
>>                  time->tv_nsec = 0;
>>                  break;
>> +       case PSTORE_TYPE_OF:
>> +               sig = NVRAM_SIG_OF;
>> +               part = &of_config_partition;
>> +               *type = PSTORE_TYPE_OF;
>> +               *id = PSTORE_TYPE_OF;
>> +               time->tv_sec = 0;
>> +               time->tv_nsec = 0;
>> +               break;
>>          default:
>>                  return 0;
>>          }
>>
>> +       if (!part->os_partition) {
>> +               p = nvram_find_partition(part->name, sig, &size);
>> +               if (p <= 0) {
>> +                       pr_err("nvram: Failed to find partition %s, "
>> +                               "err %d\n", part->name, (int)p);
>> +                       return 0;
>> +               }
>> +               part->index = p;
>> +               part->size = size;
>> +       }
>> +
>>          buff = kmalloc(part->size, GFP_KERNEL);
>>
>>          if (!buff)
>> @@ -557,7 +592,9 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
>>          }
>>
>>          *count = 0;
>> -       *id = id_no;
>> +
>> +       if (part->os_partition)
>> +               *id = id_no;
>>
>>          if (nvram_type_ids[read_type] == PSTORE_TYPE_DMESG) {
>>                  oops_hdr = (struct oops_log_info *)buff;
>> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
>> index ec24f9c..8d4fb65 100644
>> --- a/fs/pstore/inode.c
>> +++ b/fs/pstore/inode.c
>> @@ -327,6 +327,9 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
>>          case PSTORE_TYPE_PPC_RTAS:
>>                  sprintf(name, "rtas-%s-%lld", psname, id);
>>                  break;
>> +       case PSTORE_TYPE_PPC_OF:
>> +               sprintf(name, "of-%s-%lld", psname, id);
>> +               break;
>>          case PSTORE_TYPE_UNKNOWN:
>>                  sprintf(name, "unknown-%s-%lld", psname, id);
>>                  break;
>> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
>> index d7a8fe9..615dc18 100644
>> --- a/include/linux/pstore.h
>> +++ b/include/linux/pstore.h
>> @@ -37,6 +37,7 @@ enum pstore_type_id {
>>          PSTORE_TYPE_FTRACE      = 3,
>>          /* PPC64 partition types */
>>          PSTORE_TYPE_PPC_RTAS    = 4,
>> +       PSTORE_TYPE_PPC_OF      = 5,
>>          PSTORE_TYPE_UNKNOWN     = 255
>>   };
>>
>>
> Should this be named just "PSTORE_TYPE_OF" instead of "...PPC_OF"?

I renamed it from PSTORE_TYPE_OF to PSTORE_TYPE_PPC_OF as per Michael's
suggestion. But I have made a mistake of not changing the new name in nvram.c
file.

Will wait for other review comments and repost the patch.

>
> -Kees
>
> --
> Kees Cook
> Chrome OS Security
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
