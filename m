Return-Path: <julian.calaby@gmail.com>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B67D2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2013 09:27:13 +1100 (EST)
Received: by mail-la0-f43.google.com with SMTP id eg20so728677lab.30
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 14:27:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1358247267-18089-2-git-send-email-tangchen@cn.fujitsu.com>
References: <1358247267-18089-1-git-send-email-tangchen@cn.fujitsu.com>
 <1358247267-18089-2-git-send-email-tangchen@cn.fujitsu.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 16 Jan 2013 09:26:49 +1100
Message-ID: <CAGRGNgWCdvWhp=9+PDRbC9bK100BdBv9kpcsqoM-J6ipq22Szw@mail.gmail.com>
Subject: Re: [BUG Fix Patch 1/6] Bug fix: Hold spinlock across find|remove
 /sys/firmware/memmap/X operation.
To: Tang Chen <tangchen@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, cmetcalf@tilera.com,
 glommer@parallels.com, wujianguo@huawei.com, yinghai@kernel.org,
 laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org, minchan.kim@gmail.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tang,

One minor point.

On Tue, Jan 15, 2013 at 9:54 PM, Tang Chen <tangchen@cn.fujitsu.com> wrote:
> It is unsafe to return an entry pointer and release the map_entries_lock. So we should
> not hold the map_entries_lock separately in firmware_map_find_entry() and
> firmware_map_remove_entry(). Hold the map_entries_lock across find and remove
> /sys/firmware/memmap/X operation.
>
> And also, users of these two functions need to be careful to hold the lock when using
> these two functions.
>
> The suggestion is from Andrew Morton <akpm@linux-foundation.org>
>
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> ---
>  drivers/firmware/memmap.c |   25 +++++++++++++++++--------
>  1 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
> index 4211da5..940c4e9 100644
> --- a/drivers/firmware/memmap.c
> +++ b/drivers/firmware/memmap.c
> @@ -188,23 +188,28 @@ static inline void remove_sysfs_fw_map_entry(struct firmware_map_entry *entry)
>  }
>
>  /*
> - * Search memmap entry
> + * firmware_map_find_entry: Search memmap entry.
> + * @start: Start of the memory range.
> + * @end:   End of the memory range (exclusive).
> + * @type:  Type of the memory range.
> + *
> + * This function is to find the memmap entey of a given memory range.
> + * The caller must hold map_entries_lock, and must not release the lock
> + * until the processing of the returned entry has completed.
> + *
> + * Return pointer to the entry to be found on success, or NULL on failure.

Why not make this completely kernel-doc compliant as you're already
re-writing the comment?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
