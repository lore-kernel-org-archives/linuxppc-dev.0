Return-Path: <npiggin@gmail.com>
Date: Wed, 12 Jul 2017 03:09:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org
Subject: Re: [PATCH 1/4] powerpc/powernv: handle the platform error reboot
 in ppc_md.restart
Message-ID: <20170712030952.213e9ad1@roar.ozlabs.ibm.com>
In-Reply-To: <6e0ddb0b-a877-1840-5f7d-e8b06faee6a7@linux.vnet.ibm.com>
References: <20170705040422.20933-1-npiggin@gmail.com>
 <20170705040422.20933-2-npiggin@gmail.com>
 <20170707035611.6a9e60b6@roar.ozlabs.ibm.com>
 <6e0ddb0b-a877-1840-5f7d-e8b06faee6a7@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 10 Jul 2017 11:18:35 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 07/06/2017 11:26 PM, Nicholas Piggin wrote:
> > On Wed,  5 Jul 2017 14:04:19 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote:

> > +	/*
> > +	 * We reached here. There can be three possibilities:
> > +	 * 1. We are running on a firmware level that do not support
> > +	 *    opal_cec_reboot2()
> > +	 * 2. We are running on a firmware level that do not support
> > +	 *    OPAL_REBOOT_PLATFORM_ERROR reboot type.
> > +	 * 3. We are running on FSP based system that does not need
> > +	 *    opal to trigger checkstop explicitly for error analysis.
> > +	 *    The FSP PRD component would have already got notified
> > +	 *    about this error through other channels.
> > +	 */
> > +  
> 
> Not sure if looping forever unconditionally here is better idea. How
> about we check panic_timeout and decide whether to reboot or fall
> through for loop ?
> 
> 	if (panic_timeout != 0)
> 		emergency_restart();
> 
> > +	for (;;)
> > +		;> +}  

Yes that's a good point. What I've done is just to call ppc_md.restart().
To match BMC behaviour, particularly for point #3, I think we expect a
restart here. MCE is not quite the same thing as panic, so I think that's
okay to ignore the panic timeout.

The important thing is the MCE messages will have been sent to Linux
console.

Thanks,
Nick
