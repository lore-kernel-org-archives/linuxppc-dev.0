Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VQ641nC0zF3Hw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 02:02:36 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6HFxvbk040569
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 12:02:33 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k9kcm8p2h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 12:02:33 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 17 Jul 2018 17:02:30 +0100
Date: Tue, 17 Jul 2018 09:02:18 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v13 13/24] selftests/vm: pkey register should match
 shadow pkey
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-14-git-send-email-linuxram@us.ibm.com>
 <6246f823-77d9-6727-097e-73f103078a44@intel.com>
MIME-Version: 1.0
In-Reply-To: <6246f823-77d9-6727-097e-73f103078a44@intel.com>
Message-Id: <20180717160218.GC5790@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2018 at 07:53:57AM -0700, Dave Hansen wrote:
> On 06/13/2018 05:45 PM, Ram Pai wrote:
> > +++ b/tools/testing/selftests/vm/protection_keys.c
> > @@ -916,10 +916,10 @@ void expected_pkey_fault(int pkey)
> >  		pkey_assert(last_si_pkey == pkey);
> >  
> >  	/*
> > -	 * The signal handler shold have cleared out PKEY register to let the
> > +	 * The signal handler should have cleared out pkey-register to let the
> >  	 * test program continue.  We now have to restore it.
> >  	 */
> > -	if (__read_pkey_reg() != 0)
> > +	if (__read_pkey_reg() != shadow_pkey_reg)
> >  		pkey_assert(0);
> >  
> >  	__write_pkey_reg(shadow_pkey_reg);
> 
> I think this is wrong on x86.
> 
> When we leave the signal handler, we zero out PKRU so that the faulting
> instruction can continue, that's why we have the check against zero.
> I'm actually kinda surprised this works.

The code is modified to zero out only the violated key in the signal
handler. Hence it works. Have verified it to work on x86 aswell.

RP
