Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [patch 01/11] powerpc/cell: add support for power
	button of future IBM cell blades
Date: Mon, 7 Jul 2008 10:40:20 +0200
References: <20080704190535.316377278@arndb.de>
	<20080704190805.638836822@arndb.de>
	<20080707152445.d76bea70.sfr@canb.auug.org.au>
In-Reply-To: <20080707152445.d76bea70.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807071040.20417.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Christian Krafft <krafft@de.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 July 2008, Stephen Rothwell wrote:

> > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Was this written by you or Christian?

It's from Christian. For some reason, the author is reflected correctly
in my git tree, but git-format-patch/quilt-mail must have lost that
information. I need to check my scripts.
 
> > @@ -105,10 +110,21 @@ static int cbe_system_reset_exception(struct pt_regs *regs)
> >  		 */
> >  		if (sysreset_hack && (cpu = smp_processor_id()) == 0) {
> >  			pmd = cbe_get_cpu_pmd_regs(cpu);
> > -			if (in_be64(&pmd->ras_esc_0) & 0xffff) {
> > +			if (in_be64(&pmd->ras_esc_0) & 0x0000ffff) {
> >  				out_be64(&pmd->ras_esc_0, 0);
> >  				return 0;
> >  			}
> > +			if (in_be64(&pmd->ras_esc_0) & 0x00010000) {
> 
> Do we really want to read that register twice?  (Just asking, I don't
> know how the hardware works ...)  Also, do we want to recognise this bit
> even if some lower order bits are set?  (this code won't)

It would probably be cleaner to read it just once, but it's safe to
read it multiple times. It only gets written by the BMC when a button
gets pressed.

The lower bits are for system-reset, i.e. for entering xmon or kdump,
while the higher bits are for soft power off, and we certainly don't want
to trigger a soft powerp off at the same time as an xmon entry.

	Arnd <><
