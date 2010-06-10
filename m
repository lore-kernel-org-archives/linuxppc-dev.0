Return-Path: <paulus@ozlabs.org>
Date: Thu, 10 Jun 2010 22:40:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 5/5] PPC64-HWBKPT: Discard extraneous interrupt due to
	accesses outside symbol length
Message-ID: <20100610124024.GA28613@brick.ozlabs.ibm.com>
References: <20100609101417.644628763@linux.vnet.ibm.com>
	<20100609102559.GF20332@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100609102559.GF20332@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 09, 2010 at 03:55:59PM +0530, K.Prasad wrote:

> +	if (!((bp->attr.bp_addr <= dar) &&
> +	     (dar <= (bp->attr.bp_addr + bp->attr.bp_len)))) {
> +		/*
> +		 * This exception is triggered not because of a memory access
> +		 * on the monitored variable but in the double-word address
> +		 * range in which it is contained. We will consume this
> +		 * exception, considering it as 'noise'.
> +		 */
> +		info->extraneous_interrupt = true;
> +	}

Ummm, don't you need to add "else info->extraneous_interrupt = false;"
here?  I don't see anywhere that you ever clear it otherwise.

Also, I think you need to do the "if (!info->extraneous_interrupt)"
check around the call to perf_bp_event() later on in
hw_breakpoint_handler() as well as around the call in
single_step_dabr_instruction().

Paul.
