Return-Path: <paulus@ozlabs.org>
Date: Sat, 29 Jun 2013 17:43:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2 4/4] powerpc/kvm: Use 256K chunk to track both RMA
 and hash page table allocation.
Message-ID: <20130629074323.GE8687@iris.ozlabs.ibm.com>
References: <1372410662-3748-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1372410662-3748-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372410662-3748-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, mina86@mina86.com,
 linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 28, 2013 at 02:41:02PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Both RMA and hash page table request will be a multiple of 256K. We can use
> a chunk size of 256K to track the free/used 256K chunk in the bitmap. This
> should help to reduce the bitmap size.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Looks good overall, just some minor comments below:

> +	int chunk_count, nr_chunk;

I get a little nervous when I see "int" used for variables storing a
number of pages or related things such as chunks.  Yes, int is enough
today but one day it won't be, and there is no time or space penalty
to using "long" instead, and in fact the code generated "long"
variables can be slightly shorter.  So please make variables like this
"long".  (That will require changes to earlier patches in this
series.)

> +	 * aling mask with chunk size. The bit tracks pages in chunk size

Should be "align".

Paul.
