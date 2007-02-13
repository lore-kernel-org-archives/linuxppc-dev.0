Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 3/3] spufs: Fix bitrot of the SPU mmap
	facility
Date: Tue, 13 Feb 2007 13:16:34 +0100
References: <20070213004618.82B78DDEE2@ozlabs.org>
In-Reply-To: <20070213004618.82B78DDEE2@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702131316.35365.arnd@arndb.de>
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
> It looks like we've had some serious bitrot there mostly due to tracking
> of address_space's of mmap'ed files getting out of sync with the actual
> mmap code. The mfc, mss and psmap were not tracked properly and thus
> not invalidated on context switches (oops !)
> 
> I also removed the various file->f_mapping = inode->i_mapping;
> assignments that were done in the other open() routines since that
> is already done for us by __dentry_open.
> 
> One improvement we might want to do later is to assign the various
> ctx-> fields at mmap time instead of file open/close time so that we
> don't call unmap_mapping_range() on thing that have not been mmap'ed
> 
> Finally, I added some smp_wmb's after assigning the ctx-> fields to make
> sure they are visible to other CPUs. I don't think this is really
> necessary as I suspect locking in the fs layer will make that happen
> anyway but better safe than sorry.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
