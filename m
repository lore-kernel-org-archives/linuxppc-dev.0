Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6bpX4WCPzDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 08:09:24 +1000 (AEST)
Message-ID: <1499810936.2865.32.camel@kernel.crashing.org>
Subject: Re: [RFC v5 12/38] mm: ability to disable execute permission on a
 key at creation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net,
 mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
Date: Wed, 12 Jul 2017 08:08:56 +1000
In-Reply-To: <20170711215105.GA5542@ram.oc3035372033.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-13-git-send-email-linuxram@us.ibm.com>
 <3bd2ffd4-33ad-ce23-3db1-d1292e69ca9b@intel.com>
 <1499808577.2865.30.camel@kernel.crashing.org>
 <20170711215105.GA5542@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-07-11 at 14:51 -0700, Ram Pai wrote:
> On Wed, Jul 12, 2017 at 07:29:37AM +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2017-07-11 at 11:11 -0700, Dave Hansen wrote:
> > > On 07/05/2017 02:21 PM, Ram Pai wrote:
> > > > Currently sys_pkey_create() provides the ability to disable read
> > > > and write permission on the key, at  creation. powerpc  has  the
> > > > hardware support to disable execute on a pkey as well.This patch
> > > > enhances the interface to let disable execute  at  key  creation
> > > > time. x86 does  not  allow  this.  Hence the next patch will add
> > > > ability  in  x86  to  return  error  if  PKEY_DISABLE_EXECUTE is
> > > > specified.
> > 
> > That leads to the question... How do you tell userspace.
> > 
> > (apologies if I missed that in an existing patch in the series)
> > 
> > How do we inform userspace of the key capabilities ? There are at least
> > two things userspace may want to know already:
> > 
> >  - What protection bits are supported for a key
> 
> the userspace is the one which allocates the keys and enables/disables the
> protection bits on the key. the kernel is just a facilitator. Now if the
> use space wants to know the current permissions on a given key, it can
> just read the AMR/PKRU register on powerpc/intel respectively.

You misunderstand. How does userspace knows on a given system whether
execute permission control is supported for keys ?
> 
> > 
> >  - How many keys exist
> 
> There is no standard way of finding this other than trying to allocate
> as many till you fail.  A procfs or sysfs file can be added to expose
> this information.
> 
> > 
> >  - Which keys are available for use by userspace. On PowerPC, the
> > kernel can reserve some keys for itself, so can the hypervisor. In
> > fact, they do.
> 
> this information can be exposed through /proc or /sysfs
> 
> I am sure there will be more demands and requirements as applications
> start leveraging these feature.
> 
> RP
> > 
> > Cheers,
> > Ben.
> 
> 
