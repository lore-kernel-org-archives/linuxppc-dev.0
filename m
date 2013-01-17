Return-Path: <mhocko@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1A7F12C007A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 00:05:18 +1100 (EST)
Date: Thu, 17 Jan 2013 14:05:09 +0100
From: Michal Hocko <mhocko@suse.cz>
To: Lin Feng <linfeng@cn.fujitsu.com>
Subject: Re: [PATCH v3 1/2] memory-hotplug: introduce
 CONFIG_HAVE_BOOTMEM_INFO_NODE and revert register_page_bootmem_info_node()
 when platform not support
Message-ID: <20130117130509.GE20538@dhcp22.suse.cz>
References: <1358324059-9608-1-git-send-email-linfeng@cn.fujitsu.com>
 <1358324059-9608-2-git-send-email-linfeng@cn.fujitsu.com>
 <20130116141436.GE343@dhcp22.suse.cz>
 <50F7D456.9000904@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50F7D456.9000904@cn.fujitsu.com>
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

On Thu 17-01-13 18:37:10, Lin Feng wrote:
[...]
> > I am still not sure I understand the relation to MEMORY_HOTREMOVE.
> > Is register_page_bootmem_info_node required/helpful even if
> > !CONFIG_MEMORY_HOTREMOVE?
> From old kenrel's view register_page_bootmem_info_node() is defined in 
> CONFIG_MEMORY_HOTPLUG_SPARSE, it registers some info for 
> memory hotplug/remove. If we don't use MEMORY_HOTPLUG feature, this
> function is empty, we don't need the info at all.
> So this info is not required/helpful if !CONFIG_MEMORY_HOTREMOVE.

OK, then I suggest moving it under CONFIG_MEMORY_HOTREMOVE guards rather
than CONFIG_MEMORY_HOTPLUG.

> > Also, now that I am thinking about that more, maybe it would
> > be cleaner to put the select into arch/x86/Kconfig and do it
> > same as ARCH_ENABLE_MEMORY_{HOTPLUG,HOTREMOVE} (and name it
> > ARCH_HAVE_BOOTMEM_INFO_NODE).
> > 
> Maybe put it in mm/Kconfig is a better choice, because if one day
> someone implements the register_page_bootmem_info_node() for other
> archs they will get some clues here, that's it has been implemented on
> x86_64.
> But I'm not so sure...

My understanding is that doing that in arch code is more appropriate
because it makes the generic code less complicated. But I do not have
any strong opinion on that. Looking at other ARCH_ENABLE_MEMORY_HOTPLUG
and others suggests that we should be consistent with that.

Thanks!
-- 
Michal Hocko
SUSE Labs
