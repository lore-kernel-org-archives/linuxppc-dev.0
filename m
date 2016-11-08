Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tD0Wl6T4BzDvWV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 06:59:31 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA8Jx2Jk124789
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Nov 2016 14:59:29 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26kn6j8had-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 14:59:29 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Tue, 8 Nov 2016 12:59:28 -0700
Date: Tue, 8 Nov 2016 13:59:21 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alistair Popple <apopple@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 4/4] of/fdt: mark hotpluggable memory
References: <1478562276-25539-5-git-send-email-arbab@linux.vnet.ibm.com>
 <201611080920.t1iTxguA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <201611080920.t1iTxguA%fengguang.wu@intel.com>
Message-Id: <20161108195921.5iltumzajxlkpayz@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 08, 2016 at 09:59:26AM +0800, kbuild test robot wrote:
>All errors (new ones prefixed by >>):
>
>   drivers/of/fdt.c: In function 'early_init_dt_scan_memory':
>>> drivers/of/fdt.c:1064:3: error: implicit declaration of function 'memblock_mark_hotplug'
>   cc1: some warnings being treated as errors
>
>vim +/memblock_mark_hotplug +1064 drivers/of/fdt.c
>
>  1058				continue;
>  1059			pr_debug(" - %llx ,  %llx\n", (unsigned long long)base,
>  1060			    (unsigned long long)size);
>  1061	
>  1062			early_init_dt_add_memory_arch(base, size);
>  1063	
>> 1064			if (hotpluggable && memblock_mark_hotplug(base, size))
>  1065				pr_warn("failed to mark hotplug range 0x%llx - 0x%llx\n",
>  1066					base, base + size);
>  1067		}

Ah, I need to adjust for !CONFIG_HAVE_MEMBLOCK. Will correct in v7.

-- 
Reza Arbab
