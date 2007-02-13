Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 1/3] spufs: remove need for struct page for
	SPEs
Date: Tue, 13 Feb 2007 13:15:33 +0100
References: <20070213004616.90897DDF0D@ozlabs.org>
In-Reply-To: <20070213004616.90897DDF0D@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702131315.34438.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 13 February 2007 01:46, Benjamin Herrenschmidt wrote:
> This patch removes the need for struct page for SPE local store
> and registers from spufs. It also makes the locking much more
> obvious and no longer relying on the truncate logic black magic
> for protecting against races between unmap_mapping_range() and
> new pages faulted in. It does so by switching to a nopfn() handler
> and using the new vm_insert_pfn() to setup the PTEs itself while
> holding a lock on the SPE.
> 
> The nice thing is that this patch actually removes a lot more code
> than it adds :-)
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
