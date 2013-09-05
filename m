Return-Path: <paulus@ozlabs.org>
Date: Thu, 5 Sep 2013 19:53:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix possible deadlock on page fault
Message-ID: <20130905095316.GA18222@iris.ozlabs.ibm.com>
References: <1378365422-25203-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378365422-25203-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 05, 2013 at 12:47:02PM +0530, Aneesh Kumar K.V wrote:

> @@ -280,6 +280,13 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  
> +	/*
> +	 * We want to do this outside mmap_sem, because reading code around nip
> +	 * can result in fault, which will cause a deadlock when called with
> +	 * mmap_sem held
> +	 */
> +	store_update = store_updates_sp(regs);

We should only call store_updates_sp() if user_mode(regs); that was
the previous behaviour.

Paul.
