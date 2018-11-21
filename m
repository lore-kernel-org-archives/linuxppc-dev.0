Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BD1C04EBA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62743206BB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62743206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430XGL1w82zF3cH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 06:10:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=lvivier@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430XB62xBbzF3bs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 06:06:53 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 85C4630DDBA1;
 Wed, 21 Nov 2018 19:06:51 +0000 (UTC)
Received: from [10.40.204.241] (ovpn-204-241.brq.redhat.com [10.40.204.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 185794530;
 Wed, 21 Nov 2018 19:06:48 +0000 (UTC)
Subject: Re: [PATCH] powerpc/numa: fix hot-added CPU on memory-less node
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
References: <20181114170319.24828-1-lvivier@redhat.com>
 <20181115091948.GA14462@dhcp-9-193-110-205.in.ibm.com>
From: Laurent Vivier <lvivier@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPsLBeAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7zfOwU0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5TGxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT
 460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwvF8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BN
 efdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2NyHfmZlPGE0Nsy7hlebS4liisXOrN3jFz
 asKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqXGcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0
 VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eophoWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFM
 C3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHKXWo+xf9WgtLeby3cfSkEchACrxDrQpj+
 Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunTco1+cKSuRiSCYpBIXZMHCzPgVDjk4viP
 brV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCqkCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6
 z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCmdNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JP
 jfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHBCzkM4rWyRhuVABEBAAHCwV8EGAECAAkF
 AlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtI
 WlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b6WimV64FmlVn17Ri6FgFU3xNt9TTEChq
 AcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2x
 OhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76J21YeRrEW4WDznPyVcDTa+tz++q2S/Bp
 P4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjXEYRWdiCxN7ca5iPml5gLtuvhJMSy36gl
 U6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2TxL8enfx40PrfbDtWwqRID3WY8jLrjKfTd
 R3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPM
 oDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyx
 FCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbLXiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsB
 kmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZD+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <a0ceaa0f-2a05-0db6-2a94-45d150758c34@redhat.com>
Date: Wed, 21 Nov 2018 20:06:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115091948.GA14462@dhcp-9-193-110-205.in.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 21 Nov 2018 19:06:51 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Satheesh Rajendran <satheera@in.ibm.com>,
 linux-kernel@vger.kernel.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 15/11/2018 10:19, Satheesh Rajendran wrote:
> On Wed, Nov 14, 2018 at 06:03:19PM +0100, Laurent Vivier wrote:
>> Trying to hotplug a CPU on an empty NUMA node (without
>> memory or CPU) crashes the kernel when the CPU is onlined.
>>
>> During the onlining process, the kernel calls start_secondary()
>> that ends by calling
>> set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]))
>> that relies on NODE_DATA(nid)->node_zonelists and in our case
>> NODE_DATA(nid) is NULL.
>>
>> To fix that, add the same checking as we already have in
>> find_and_online_cpu_nid(): if NODE_DATA() is NULL, use
>> the first online node.
>>
>> Bug: https://github.com/linuxppc/linux/issues/184
>> Fixes: ea05ba7c559c8e5a5946c3a94a2a266e9a6680a6
>>        (powerpc/numa: Ensure nodes initialized for hotplug)
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  arch/powerpc/mm/numa.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
> 
> This patch causes regression for cold plug numa case(Case 1) and 
> hotplug case + reboot(Case 2) with adding all vcpus into node 0.
> 
> 
> Env: HW: Power8 Host.
> Kernel: 4.20-rc2 + this patch
> 
> Case 1:
> 1. boot a guest with 8 vcpus(all available), spreadout in 4 numa nodes.
> <vcpu placement='static'>8</vcpu>
> ...
>    <numa>
>       <cell id='0' cpus='0-1' memory='4194304' unit='KiB'/>
>       <cell id='1' cpus='2-3' memory='4194304' unit='KiB'/>
>       <cell id='2' cpus='4-5' memory='0' unit='KiB'/>
>       <cell id='3' cpus='6-7' memory='0' unit='KiB'/>
>     </numa>
> 
> 2. Check lscpu --- all vcpus are added to node0 --> NOK
> 
> # lscpu
> Architecture:        ppc64le
> Byte Order:          Little Endian
> CPU(s):              8
> On-line CPU(s) list: 0-7
> Thread(s) per core:  1
> Core(s) per socket:  8
> Socket(s):           1
> NUMA node(s):        4
> Model:               2.1 (pvr 004b 0201)
> Model name:          POWER8 (architected), altivec supported
> Hypervisor vendor:   KVM
> Virtualization type: para
> L1d cache:           64K
> L1i cache:           32K
> NUMA node0 CPU(s):   0-7
> NUMA node1 CPU(s):   
> NUMA node2 CPU(s):   
> NUMA node3 CPU(s): 
> 
> without this patch it was working fine.
> # lscpu
> Architecture:        ppc64le
> Byte Order:          Little Endian
> CPU(s):              8
> On-line CPU(s) list: 0-7
> Thread(s) per core:  1
> Core(s) per socket:  8
> Socket(s):           1
> NUMA node(s):        4
> Model:               2.1 (pvr 004b 0201)
> Model name:          POWER8 (architected), altivec supported
> Hypervisor vendor:   KVM
> Virtualization type: para
> L1d cache:           64K
> L1i cache:           32K
> NUMA node0 CPU(s):   0,1
> NUMA node1 CPU(s):   2,3
> NUMA node2 CPU(s):   4,5
> NUMA node3 CPU(s):   6,7
> 
> 
> Case 2:
> 1. boot a guest with 8 vcpus(2 available, 6 possible), spreadout in 4 numa nodes.
> <vcpu placement='static' current='2'>8</vcpu>
> ...
>    <numa>
>       <cell id='0' cpus='0-1' memory='0' unit='KiB'/>
>       <cell id='1' cpus='2-3' memory='4194304' unit='KiB'/>
>       <cell id='2' cpus='4-5' memory='0' unit='KiB'/>
>       <cell id='3' cpus='6-7' memory='0' unit='KiB'/>
>     </numa>
> 
> 2. Hotplug all vcpus
> # lscpu
> Architecture:        ppc64le
> Byte Order:          Little Endian
> CPU(s):              8
> On-line CPU(s) list: 0-7
> Thread(s) per core:  1
> Core(s) per socket:  8
> Socket(s):           1
> NUMA node(s):        2
> Model:               2.1 (pvr 004b 0201)
> Model name:          POWER8 (architected), altivec supported
> Hypervisor vendor:   KVM
> Virtualization type: para
> L1d cache:           64K
> L1i cache:           32K
> NUMA node0 CPU(s):   0,1,4-7
> NUMA node1 CPU(s):   2,3
> 
> 
> 3. reboot the guest
> # lscpu
> Architecture:        ppc64le
> Byte Order:          Little Endian
> CPU(s):              8
> On-line CPU(s) list: 0-7
> Thread(s) per core:  1
> Core(s) per socket:  8
> Socket(s):           1
> NUMA node(s):        4
> Model:               2.1 (pvr 004b 0201)
> Model name:          POWER8 (architected), altivec supported
> Hypervisor vendor:   KVM
> Virtualization type: para
> L1d cache:           64K
> L1i cache:           32K
> NUMA node0 CPU(s):   0-7
> NUMA node1 CPU(s):
> NUMA node2 CPU(s):
> NUMA node3 CPU(s):
> 
> 
> Without this patch, Case 2 crashes the guest during hotplug, i.e
> issue reported in https://github.com/linuxppc/linux/issues/184
> 
> Regards,
> -Satheesh.
> 
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index 3a048e98a132..1b2d25a3c984 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -483,6 +483,15 @@ static int numa_setup_cpu(unsigned long lcpu)
>>  	if (nid < 0 || !node_possible(nid))
>>  		nid = first_online_node;
>>
>> +	if (NODE_DATA(nid) == NULL) {
>> +		/*
>> +		 * Default to using the nearest node that has memory installed.
>> +		 * Otherwise, it would be necessary to patch the kernel MM code
>> +		 * to deal with more memoryless-node error conditions.
>> +		 */
>> +		nid = first_online_node;
>> +	}
>> +
>>  	map_cpu_to_node(lcpu, nid);
>>  	of_node_put(cpu);
>>  out:
>> -- 
>> 2.17.2
>>
> 

I have worked a while on this problem, and I don't see any easy fix for
that. It seems kernel is not ready to online a memory-less/cpu-less node
when someone hotplug a CPU in it. I think we have to fix several areas
to be able to do that.

Perhaps someone from IBM could have a better view on what we need?

Michael? Nathan?

Thanks,
Laurent
