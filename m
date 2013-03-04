Return-Path: <paulus@ozlabs.org>
Date: Mon, 4 Mar 2013 16:13:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V1 07/24] powerpc: Add size argument to pgtable_cache_add
Message-ID: <20130304051340.GC27523@drongo>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1361865914-13911-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361865914-13911-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 26, 2013 at 01:34:57PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> We will use this later with THP changes to request for pmd table of double the size.
> THP code does PTE page allocation along with large page request and deposit them
> for later use. This is to ensure that we won't have any failures when we split
> huge pages to regular pages.
> 
> On powerpc we want to use the deposited PTE page for storing hash pte slot and
> secondary bit information for the HPTEs. Hence we save them in the second half
> of the pmd table.

Looks OK, but you should explain why you made the wholesale change of
"shift" to "index".  Is there some important semantic difference, or
do you just prefer the "index" name for some reason?

Paul.
