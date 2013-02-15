Return-Path: <paulus@ozlabs.org>
Date: Fri, 15 Feb 2013 15:46:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] powerpc: Add vm debug code to catch errors
Message-ID: <20130215044641.GA25703@drongo>
References: <a>
 <1360830983-1812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360830983-1812-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360830983-1812-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: phileas-fogg@mail.ru, linuxppc-dev@lists.ozlabs.org, geoff@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 14, 2013 at 02:06:23PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> We need to make sure that we don't have higher bits of kernel effective
> address set. That would result in multiple kernel segments having same
> proto vsid. Add debug code to make sure we capture this.

I'm not sure that WARN_ON is the best way to handle this, since this
code is called from low levels of the MMU management code, and a
WARN_ON will cause a trap that could possibly come at a time when we
can't handle a trap very well.  I think instead these functions should
return a vsid of 0 for bad addresses, and the callers should detect
that case and handle it appropriately, e.g. hash_page() should return
an error.

Paul.
