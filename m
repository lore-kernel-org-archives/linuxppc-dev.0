Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1NV52GnkzDrTw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 03:22:36 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBJGK18b022684
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 11:22:33 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ey5nq1xf5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 11:22:32 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 19 Dec 2017 11:22:31 -0500
Date: Tue, 19 Dec 2017 08:22:21 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-arch@vger.kernel.org, corbet@lwn.net, arnd@arndb.de,
 linux-doc@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, mhocko@kernel.org,
 linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>,
 mingo@redhat.com, paulus@samba.org, ebiederm@xmission.com,
 linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v9 29/51] mm/mprotect, powerpc/mm/pkeys, x86/mm/pkeys:
 Add sysfs interface
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <1509958663-18737-30-git-send-email-linuxram@us.ibm.com>
 <bbc5593e-31ec-183a-01a5-1a253dc0c275@intel.com>
 <20171218221850.GD5461@ram.oc3035372033.ibm.com>
 <e7971d03-6ad1-40d5-9b79-f01242db5293@intel.com>
 <20171218231551.GA5481@ram.oc3035372033.ibm.com>
 <20171219083122.q7ycxg2dfspgzw7z@lt-gp.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219083122.q7ycxg2dfspgzw7z@lt-gp.iram.es>
Message-Id: <20171219162221.GB5481@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 19, 2017 at 09:31:22AM +0100, Gabriel Paubert wrote:
> On Mon, Dec 18, 2017 at 03:15:51PM -0800, Ram Pai wrote:
> > On Mon, Dec 18, 2017 at 02:28:14PM -0800, Dave Hansen wrote:
> > > On 12/18/2017 02:18 PM, Ram Pai wrote:
> > > 
....snip...
> > > > I think on x86 you look for some hardware registers to determine
> > > > which hardware features are enabled by the kernel.
> > > 
> > > No, we use CPUID.  It's a part of the ISA that's designed for
> > > enumerating CPU and (sometimes) OS support for CPU features.
> > > 
> > > > We do not have generic support for something like that on ppc.  The
> > > > kernel looks at the device tree to determine what hardware features
> > > > are available. But does not have mechanism to tell the hardware to
> > > > track which of its features are currently enabled/used by the
> > > > kernel; atleast not for the memory-key feature.
> > > 
> > > Bummer.  You're missing out.
> > > 
> > > But, you could still do this with a syscall.  "Hey, kernel, do you
> > > support this feature?"
> > 
> > or do powerpc specific sysfs interface.
> > or a debugfs interface.
> 
> getauxval(3) ?
> 
> With AT_HWCAP or HWCAP2 as parameter already gives information about
> features supported by the hardware and the kernel.
> 
> Taking one bit to expose the availability of protection keys to
> applications does not look impossible.
> 
> Do I miss something obvious?

No. I am told this is possible aswell.

RP
