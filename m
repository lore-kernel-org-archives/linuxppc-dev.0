Return-Path: <glommer@parallels.com>
Received: from mx2.parallels.com (mx2.parallels.com [64.131.90.16])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 804FA2C0328
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 18:14:24 +1100 (EST)
Message-ID: <50EE6A48.7060307@parallels.com>
Date: Thu, 10 Jan 2013 11:14:16 +0400
From: Glauber Costa <glommer@parallels.com>
MIME-Version: 1.0
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v6 00/15] memory-hotplug: hot-remove physical memory
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <20130109142314.1ce04a96.akpm@linux-foundation.org>
 <50EE24A4.8020601@cn.fujitsu.com>
In-Reply-To: <50EE24A4.8020601@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 wency@cn.fujitsu.com, cmetcalf@tilera.com, wujianguo@huawei.com,
 yinghai@kernel.org, laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org,
 minchan.kim@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/10/2013 06:17 AM, Tang Chen wrote:
>>> Note: if the memory provided by the memory device is used by the
>>> kernel, it
>>> can't be offlined. It is not a bug.
>>
>> Right.  But how often does this happen in testing?  In other words,
>> please provide an overall description of how well memory hot-remove is
>> presently operating.  Is it reliable?  What is the success rate in
>> real-world situations?
> 
> We test the hot-remove functionality mostly with movable_online used.
> And the memory used by kernel is not allowed to be removed.

Can you try doing this using cpusets configured to hardwall ?
It is my understanding that the object allocators will try hard not to
allocate anything outside the walls defined by cpuset. Which means that
if you have one process per node, and they are hardwalled, your kernel
memory will be spread evenly among the machine. With a big enough load,
they should eventually be present in all blocks.

Another question I have for you: Have you considering calling
shrink_slab to try to deplete the caches and therefore free at least
slab memory in the nodes that can't be offlined? Is it relevant?
