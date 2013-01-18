Return-Path: <linfeng@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 030172C007B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 18:59:37 +1100 (EST)
Message-ID: <50F900A3.4060903@cn.fujitsu.com>
Date: Fri, 18 Jan 2013 15:58:27 +0800
From: Lin Feng <linfeng@cn.fujitsu.com>
MIME-Version: 1.0
To: Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v3 1/2] memory-hotplug: introduce
 CONFIG_HAVE_BOOTMEM_INFO_NODE
 and revert register_page_bootmem_info_node() when platform not support
References: <1358324059-9608-1-git-send-email-linfeng@cn.fujitsu.com>
 <1358324059-9608-2-git-send-email-linfeng@cn.fujitsu.com>
 <20130116141436.GE343@dhcp22.suse.cz> <50F7D456.9000904@cn.fujitsu.com>
 <20130117130509.GE20538@dhcp22.suse.cz>
In-Reply-To: <20130117130509.GE20538@dhcp22.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ia64@vger.kernel.org, aquini@redhat.com, heiko.carstens@de.ibm.com,
 tangchen@cn.fujitsu.com, dhowells@redhat.com, paul.gortmaker@windriver.com,
 paulus@samba.org, jbeulich@suse.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org, isimatu.yasuaki@jp.fujitsu.com,
 mingo@redhat.com, gerald.schaefer@de.ibm.com, fenghua.yu@intel.com,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, mel@csn.ul.ie, tglx@linutronix.de,
 kamezawa.hiroyu@jp.fujitsu.com, tony.luck@intel.com, laijs@cn.fujitsu.com,
 linux-mm@kvack.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 minchan@kernel.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michal,

On 01/17/2013 09:05 PM, Michal Hocko wrote:
> On Thu 17-01-13 18:37:10, Lin Feng wrote:
> [...]
>>> > > I am still not sure I understand the relation to MEMORY_HOTREMOVE.
>>> > > Is register_page_bootmem_info_node required/helpful even if
>>> > > !CONFIG_MEMORY_HOTREMOVE?
>> > From old kenrel's view register_page_bootmem_info_node() is defined in 
>> > CONFIG_MEMORY_HOTPLUG_SPARSE, it registers some info for 
>> > memory hotplug/remove. If we don't use MEMORY_HOTPLUG feature, this
>> > function is empty, we don't need the info at all.
>> > So this info is not required/helpful if !CONFIG_MEMORY_HOTREMOVE.
> OK, then I suggest moving it under CONFIG_MEMORY_HOTREMOVE guards rather
> than CONFIG_MEMORY_HOTPLUG.
I can't agree more ;-) 
I also find that page_isolation.c selected by MEMORY_ISOLATION under MEMORY_HOTPLUG
is also such case, I fix it by the way.

thanks,
linfeng
> 
