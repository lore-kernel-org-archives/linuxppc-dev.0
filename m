Return-Path: <cl@linux.com>
Received: from smtp103.prem.mail.ac4.yahoo.com
 (smtp103.prem.mail.ac4.yahoo.com [76.13.13.42])
 by ozlabs.org (Postfix) with SMTP id 970A82C0078
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 00:01:17 +1000 (EST)
Date: Mon, 9 Jul 2012 09:01:12 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [PATCH SLAB 1/2 v3] duplicate the cache name in SLUB's saved_alias
 list, SLAB, and SLOB
In-Reply-To: <1341801721.2439.29.camel@ThinkPad-T420>
Message-ID: <alpine.DEB.2.00.1207090859420.27737@router.home>
References: <1341561286.24895.9.camel@ThinkPad-T420>
 <alpine.DEB.2.00.1207060855320.26441@router.home>
 <1341801721.2439.29.camel@ThinkPad-T420>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, Glauber Costa <glommer@parallels.com>,
 Pekka Enberg <penberg@kernel.org>, linux-mm <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Matt Mackall <mpm@selenic.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Wanlong Gao <gaowanlong@cn.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> I was pointed by Glauber to the slab common code patches. I need some
> more time to read the patches. Now I think the slab/slot changes in this
> v3 are not needed, and can be ignored.

That may take some kernel cycles. You have a current issue here that needs
to be fixed.

> >  	down_write(&slub_lock);
> > -	s = find_mergeable(size, align, flags, name, ctor);
> > +	s = find_mergeable(size, align, flags, n, ctor);
> >  	if (s) {
> >  		s->refcount++;
> >  		/*
>
> 		......
> 		up_write(&slub_lock);
> 		return s;
> 	}
>
> Here, the function returns without name string n be kfreed.

That is intentional since the string n is still referenced by the entry
that sysfs_slab_alias has created.

> But we couldn't kfree n here, because in sysfs_slab_alias(), if
> (slab_state < SYS_FS), the name need to be kept valid until
> slab_sysfs_init() is finished adding the entry into sysfs.

Right that is why it is not freed and that is what fixes the issue you
see.
