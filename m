Return-Path: <pantelis.antoniou@gmail.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 5EF87679FC
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 00:55:57 +1000 (EST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
Date: Sat, 1 Jul 2006 17:50:03 +0300
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net>
	<20060701102557.GA14013@lst.de>
	<C4F75531-D046-42EF-AAF7-D45B84DA1720@kernel.crashing.org>
In-Reply-To: <C4F75531-D046-42EF-AAF7-D45B84DA1720@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607011750.05019.pantelis.antoniou@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"linux-kernel@vger.kernel.org mailing list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 01 July 2006 17:34, Kumar Gala wrote:
> 
> On Jul 1, 2006, at 5:25 AM, Christoph Hellwig wrote:
> 
> > On Sat, Jul 01, 2006 at 05:21:06PM +1000, Benjamin Herrenschmidt  
> > wrote:
> >> On Sat, 2006-07-01 at 14:35 +0800, Linux powerpc wrote:
> >>> Yes, it was used for allocating dual port RAM for CPM.  And now  
> >>> we are
> >>> adding QE support to powerpc arch which need to use rheap(QE is next
> >>> generation for CPM).  Please see the patches I <leoli@freescale.com>
> >>> just posted for 8360epb support.  Moreover, previous CPM support is
> >>> adding to powerpc arch too.
> >>
> >> Ok, well, I don't have anything specifically against that code, I was
> >> just wondering if it may not duplicate something we already have (yet
> >> another space allocator basically)...
> >
> > Yepp.  Without looking at the rheap allocator in deatail, any reason
> > it can't use lib/genalloc.c?
> 
> Doing a quick glance at lib/genalloc.c I dont see any reason we  
> couldn't use it.  However, Panto will know best, since he wrote rheap.
> 
> - k
> 

Hi there,

RHEAP started life long before on 2.4 before genalloc was included in the kernel.
The difference is only in the implementation, rheap uses double linked lists
while genalloc uses per pool bitmaps. RHEAP is faster & conserves a bit more space 
since it doesn't use a bitmap to track the chunks.

Since genalloc is the blessed linux thing it might be best to use that & remove
rheap completely. Oh well...

Regards

Pantelis
