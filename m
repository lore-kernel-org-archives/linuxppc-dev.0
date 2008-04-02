Return-Path: <jens@de.ibm.com>
From: Jens Osterkamp <jens@de.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] RTAS - adapt procfs interface
Date: Wed, 2 Apr 2008 13:33:22 +0200
References: <200804011512.20834.jens@de.ibm.com>
	<20080401163504.GP7137@localdomain>
In-Reply-To: <20080401163504.GP7137@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804021333.22799.jens@de.ibm.com>
Cc: maxim@de.ibm.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 01 April 2008, Nathan Lynch wrote:
> Jens Osterkamp wrote:
> > 
> > Handling of the proc_dir_entry->count has being changed in 2.6.24-rc5.
> 
> Do you know which commit caused the change?

Yes, we bisected it to the following commit :

commit 5a622f2d0f86b316b07b55a4866ecb5518dd1cf7
Author: Alexey Dobriyan <adobriyan@sw.ru>
Date:   Tue Dec 4 23:45:28 2007 -0800

    proc: fix proc_dir_entry refcounting
    
    Creating PDEs with refcount 0 and "deleted" flag has problems (see below).
    Switch to usual scheme:
    * PDE is created with refcount 1
    * every de_get does +1
    * every de_put() and remove_proc_entry() do -1
    * once refcount reaches 0, PDE is freed.
    
    This elegantly fixes at least two following races (both observed) without
    introducing new locks, without abusing old locks, without spreading
    lock_kernel():

    [...]

Gruß,

Jens

IBM Deutschland Entwicklung GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschäftsführung: Herbert Kircher 
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
