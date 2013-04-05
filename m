Return-Path: <paulus@ozlabs.org>
Date: Fri, 5 Apr 2013 13:50:25 +1100
From: Paul Mackerras <paulus@samba.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 2/6] powerpc: Exception hooks for context tracking
 subsystem
Message-ID: <20130405025025.GB22465@drongo>
References: <1364551221-23177-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1364551221-23177-3-git-send-email-zhong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364551221-23177-3-git-send-email-zhong@linux.vnet.ibm.com>
Cc: fweisbec@gmail.com, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 29, 2013 at 06:00:17PM +0800, Li Zhong wrote:
> This is the exception hooks for context tracking subsystem, including
> data access, program check, single step, instruction breakpoint, machine check,
> alignment, fp unavailable, altivec assist, unknown exception, whose handlers
> might use RCU.
> 
> This patch corresponds to
> [PATCH] x86: Exception hooks for userspace RCU extended QS
>   commit 6ba3c97a38803883c2eee489505796cb0a727122
> 
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>

Is there a reason why you didn't put the exception_exit() call in
ret_from_except_lite in entry_64.S, and the exception_entry() call in
EXCEPTION_PROLOG_COMMON?  That would seem to catch all these cases in
a more centralized place.

Also, I notice that with the exception_exit calls where they are, we
can still deliver signals (thus possibly taking a page fault) or call
schedule() for preemption after the exception_exit() call.  Is that
OK, or is it a potential problem?

Paul.
