Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VQMC2G4PzF3J2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 02:13:49 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6HGACuu088063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 12:13:47 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k9k3x9y9h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 12:13:47 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 17 Jul 2018 17:13:45 +0100
Date: Tue, 17 Jul 2018 09:13:32 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v13 19/24] selftests/vm: associate key on a mapped page
 and detect access violation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-20-git-send-email-linuxram@us.ibm.com>
 <048b1de9-85f8-22ff-a31a-b06a382769bb@intel.com>
MIME-Version: 1.0
In-Reply-To: <048b1de9-85f8-22ff-a31a-b06a382769bb@intel.com>
Message-Id: <20180717161332.GH5790@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2018 at 08:16:44AM -0700, Dave Hansen wrote:
> On 06/13/2018 05:45 PM, Ram Pai wrote:
> > +void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
> > +		u16 pkey)
> > +{
> > +	int ptr_contents;
> > +
> > +	dprintf1("disabling access to PKEY[%02d], doing read @ %p\n",
> > +				pkey, ptr);
> > +	ptr_contents = read_ptr(ptr);
> > +	dprintf1("reading ptr before disabling the read : %d\n",
> > +			ptr_contents);
> > +	read_pkey_reg();
> > +	pkey_access_deny(pkey);
> > +	ptr_contents = read_ptr(ptr);
> > +	dprintf1("*ptr: %d\n", ptr_contents);
> > +	expected_pkey_fault(pkey);
> > +}
> 
> Looks fine to me.  I'm a bit surprised we didn't do this already, which
> is a good thing for this patch.
> 
> FWIW, if you took patches like this and put them first, you could
> probably get it merged now.  Yes, I know it would mean redoing some of
> the later code move and rename ones.

I have incorporated almost all of your comments. But there are some
comments that take some effort to implement. Shall we get the patches
merged in the current form?  This code has been sitting out for a while.

In the current form its tested and works on powerpc and on x86, and
incorporates about 95% of your suggestions. The rest I will take care
as we go.

-- 
Ram Pai
