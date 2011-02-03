Return-Path: <meador_inge@mentor.com>
Message-ID: <4D4B3A4E.2070106@mentor.com>
Date: Thu, 03 Feb 2011 17:29:18 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/3] powerpc: Removing support for 'protected-sources'
References: <1296697900-14004-1-git-send-email-meador_inge@mentor.com>
	<1296697900-14004-2-git-send-email-meador_inge@mentor.com>
	<201102031656.38222.arnd@arndb.de>
In-Reply-To: <201102031656.38222.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 02/03/2011 09:56 AM, Arnd Bergmann wrote:
> On Thursday 03 February 2011, Meador Inge wrote:
>> In a recent discussion [1, 2] concerning device trees for AMP systems, the
>> question of whether we really need 'protected-sources' arose.  The general
>> consensus was that if you don't want a source to be used, then it should *not*
>> be mentioned in an 'interrupts' property.  If a source really needs to be
>> mentioned, then it should be put in a property other than 'interrupts' with
>> a specific binding for that use case.
>>
>> [1] http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-January/004038.html
>> [2] http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-January/003991.html
>
> That doesn't work in the case that this code was written for:
>
> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg01394.html
>
> The problem is that you don't want the mpic to initialize the interrupt
> line to the default, but instead leave it at whatever the boot firmware
> has set up. Note that interrupt is not listed in any "interrupts"
> property of any of the devices on the CPU interpreting the device
> tree, but it may be mentioned in the device tree that another CPU
> uses to access the same MPIC.
>
> 	Arnd

We touched on that use case before on list.  However, I did a really bad 
job of explaining things in the above patch description.  I understand 
that the sources that are being protected are mentioned in a device tree 
other than the one that actually interprets the 'protected-sources' 
property.

The idea is to try and expand the meaning of the 'no-reset' property to 
cover what 'protected-sources' was taking care of, but without 
explicitly naming the sources.

In the protected sources version of the code, the relevant MPIC 
initialization went something like (in 'mpic_init'):

	for (i = 0; i < mpic->num_sources; i++) {
		/* start with vector = source number, and masked */
		u32 vecpri = MPIC_VECPRI_MASK | i |
			(8 << MPIC_VECPRI_PRIORITY_SHIFT);
		
		/* check if protected */
		if (mpic->protected && test_bit(i, mpic->protected))
			continue;
		/* init hw */
		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION), 1 << cpu);
	}

So unless a particular source was marked as protected, it would get the 
VECPRI and CPU binding initialization.  This is the exact behavior that 
you describe above, Arnd.

In the 'no-reset' model, the initialization looks more like (see PATCH 3 
in the set for the full implementation):

	if (mpic->flags & MPIC_WANTS_RESET) {
		for (i = 0; i < mpic->num_sources; i++) {
			mpic_init_vector(mpic, hw);
		}
	}

So in 'mpic_init' we don't initialize anything and then in 
'mpic_host_map' we lazily do the VECPRI and CPU binding initialization with:

	if (!(mpic->flags & MPIC_WANTS_RESET))
		if (!(mpic_is_ipi(mpic, hw)
			|| mpic_is_timer_interrupt(mpic, hw)))
			mpic_init_vector(mpic, hw);

Thus when 'no-reset' is thrown it ensures that only the sources which 
are mentioned in the device tree are actually initialized.  The net 
effect should be the same as what 'protected-sources' was accomplishing, 
but without having to maintain the list of sources in the property cell.


-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
