Return-Path: <agl@us.ibm.com>
Subject: Re: [PATCH] powerpc: Introduce address space "slices"
From: Adam Litke <agl@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1172001107.18571.127.camel@localhost.localdomain>
References: <1171867418.18571.3.camel@localhost.localdomain>
	<1172000736.22940.48.camel@localhost.localdomain>
	<1172001107.18571.127.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 14:07:11 -0600
Message-Id: <1172002031.22940.53.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-21 at 06:51 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2007-02-20 at 13:45 -0600, Adam Litke wrote:
> > Your patch drops the pgoff check that prepare_hugepage_range used to
> > check.  The misaligned_offset test in libhugetlbfs identified the
> > problem.  The following patch (applied on top of yours) makes the
> > problem go away.  I am not necessarily suggesting it's the correct
> > fix... just concisely describing the problem.
> 
> Ok, I'll fold that into the patch. Ultimately, when I finally do the
> generic changes, prepare_hugepage_range() will be going away. I will
> either pass pgoff along to slice_g_u_a for it to validate the pgoff, or
> I will let f_ops->mmap() be responsible of checking it. For SPEs, I do
> the pgoff check there. Any reason tht wouldn't work for huge pages ?

Actually, it should be in ->mmap() if you ask me.  In fact, at some
point in history I think it was there.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
