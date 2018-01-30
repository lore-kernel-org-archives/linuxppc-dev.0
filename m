Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWBdz33QnzDqpw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 03:28:55 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0UGQRpU065630
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 11:28:52 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fttvc4h14-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 11:28:52 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 30 Jan 2018 16:28:48 -0000
Date: Tue, 30 Jan 2018 08:28:34 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH v10 27/27] mm: display pkey in smaps if
 arch_pkeys_enabled() is true
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
 <1516326648-22775-28-git-send-email-linuxram@us.ibm.com>
 <20180130121611.GC26445@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180130121611.GC26445@dhcp22.suse.cz>
Message-Id: <20180130162834.GB5411@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 30, 2018 at 01:16:11PM +0100, Michal Hocko wrote:
> On Thu 18-01-18 17:50:48, Ram Pai wrote:
> [...]
> > @@ -851,9 +848,13 @@ static int show_smap(struct seq_file *m, void *v, int is_pid)
> >  			   (unsigned long)(mss->pss >> (10 + PSS_SHIFT)));
> >  
> >  	if (!rollup_mode) {
> > -		arch_show_smap(m, vma);
> > +#ifdef CONFIG_ARCH_HAS_PKEYS
> > +		if (arch_pkeys_enabled())
> > +			seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> > +#endif
> >  		show_smap_vma_flags(m, vma);
> >  	}
> > +
> 
> Why do you need to add ifdef here? The previous patch should make
> arch_pkeys_enabled == F when CONFIG_ARCH_HAS_PKEYS=n.

You are right. it need not be wrapped in CONFIG_ARCH_HAS_PKEYS.  I had to do it
because vma_pkey(vma)  is not defined in some architectures.

I will provide a generic vma_pkey() definition for architectures that do 
not support PKEYS.



> Btw. could you
> merge those two patches into one. It is usually much easier to review a
> new helper function if it is added along with a user.


ok.

Thanks,
RP
