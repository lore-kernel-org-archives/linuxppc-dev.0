Subject: RE: TLB and CSSBAR problems with MPC8540 and BDI2000
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: Milliorn Gary-rxcr80 <Gary.Milliorn@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <5725AF6EE9FAD51195DC009027E377020B6562DD@az33exm35.corp.mot.com>
References: 
	 <5725AF6EE9FAD51195DC009027E377020B6562DD@az33exm35.corp.mot.com>
Content-Type: text/plain
Message-Id: <1075305441.1204.22.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Wed, 28 Jan 2004 09:57:21 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-01-14 at 11:19, Milliorn Gary-rxcr80 wrote:

> >
> > Yep.  I have one now.  Make sure your u-boot image also has a TLB1
> > entry for your "default" CCSRBAR.  Further, make sure your BDI init
> > section doesn't move the CCSRBAR from the default value assumed by
> > your u-boot image.  I had the latter correct, just didn't realize
> > that a "TLB1 flash invalidate" command to the MMUCSR0 doesn't seem
> > to honor the 'invalidate protect' in the TLB entry.  Everything
> > works fine when you get all of the ducks in a row :-)
>
>   The TLB1 issue is due to the MPC85x0 errata "CPU4"; there's a s/w
> workaround.  It's nice if BDI fixes it for you, but seems like it would
> not be necessary.
>

	So I have noticed some things, maybe someone here can explain this.
When If configure everything with my bdi2000 and attempt to boot u-boot
my CPU will crash (COP freeze) when I get to the code that implements
the software workaround that was mentioned above.

	However if I do not configure anything with the bdi2000, and boot
u-boot, it will load just fine. I have even removed the code that causes
the crash in u-boot, recompiled u-boot and with those changes u-boot
will not crash the CPU. But, that same u-boot image will not boot if I
do not have the bdi2000 attached.

	So I guess the question is, what could be configured that would cause
this CPU to crash when the code for the errata was executed?

Here is the code for the workaround:

/* invalidate MMU L1/L2 */
/* Note: before invalidate MMU L1/L2, we read TLB1 Entry 0 and then
 * write it back immediately to fixup a bug(Errata CPU4)  for this
initial
 * TLB1 entry 0,otherwise the TLB1 entry 0 will be invalidated.
 */
#if defined(CONFIG_MPC85xx_REV1)
	lis	r2,0x1000
	mtspr	MAS0,r2
	tlbre
	tlbwe
	isync
	li      r2, 0x001e
	mtspr   MMUCSR0, r2
	isync
#endif

--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
