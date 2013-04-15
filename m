Return-Path: <paulus@ozlabs.org>
Date: Mon, 15 Apr 2013 13:50:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 3/4] powerpc: Don't bolt the hpte in
 kernel_map_linear_page()
Message-ID: <20130415035031.GA7494@iris.ozlabs.ibm.com>
References: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1365733021-28912-4-git-send-email-zhong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365733021-28912-4-git-send-email-zhong@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 12, 2013 at 10:16:59AM +0800, Li Zhong wrote:
> It seems that in kernel_unmap_linear_page(), it only checks whether there
> is a map in the linear_map_hash_slots array, so seems we don't need bolt
> the hpte.

I don't exactly understand your rationale here, but I don't think it's
safe not to have linear mapping pages bolted.  Basically, if a page
will be used in the process of calling hash_page to demand-fault an
HPTE into the hash table, then that page needs to be bolted, otherwise
we can get an infinite recursion of HPT misses.  That includes all
kernel stack pages, among other things, so I think we need to leave
the HPTE_V_BOLTED in there.

Paul.
