Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 2/2] powerpc: make MPIC honor the "pic-no-reset"
	device tree property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Meador Inge <meador_inge@mentor.com>
In-Reply-To: <4D790901.9000701@mentor.com>
References: <1298671177-19572-1-git-send-email-meador_inge@mentor.com>
	<1298671177-19572-3-git-send-email-meador_inge@mentor.com>
	<1299036140.8833.818.camel@pasglop>  <4D790901.9000701@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Mar 2011 09:11:55 +1100
Message-ID: <1299795115.22236.506.camel@pasglop>
Mime-Version: 1.0
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-03-10 at 11:23 -0600, Meador Inge wrote:
> I agree.  I shouldn't have cached that.  We should probably introduce a 
> helper function to get the cpuid, though.  The:
> 
>         unsigned int cpu = 0;
> 
>         if (mpic->flags & MPIC_PRIMARY)
>                 cpu = hard_smp_processor_id();
> 
> code is scattered in three places: '_mpic_cpu_write', '_mpic_cpu_read', 
> and 'mpic_init'. 

Right, but that code must act on the current CPU, not a cached per-MPIC
variant. Doing a helper to factor the above 2 lines is fine if you wish
to do so but then make it a separate patch.

Cheers,
Ben.
